/*
	Purpose: creates a new chain of correct type, enters given ID as first chain IDList value
*/
function scr_newChain(ID) {
	
	if (obj_toolPane.currentMode == obj_toolPane.modeRead) exit;
	if (obj_control.mouseoverBackArrowStopClick || obj_control.mouseoverBackArrow) exit;
	
	show_debug_message("ID before: " + string(ID));
	var idSubMap = global.nodeMap[? ID];
	if (!scr_isNumericAndExists(idSubMap, ds_type_map)) exit;
	var idType = idSubMap[? "type"];
	show_debug_message("ID after: " + string(ID));
	
	show_debug_message("scr_newChain... ID: " + string(ID));

	var chainName = "";
	var chainType = "";
	
	// determine what type of chain this will be
	if (idType == "token" || idType == "chunk") {
		if (obj_toolPane.currentMode == obj_toolPane.modeRez) chainType = "resonance";
		else if (obj_toolPane.currentMode == obj_toolPane.modeTrack) chainType = "trail";
	}
	else if (idType == "unit") chainType = "stack";

	var aligned = false;
	var chainInCliqueID = "";
	var _layerMap = undefined;
	
	// get chainList, navList, and layerMap relevant to this type
	var _activeLayer = "";
	var chainListKey = "resonanceList";
	var chainNavListKey = "resonanceNavList";
	if (chainType == "resonance") {
		chainListKey = "resonanceList";
		chainNavListKey = "resonanceNavList";
		_activeLayer = obj_control.activeResonanceLayer;
		_layerMap = global.resonanceLayerMap[? _activeLayer];
	}
	else if (chainType == "trail") {
		chainListKey = "trailList";
		chainNavListKey = "trailNavList";
		_activeLayer = obj_control.activeTrailLayer;
		_layerMap = global.trailLayerMap[? _activeLayer];
	}
	else if (chainType == "stack") {
		chainListKey = "stackList";
		chainNavListKey = "stackNavList";
		_activeLayer = obj_control.activeStacking;
		_layerMap = global.stackingMap[? _activeLayer];
		show_debug_message("obj_control.activeStacking: " + string(obj_control.activeStacking));
	}
	var chainList = global.nodeMap[? chainListKey];
	var chainNavList = global.nodeMap[? chainNavListKey];
	
	// if layerMap is not valid, then let's spawn a new layer right now
	if (!scr_isNumericAndExists(_layerMap, ds_type_map)) {		
		var _activeLayerName = is_string(_activeLayer) && _activeLayer != "" ? _activeLayer : "_Default";
		scr_createNewLayer(_activeLayerName, chainType);
		if (chainType == "resonance") _layerMap = global.resonanceLayerMap[? obj_control.activeResonanceLayer];
		else if (chainType == "trail") _layerMap = global.trailLayerMap[? obj_control.activeTrailLayer];
		else if (chainType == "stack") _layerMap = global.stackingMap[? obj_control.activeStacking];
	}
	
	// attempt to get chainSeq from layer map, and create the field if it doesn't exist
	var chainSeq = _layerMap[? "chainSeq"];
	if (!is_numeric(chainSeq)) chainSeq = ds_list_size(chainNavList);
	chainSeq++;
	_layerMap[? "chainSeq"] = chainSeq;

	// set up chain variables depending on chainType
	if (chainType == "resonance") {
		aligned = true;
		obj_chain.rezChainNameCounter++;
		chainName = "Rez " + string(chainSeq);
		if (obj_control.shapeStartText) {
			obj_control.shapeStartText = false;
			obj_control.shape = obj_control.shapeBlock;
		}
	}
	else if (chainType == "trail") {
		obj_chain.trackChainNameCounter++;
		chainName = "Trail " + string(chainSeq);
	}
	else if (chainType == "stack") {
		var stackNamePt1 = "";
		var stackNamePt2 = string(chainSeq);
		if (obj_control.activeStacking == "Default") stackNamePt1 = scr_get_translation("tab_name_stack");
		else {
			// let's check the active stacking stackName
			var activeStackingSubMap = global.stackingMap[? obj_control.activeStacking];
			if (scr_isNumericAndExists(activeStackingSubMap, ds_type_map)) {
				var activeStackingStackName = activeStackingSubMap[? "stackName"];
				if (is_string(activeStackingStackName)) {
					stackNamePt1 = activeStackingStackName;
				}
				else {
					var activeStackingName = activeStackingSubMap[? "name"];
					if (is_string(activeStackingName)) {
						stackNamePt1 = activeStackingName;
					}
				}
			}
		}
		
		chainName = stackNamePt1 + " " + stackNamePt2;
		show_debug_message("newChain, stack name: " + string(chainName));
	}
	
	// get random hex chainID
	obj_chain.currentChainID = scr_addToNodeMap(chainType);
	var newChainSubMap = global.nodeMap[? obj_chain.currentChainID];
	show_debug_message("scr_newChain... chainID: " + string(obj_chain.currentChainID) + ", chainType: " + string(chainType) + ", chainName:" + string(chainName));
	
	// add this new chain to chainList and chainNavList
	ds_list_add(chainList, obj_chain.currentChainID);
	ds_list_add(chainNavList, obj_chain.currentChainID);
	
	with (obj_chain) {
		if (chainType == "resonance") resonancePrevFocused = currentFocusedChainID;
		else if (chainType == "trail") trailPrevFocused = currentFocusedChainID;
		else if (chainType == "stack") stackPrevFocused = currentFocusedChainID;
	}
	
	
	// if this is a token and we're making a rez chain, we will put the chain into a clique
	if (obj_toolPane.currentMode == obj_toolPane.modeRez) {
		var unitID = "";
		if (idType == "token") {
			unitID = idSubMap[? "unit"];
		}
		else if (idType == "chunk") {
			var firstToken = scr_getFirstWordOfChunk(ID);
			show_debug_message("scr_newChain, chunk firstToken: " + string(firstToken));
			if (is_string(firstToken) && firstToken != "") {
				var firstTokenSubMap = global.nodeMap[? firstToken];
				unitID = firstTokenSubMap[? "unit"];
			}
		}

		if (is_string(unitID) && unitID != "") {
			var unitSubMap = global.nodeMap[? unitID];
			var unitInCliqueID = unitSubMap[? "inClique"];
			if (is_string(unitInCliqueID) && unitInCliqueID != "") {
				// the new chain should continue the clique this unit is in
				chainInCliqueID = unitInCliqueID;
				with (obj_chain) newChainRefreshClique = chainInCliqueID;
			}
			else {
				// the new chain should create a new clique
				chainInCliqueID = scr_newClique(obj_chain.currentChainID, unitID);
				unitSubMap[? "inClique"] = chainInCliqueID;
			}
			show_debug_message("scr_newChain, unitInCliqueID: " + string(unitInCliqueID));
		}
	}
	
	
	// if user is doing a quickstack, and they are starting the quickstack on a unit that is not in a chain, and this is the first chain being made, let's save this chain
	show_debug_message("dragStartOriginalChain: " + string(obj_chain.dragStartOriginalChain));
	if (chainType == "stack" && obj_chain.dragStartOriginalChain == "") {
		obj_chain.dragStartOriginalChain = obj_chain.currentChainID;
		show_debug_message("...dragStartOriginalChain: " + string(obj_chain.dragStartOriginalChain));
	}


	var chainColor = scr_randomChainColor();
	
	// set values in nodeMap
	scr_nodeMapSetChainValues(obj_chain.currentChainID, chainName, chainColor, chainSeq);
	
	// add chainType-specific fields
	if (chainType == "stack") {
		newChainSubMap[? "caption"] = "";
		newChainSubMap[? "stackType"] = "";
		newChainSubMap[? "stacking"] = obj_control.activeStacking;
	}
	else if (chainType == "resonance") {
		newChainSubMap[? "inClique"] = chainInCliqueID;
		newChainSubMap[? "layer"] = obj_control.activeResonanceLayer;
		show_debug_message("newChain, chainInCliqueID: " + string(chainInCliqueID));
	}
	else if (chainType == "trail") {
		newChainSubMap[? "layer"] = obj_control.activeTrailLayer;
	}

	obj_chain.currentFocusedChainID = obj_chain.currentChainID;


	if (global.steamAPI) {
		if (!steam_get_achievement("SA_chain")) {
			steam_set_achievement("SA_chain");
		}
	}

}
