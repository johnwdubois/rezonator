function scr_changeActiveLayer(_layerType, _layerID) {
	
	show_debug_message("scr_changeActiveLayer, _layerType: " + string(_layerType) + ", _layerID: " + string(_layerID));
	
	// make sure we have a non-empty string
	if (!is_string(_layerID) || _layerID == "") {
		exit;
	}
	
	// check if making new layer
	if (_layerID == "option_new-stacking" || _layerID == "option_new-trail-layer") {
		
		// create dialog box to ask for new layer name
		if (!instance_exists(obj_dialogueBox)) {
			var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			with (inst) inputWindowActive = true;
			with (obj_control) {
				if (_layerType == "stack") createNewLayer = "NewStacking";
				else if (_layerType == "trail") createNewLayer = "NewTrailLayer";
			}
		}
	}
	else {
	
		// deselect any focused chain
		scr_chainDeselect();
	
		// _layerType should be "stack"/"trail"
		var _chainList = undefined;
		var _navList = undefined;
		var _layerFieldName = "";
		if (_layerType == "stack") {
			_chainList = global.nodeMap[? "stackList"];
			_navList = global.nodeMap[? "stackNavList"];
			_layerFieldName = "stacking";
		}
		else if (_layerType == "trail") {
			_chainList = global.nodeMap[? "trailList"];
			_navList = global.nodeMap[? "trailNavList"];
			_layerFieldName = "layer";
		}
	
		// let's also clear the filter/hide/selected lists
		scr_setValueForAllChains(_layerType, false, "selected", false);
		scr_setValueForAllChains(_layerType, false, "filter", false);
		scr_setValueForAllChains(_layerType, false, "visible", true);
	
		// let's clear the navList so we only see chains of the new layer
		ds_list_clear(_navList);
	
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
				_chainLayer = "Default";
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
				if (_chainLayer == _layerID) {
					scr_addToListOnce(_inChainsList, _chainID);
				}
				else {
					scr_deleteFromList(_inChainsList, _chainID);
				}
			}
			
			// if this chain's layer is being activated, we will show it in the nav window
			if (_chainLayer == _layerID) {
				scr_addToListOnce(_navList, _chainID);
			}
		}
		
		// set this stacking to be the active stacking
		with (obj_control) {
			if (_layerType == "stack") activeStacking = _layerID;
			else if (_layerType == "trail") activeTrailLayer = _layerID;
		}
	}
}