/*
	scr_newChain(wordID, unitID);
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: creates a new chain of correct type, enters given ID as first chain IDList value
	
	Mechanism: check obj_toolPane for current tool, add new row to corresponding chainGrid
	
	Author: Terry DuBois
*/

function scr_newChain(wordID, unitID) {
	
	show_debug_message("scr_newChain() ... wordID: " + string(wordID) + ", unitID: " + string(unitID));

	var chainName = "";
	var chainSeq = 0;
	var chainType = "";

	var aligned = false;

	// switch panel pane tab to corresponding tool
	switch (obj_toolPane.currentTool) {
		case obj_toolPane.toolRezBrush:
			with (obj_panelPane) {
				//functionChainList_currentTab = functionChainList_tabRezBrush;
			}
			aligned = true;
			rezChainNameCounter++;
			chainSeq = rezChainNameCounter;
			chainName = "Rez " + string(rezChainNameCounter);
			chainType = "rezChain";
			if(obj_control.shapeStartText == true) {
				obj_control.shapeStartText = false;
				obj_control.shape = obj_control.shapeBlock;
			}
			break;
		case obj_toolPane.toolTrackBrush:
			with (obj_panelPane) {
				//functionChainList_currentTab = functionChainList_tabTrackBrush;
			}
			trackChainNameCounter++;
			chainSeq = trackChainNameCounter;
			chainName = "Track " + string(trackChainNameCounter);
			chainType = "trackChain";
			break;
		case obj_toolPane.toolStackBrush:
			if (ds_grid_height(obj_chain.unitInStackGrid) < ds_grid_height(obj_control.unitGrid)) {
				exit;
			}
			with (obj_panelPane) {
				//functionChainList_currentTab = functionChainList_tabStackBrush;
			}
			stackChainNameCounter++;
			chainSeq = stackChainNameCounter;
			chainName = "Stack " + string(stackChainNameCounter);
			chainType = "stackChain";
			break;
		case obj_toolPane.toolPlaceChains:
			placeChainNameCounter++;
			chainSeq = placeChainNameCounter;
			chainName = "Place " + string(placeChainNameCounter);
			chainType = "placeChain";
		default:
			exit;
	}

	// get random hex chainID
	obj_chain.currentChainID = scr_addToNodeMap(chainType);
	var newChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentChainID);
	
	// get list of chains from nodeMap and add to it
	var listOfChainsKey = "rezChainList";
	if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) listOfChainsKey = "trackChainList";
	else if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) listOfChainsKey = "stackChainList";
	var listOfChains = ds_map_find_value(global.nodeMap, listOfChainsKey);
	ds_list_add(listOfChains, obj_chain.currentChainID);

	// if we are creating a stack, add the new stack to unitInStackGrid
	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
	
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1, obj_chain.currentChainID);
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, unitID - 1, obj_control.activeStackType);
		if (not obj_control.quickStackAbleToInitiate) {
			obj_control.moveCounter++;
		}
	}


	var chainColor = ds_list_find_value(chainColorList, chainColorID[obj_toolPane.currentTool]);

	chainColorID[obj_toolPane.currentTool]++;

	if (chainColorID[obj_toolPane.currentTool] >= ds_list_size(chainColorList)) {
		chainColorID[obj_toolPane.currentTool] = 0;
	}
	
	// set values in nodeMap
	scr_nodeMapSetChainValues(obj_chain.currentChainID, chainName, chainColor, chainSeq);
	
	
	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
		ds_map_add(newChainSubMap, "caption", "");
		ds_map_add(newChainSubMap, "stackType", obj_control.activeStackType);
	}

	obj_chain.currentFocusedChainID = obj_chain.currentChainID;

	with (obj_panelPane) {
		functionChainContents_scrollRangeMin[functionChainList_currentTab] = 0;
		functionChainContents_scrollRangeMax[functionChainList_currentTab] = functionChainContents_maxScrollRange;
	}

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			alarm[4] = 2;
		}
	}


}
