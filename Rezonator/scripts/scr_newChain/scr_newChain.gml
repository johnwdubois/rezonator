/*
	Purpose: creates a new chain of correct type, enters given ID as first chain IDList value
*/

function scr_newChain(ID) {
	
	if(obj_toolPane.currentMode == obj_toolPane.modeRead) exit;
	
	
	show_debug_message("ID before: " + string(ID));
	var idSubMap = global.nodeMap[? ID];
	if (!scr_isNumericAndExists(idSubMap, ds_type_map)) exit;
	var idType = idSubMap[? "type"];
	show_debug_message("ID after: " + string(ID));
	
	show_debug_message("scr_newChain() ... ID: " + string(ID));

	var chainName = "";
	var chainSeq = 0;
	var chainType = "";

	var aligned = false;


	// set up chain variables depending on what type of ID is passed in
	if (idType == "token" || idType == "chunk") {
		if (obj_toolPane.currentMode == obj_toolPane.modeRez) {
			aligned = true;
			obj_chain.rezChainNameCounter++;
			chainSeq = obj_chain.rezChainNameCounter;
			chainName = "Rez " + string(obj_chain.rezChainNameCounter);
			chainType = "rezChain";
			if(obj_control.shapeStartText == true) {
				obj_control.shapeStartText = false;
				obj_control.shape = obj_control.shapeBlock;
			}
		}
		else if (obj_toolPane.currentMode == obj_toolPane.modeTrack) {
			obj_chain.trackChainNameCounter++;
			chainSeq = obj_chain.trackChainNameCounter;
			chainName = "Trail " + string(obj_chain.trackChainNameCounter);
			chainType = "trackChain";
		}
	}
	else if (idType == "unit") {
		obj_chain.stackChainNameCounter++;
		chainSeq = obj_chain.stackChainNameCounter;
		chainName = "Stack " + string(obj_chain.stackChainNameCounter);
		chainType = "stackChain";	
	}

	
	show_debug_message("scr_newChain() ... chainType: " + string(chainType) + ", chainName:" + string(chainName));
	
	
	

	// get random hex chainID
	obj_chain.currentChainID = scr_addToNodeMap(chainType);
	var newChainSubMap = global.nodeMap[? obj_chain.currentChainID];
	
	// get list of chains from nodeMap and add to it
	var listOfChainsKey = "rezChainList";
	if (chainType == "rezChain") listOfChainsKey = "rezChainList";
	else if (chainType == "trackChain") listOfChainsKey = "trackChainList";
	else if (chainType == "stackChain") listOfChainsKey = "stackChainList";
	var listOfChains = global.nodeMap[? listOfChainsKey];
	ds_list_add(listOfChains, obj_chain.currentChainID);


	var chainColor = ds_list_find_value(obj_chain.chainColorList, obj_chain.chainColorID[obj_toolPane.currentTool]);
	
	obj_chain.chainColorID[obj_toolPane.currentTool]++;

	if (obj_chain.chainColorID[obj_toolPane.currentTool] >= ds_list_size(obj_chain.chainColorList)) {
		obj_chain.chainColorID[obj_toolPane.currentTool] = 0;
	}
	
	// set values in nodeMap
	scr_nodeMapSetChainValues(obj_chain.currentChainID, chainName, chainColor, chainSeq);
	
	// add stack-specific fields
	if (chainType == "stackChain") {
		ds_map_add(newChainSubMap, "caption", "");
		ds_map_add(newChainSubMap, "stackType", obj_control.activeStackType);
	}

	obj_chain.currentFocusedChainID = obj_chain.currentChainID;

	with (obj_panelPane) {
		functionChainContents_scrollRangeMin[functionChainList_currentTab] = 0;
		functionChainContents_scrollRangeMax[functionChainList_currentTab] = functionChainContents_maxScrollRange;
	}

	with (obj_panelPane) {
		var willHop = (functionChainList_currentTab == functionChainList_tabRezBrush && obj_toolPane.currentMode == obj_toolPane.modeRez)
		or (functionChainList_currentTab == functionChainList_tabTrackBrush && obj_toolPane.currentMode == obj_toolPane.modeTrack)
		or (functionChainList_currentTab == functionChainList_tabStackBrush && obj_toolPane.currentMode != obj_toolPane.modeRead)
		
		if (currentFunction == functionChainList and willHop) {
			alarm[4] = 2;
		}
	}


}
