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
	var chainSeq = 0;
	var chainType = "";

	var aligned = false;
	var chainInCliqueID = "";


	// set up chain variables depending on what type of ID is passed in
	if (idType == "token" || idType == "chunk") {
		if (obj_toolPane.currentMode == obj_toolPane.modeRez) {
			aligned = true;
			obj_chain.rezChainNameCounter++;
			chainSeq = obj_chain.rezChainNameCounter;
			chainName = "Rez " + string(chainSeq);
			chainType = "resonance";
			if (obj_control.shapeStartText == true) {
				obj_control.shapeStartText = false;
				obj_control.shape = obj_control.shapeBlock;
			}
		}
		else if (obj_toolPane.currentMode == obj_toolPane.modeTrack) {
			obj_chain.trackChainNameCounter++;
			chainSeq = obj_chain.trackChainNameCounter;
			chainName = "Trail " + string(chainSeq);
			chainType = "trail";
		}
	}
	else if (idType == "unit") {
		obj_chain.stackChainNameCounter++;
		chainSeq = obj_chain.stackChainNameCounter;
		chainType = "stack";
		
		show_debug_message("newChain, stackerName: " + string(obj_stacker.stackerName))
		if (is_string(obj_stacker.stackerName) && obj_stacker.stackerName != "" && is_numeric(obj_stacker.stackerNameNum)) {
			// if we are making stacks through the stacker, we use the stacker's naming convention
			chainName = obj_stacker.stackerName + " " + string(obj_stacker.stackerNameNum);
			with (obj_stacker) stackerNameNum++;
		}
		else {
			// otherwise we use default naming convention
			chainName = "Stack " + string(chainSeq);
		}
	}
	
	// get random hex chainID
	obj_chain.currentChainID = scr_addToNodeMap(chainType);
	var newChainSubMap = global.nodeMap[? obj_chain.currentChainID];
	
	show_debug_message("scr_newChain... chainID: " + string(obj_chain.currentChainID) + ", chainType: " + string(chainType) + ", chainName:" + string(chainName));
	
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
	
	// get list of chains from nodeMap and add to it
	var listOfChainsKey = "resonanceList";
	if (chainType == "resonance") listOfChainsKey = "resonanceList";
	else if (chainType == "trail") listOfChainsKey = "trailList";
	else if (chainType == "stack") listOfChainsKey = "stackList";
	var listOfChains = global.nodeMap[? listOfChainsKey];
	ds_list_add(listOfChains, obj_chain.currentChainID);

	var chainColor = scr_randomChainColor();
	
	// set values in nodeMap
	scr_nodeMapSetChainValues(obj_chain.currentChainID, chainName, chainColor, chainSeq);
	
	// add chainType-specific fields
	if (chainType == "stack") {
		ds_map_add(newChainSubMap, "caption", "");
		ds_map_add(newChainSubMap, "stackType", obj_control.activeStackType);
	}
	else if (chainType == "resonance") {
		ds_map_add(newChainSubMap, "inClique", chainInCliqueID);
		show_debug_message("newChain, chainInCliqueID: " + string(chainInCliqueID));
	}

	obj_chain.currentFocusedChainID = obj_chain.currentChainID;


	with (obj_panelPane) {
		var willHop = (functionChainList_currentTab == functionChainList_tabRezBrush && obj_toolPane.currentMode == obj_toolPane.modeRez)
		or (functionChainList_currentTab == functionChainList_tabTrackBrush && obj_toolPane.currentMode == obj_toolPane.modeTrack)
		or (functionChainList_currentTab == functionChainList_tabStackBrush && obj_toolPane.currentMode != obj_toolPane.modeRead)
		
		if (currentFunction == functionChainList and willHop) {
			alarm[4] = 2;
		}
	}
	if (global.steamAPI) {
		if (!steam_get_achievement("SA_chain")) {
			steam_set_achievement("SA_chain");
		}
	}

}
