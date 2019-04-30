/*
	scr_newChainItem(wordID, unitID, chainGridRow);
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: add clicked word or line to current open chain
	
	Mechanism: open up current chain's IDList and add to it
	
	Author: Terry DuBois
*/

var wordID = argument0;
var unitID = argument1;
var chainGridRow = argument2;

var wordIDList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, chainGridRow);

// if this is a stack, add new unitID to chain's wordIDList
// otherwise, add new wordID to chain's wordIDList
if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
	ds_list_add(wordIDList, unitID);
	
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID, currentChainID);
}
else {
	ds_list_add(wordIDList, wordID);
}


// expand scroll range
with (obj_panelPane) {
	if (currentFunction == functionChainContents) {
		if (functionChainContents_scrollRangeMax[functionChainList_currentTab] == ds_list_size(functionChainContents_IDList)) {
			functionChainContents_scrollRangeMin[functionChainList_currentTab]++;
			functionChainContents_scrollRangeMax[functionChainList_currentTab]++;
		}
	}
}