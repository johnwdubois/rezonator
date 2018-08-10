/*
	scr_newChainItem(wordID, unitID, chainGridRow);
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: add clicked word or line to current open chain
	
	Mechanism: open up current chain's IDList and add to it
*/

var wordID = argument0;
var unitID = argument1;
var chainGridRow = argument2;

var wordIDList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, chainGridRow);

if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)
{
	ds_list_add(wordIDList, unitID);
	
	var stackList = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, unitID);
	ds_list_add(stackList, currentChainID);
}
else
{
	ds_list_add(wordIDList, wordID);
}

with (obj_panelPane)
{
	if (currentFunction == functionChainContents)
	{
		if (functionChainContents_scrollRangeMax[functionChainList_currentTab] == ds_list_size(functionChainContents_IDList))
		{
			functionChainContents_scrollRangeMin[functionChainList_currentTab]++;
			functionChainContents_scrollRangeMax[functionChainList_currentTab]++;
		}
	}
}