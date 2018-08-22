/*
	scr_wordClicked(wordID, unitID);
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: handle reaction to user clicking on a word
	
	Mechanism: check obj_toolPane to see if a chainBrush is selected, if so either spawn a new chain or add
				to an existing chain
*/

if (obj_control.gridView)
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

