/*
	scr_wordClicked(wordID, unitID);
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: handle reaction to user clicking on a word
	
	Mechanism: check obj_toolPane to see if a chainBrush is selected, if so either spawn a new chain or add
				to an existing chain
*/

if (obj_control.gridView || obj_control.mouseoverPanelPane)
{
	exit;
}

var wordID = argument0;
var unitID = argument1;

if not (obj_toolPane.currentTool == obj_toolPane.toolRezBrush
or obj_toolPane.currentTool == obj_toolPane.toolTrackBrush
or obj_toolPane.currentTool == obj_toolPane.toolStackBrush)
{
	exit;
}

var inChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, wordID - 1);

for (var i = 0; i < ds_list_size(inChainsList); i++)
{
	var currentChainID = ds_list_find_value(inChainsList, i);
	if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(currentChainGrid), currentChainID))
	{
		var rowInChainGrid = ds_grid_value_y(currentChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(currentChainGrid), currentChainID);
		ds_grid_set(currentChainGrid, chainGrid_colChainState, rowInChainGrid, chainStateFocus);
		currentFocusedChainID = currentChainID;
	
		
		var rowInLinkGrid = scr_findInGridThreeParameters(linkGrid, linkGrid_colSource, wordID, linkGrid_colChainID, currentChainID, linkGrid_colDead, false);
		if (rowInLinkGrid >= 0 and rowInLinkGrid < ds_grid_height(linkGrid))
		{
			ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
			ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGrid, true);
			scr_refreshChainGrid();
			
			if (currentChainGrid == rezChainGrid or currentChainGrid == trackChainGrid)
			{
				ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, wordID - 1, true);
				obj_chain.mouseLineWordID = wordID;
				exit;
			}
		}
		
	}
}

if (not ds_grid_value_exists(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus))
{
	scr_newChain(wordID, unitID);
}

scr_newLink(wordID, -1);
scr_refreshChainGrid();


if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus))
{
	var rowInChainGrid = ds_grid_value_y(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus);
	var chainID = ds_grid_get(currentChainGrid, chainGrid_colChainID, rowInChainGrid);
	
	if (ds_list_find_index(inChainsList, chainID) == -1)//obj_toolPane.currentTool) == -1)
	{
		ds_list_add(inChainsList, chainID);//obj_toolPane.currentTool);
	
	}
}

