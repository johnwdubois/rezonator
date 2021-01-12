/*
	scr_newChain(wordID, unitID);
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: creates a new chain of correct type, enters given ID as first chain IDList value
	
	Mechanism: check obj_toolPane for current tool, add new row to corresponding chainGrid
	
	Author: Terry DuBois
*/

function scr_newChain(wordID, unitID) {

	var chainGrid = currentChainGrid;
	var chainName = "";
	var chainSeq = 0;
	var chainType = "";

	var aligned = false;

	// switch panel pane tab to corresponding tool
	switch (obj_toolPane.currentTool) {
		case obj_toolPane.toolRezBrush:
			with (obj_panelPane) {
				functionChainList_currentTab = functionChainList_tabRezBrush;
			}
			aligned = true;
			rezChainNameCounter++;
			chainSeq = rezChainNameCounter;
			chainName = currentChainName + " " + string(rezChainNameCounter);
			chainType = "rezChain";
			if(obj_control.shapeStartText == true) {
				obj_control.shapeStartText = false;
				obj_control.shape = obj_control.shapeBlock;
			}
			break;
		case obj_toolPane.toolTrackBrush:
			with (obj_panelPane) {
				functionChainList_currentTab = functionChainList_tabTrackBrush;
			}
			trackChainNameCounter++;
			chainSeq = trackChainNameCounter;
			chainName = currentChainName + " " + string(trackChainNameCounter);
			chainType = "trackChain";
			break;
		case obj_toolPane.toolStackBrush:
			if (ds_grid_height(obj_chain.unitInStackGrid) < ds_grid_height(obj_control.unitGrid)) {
				exit;
			}
			with (obj_panelPane) {
				functionChainList_currentTab = functionChainList_tabStackBrush;
			}
			stackChainNameCounter++;
			chainSeq = stackChainNameCounter;
			chainName = currentChainName + " " + string(stackChainNameCounter);
			chainType = "stackChain";
			break;
		case obj_toolPane.toolPlaceChains:
			placeChainNameCounter++;
			chainSeq = placeChainNameCounter;
			chainName = currentChainName + " " + string(placeChainNameCounter);
			chainType = "placeChain";
		default:
			exit;
	}

	// get random hex chainID
	obj_chain.currentChainID = scr_addToNodeMap(chainType);

	// resize the chainGrid properly (the stackChainGrid gets +5 width because of Caption, StackType, and tag columns)
	var currentChainGridWidth = (chainGrid == obj_chain.stackChainGrid) ? chainGridWidth + 5 : chainGridWidth;
	ds_grid_resize(chainGrid, currentChainGridWidth, ds_grid_height(chainGrid) + 1);
	var currentRowChainGrid = ds_grid_height(chainGrid) - 1;
	
	// get list of chains from nodeMap and add to it
	var listOfChainsKey = "rezChainList";
	if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) listOfChainsKey = "trackChainList";
	else if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) listOfChainsKey = "stackChainList";
	var listOfChains = ds_map_find_value(global.nodeMap, listOfChainsKey);
	ds_list_add(listOfChains, obj_chain.currentChainID);
	

	var wordIDList = ds_list_create();

	// if we are creating a stack, add the new stack to unitInStackGrid
	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
		ds_list_add(wordIDList, unitID);
	
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1, obj_chain.currentChainID);
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, unitID - 1, obj_control.activeStackType);
		if (not obj_control.quickStackAbleToInitiate) {
			obj_control.moveCounter++;
		}
	}
	else {
		ds_list_add(wordIDList, wordID);
	}


	// unfocus all other chains of this tier
	while (ds_grid_value_exists(chainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(chainGrid), chainStateFocus)) {
		var index = ds_grid_value_y(chainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(chainGrid), chainStateFocus);	
		ds_grid_set(chainGrid, chainGrid_colChainState, index, chainStateNormal);
	}


	var chainColor = ds_list_find_value(chainColorList, chainColorID[obj_toolPane.currentTool]);

	chainColorID[obj_toolPane.currentTool]++;

	if (chainColorID[obj_toolPane.currentTool] >= ds_list_size(chainColorList)) {
		chainColorID[obj_toolPane.currentTool] = 0;
	}

	// enter default values for chainGrid
	ds_grid_set(chainGrid, chainGrid_colChainID, currentRowChainGrid, currentChainID);
	ds_grid_set(chainGrid, chainGrid_colChainState, currentRowChainGrid, chainStateFocus);
	ds_grid_set(chainGrid, chainGrid_colWordIDList, currentRowChainGrid, wordIDList);
	ds_grid_set(chainGrid, chainGrid_colName, currentRowChainGrid, chainName);
	ds_grid_set(chainGrid, chainGrid_colColor, currentRowChainGrid, chainColor);
	ds_grid_set(chainGrid, chainGrid_colInFilter, currentRowChainGrid, false);
	ds_grid_set(chainGrid, chainGrid_colAlign, currentRowChainGrid, aligned);
	ds_grid_set(chainGrid, chainGrid_colAuthor, currentRowChainGrid, global.userName);
	ds_grid_set(chainGrid, chainGrid_colChainSeq, currentRowChainGrid, chainSeq);
	
	// set values in nodeMap
	scr_nodeMapSetChainValues(currentChainID, wordIDList, chainName, chainColor);
	
	
	
	if (chainGrid == obj_chain.stackChainGrid) {
		ds_grid_set(chainGrid, chainGrid_colCaption, currentRowChainGrid, "");
		ds_grid_set(chainGrid, chainGrid_colStackType, currentRowChainGrid, obj_control.activeStackType);
		stackChainGridRowToCaption = currentRowChainGrid;
		alarm[10] = 2;
	}

	currentFocusedChainID = currentChainID;
	var newTop = currentRowChainGrid + 1;
	with(obj_panelPane) {
		currentTopViewRow = ((newTop - 2) > 2) ? (newTop - 2) : 0;	
	}

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
