function scr_changeActiveLayer(_layerType, _layerID) {
	
	show_debug_message("scr_changeActiveLayer, _layerType: " + string(_layerType) + ", _layerID: " + string(_layerID));
	
	// make sure we have a non-empty string
	if (!is_string(_layerID) || _layerID == "") {
		exit;
	}
	
	// make sure this is not already the active layer for this type
	if ((_layerType == "stack" && _layerID == obj_control.activeStacking)
	|| (_layerType == "trail" && _layerID == obj_control.activeTrailLayer)
	|| (_layerType == "resonance" && _layerID == obj_control.activeResonanceLayer)) {
		show_debug_message("scr_changeActiveLayer, this later is already active");
		exit;
	}
	
	// check if making new layer
	if (_layerID == "option_new-stacking" || _layerID == "option_new-trail-layer" || _layerID == "option_new-resonance-layer") {
		
		// create dialog box to ask for new layer name
		if (!instance_exists(obj_dialogueBox)) {
			var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			with (inst) inputWindowActive = true;
			with (obj_control) {
				if (_layerType == "stack") createNewLayer = "NewStacking";
				else if (_layerType == "trail") createNewLayer = "NewTrailLayer";
				else if (_layerType == "resonance") createNewLayer = "NewResonanceLayer";
			}
		}
	}
	else {
	
		// deselect any focused chain
		scr_chainDeselect();
	
		// _layerType should be "stack"/"trail"
		var _layerMap = undefined;
		var _chainList = undefined;
		var _navList = undefined;
		var _layerFieldName = "";
		if (_layerType == "stack") {
			_chainList = global.nodeMap[? "stackList"];
			_navList = global.nodeMap[? "stackNavList"];
			_layerFieldName = "stacking";
			_layerMap = global.stackingMap;
		}
		else if (_layerType == "trail") {
			_chainList = global.nodeMap[? "trailList"];
			_navList = global.nodeMap[? "trailNavList"];
			_layerFieldName = "layer";
			_layerMap = global.trailLayerMap;
		}
		else if (_layerType == "resonance") {
			_chainList = global.nodeMap[? "resonanceList"];
			_navList = global.nodeMap[? "resonanceNavList"];
			_layerFieldName = "layer";
			_layerMap = global.resonanceLayerMap;
		}
	
		// let's also clear the filter/hide/selected lists
		scr_setValueForAllChains(_layerType, false, "selected", false);
		scr_setValueForAllChains(_layerType, false, "filter", false);
		scr_setValueForAllChains(_layerType, false, "visible", true);
	
		// let's clear the navList so we only see chains of the new layer
		ds_list_clear(_navList);
		
		// find the default layer for this layer type
		var _defaultLayer = scr_findDefaultLayer(_layerMap);
	
		// now, we need to clear any references to chains that are no longer of the active layer
		var _chainListSize = ds_list_size(_chainList);
		for (var i = 0; i < _chainListSize; i++) {
			
			// get current chain
			var _chainID = _chainList[| i];
			var _chainSubMap = global.nodeMap[? _chainID];
			if (!scr_isNumericAndExists(_chainSubMap, ds_type_map)) continue;
			
			// let's examine what layer this chain is on
			// if this chain doesn't have a layer, let's set it to default
			var _chainLayer = _chainSubMap[? _layerFieldName];
			if (!is_string(_chainLayer)) {
				_chainLayer = _defaultLayer;
				_chainSubMap[? _layerFieldName] = _chainLayer;
			}
			
			// loop through entries in this chain to edit their units' inChainsLists
			var _setIDList = _chainSubMap[? "setIDList"];
			var _setIDListSize = ds_list_size(_setIDList);
			for (var j = 0; j < _setIDListSize; j++) {
				var _entryID = _setIDList[| j];
				var _entrySubMap = global.nodeMap[? _entryID];
			
				// we need to get an inChainsList, which may be from a unit or token
				var  _entryTokenOrUnitID = "";
				if (_layerType == "stack") _entryTokenOrUnitID = _entrySubMap[? "unit"];
				else _entryTokenOrUnitID = _entrySubMap[? "token"];
				var _entryTokenOrUnitSubMap = global.nodeMap[? _entryTokenOrUnitID];
				var _inChainsList = _entryTokenOrUnitSubMap[? "inChainsList"];
				
				// add or delete the chain from the inChainsList, depending on active layer
				if (scr_isNumericAndExists(_inChainsList, ds_type_list)) {
					if (_chainLayer == _layerID) {
						scr_addToListOnce(_inChainsList, _chainID);
					}
					else {
						scr_deleteFromList(_inChainsList, _chainID);
					}
				}
				
				// for tokens, we also must get take this entry out of the token's inEntryList
				if (_layerType == "resonance" || _layerType == "trail") {
					var _inEntryList = _entryTokenOrUnitSubMap[? "inEntryList"];
					if (scr_isNumericAndExists(_inEntryList, ds_type_list)) {
						if (_chainLayer == _layerID) {
							scr_addToListOnce(_inEntryList, _entryID);
						}
						else {
							scr_deleteFromList(_inEntryList, _entryID);
						}
					}
				}
			}
			
			// if this chain's layer is being activated, we will show it in the nav window
			if (_chainLayer == _layerID) {
				scr_addToListOnce(_navList, _chainID);
			}
		}
		
		// set this layer to be the active layer
		with (obj_control) {
			if (_layerType == "stack") activeStacking = _layerID;
			else if (_layerType == "trail") activeTrailLayer = _layerID;
			else if (_layerType == "resonance") {
				activeResonanceLayer = _layerID;
				
				// get rid of any references from units to cliques
				var _docSubMap = global.nodeMap[? global.discourseNode];
				var _unitList = _docSubMap[? "unitList"];
				scr_setValueForAllNodesInList(_unitList, "inClique", "");
				
				// let's move everything in cliqueMap and cliqueList to the inactiveLayers equivalents
				// and then we will find the clique data that is in the relevant layer and bring it in
				var _cliqueList = obj_chain.cliqueList;
				var _cliqueListSize = ds_list_size(_cliqueList);
				for (var i = 0; i < _cliqueListSize; i++) {
					var _cliqueID = _cliqueList[| i];
					var _cliqueSubMap = global.cliqueMap[? _cliqueID];
					scr_addToListOnce(obj_chain.cliqueList_inactiveLayers, _cliqueID);
					ds_map_add_map(global.cliqueMap_inactiveLayers, _cliqueID, _cliqueSubMap);
					ds_map_delete(global.cliqueMap, _cliqueID);
				}
				
				ds_list_clear(_cliqueList);
				
				// at this point, cliqueMap and cliqueList are empty, so let's fill them up with cliques from the new active layer
				var _cliqueList_inactiveLayers = obj_chain.cliqueList_inactiveLayers;
				var _cliqueListSize_inactiveLayers = ds_list_size(_cliqueList_inactiveLayers);
				for (var i = 0; i < _cliqueListSize_inactiveLayers; i++) {
					var _cliqueID = _cliqueList_inactiveLayers[| i];
					var _cliqueSubMap = global.cliqueMap_inactiveLayers[? _cliqueID];
					if (scr_isNumericAndExists(_cliqueSubMap, ds_type_map)) {
						var _cliqueLayer = _cliqueSubMap[? "layer"];
						if (_cliqueLayer == _layerID) {
							
							// if this clique is in the new active layer, we will bring it into cliqueList and cliqueMap
							scr_addToListOnce(_cliqueList, _cliqueID);
							ds_map_add_map(global.cliqueMap, _cliqueID, _cliqueSubMap);
							
							// we will also update the "inClique" field for units in this clique
							var _cliqueUnitList = _cliqueSubMap[? "unitList"];
							var _cliqueUnitListSize = ds_list_size(_cliqueUnitList);
							for (var j = 0; j < _cliqueUnitListSize; j++) {
								var _cliqueUnitID = _cliqueUnitList[| j];
								var _cliqueUnitSubMap = global.nodeMap[? _cliqueUnitID];
								if (scr_isNumericAndExists(_cliqueUnitSubMap, ds_type_map)) {
									_cliqueUnitSubMap[? "inClique"] = _cliqueID;
								}
							}
						}
					}
				}
				
				scr_refreshAlignment();
			}
		}
		
		// if we are changing stack layers, let's also refresh the tree list
		if (_layerType == "stack") scr_refreshTreeNavList();
		
		with (obj_chain) currentFocusedChainID = "";
	}
}