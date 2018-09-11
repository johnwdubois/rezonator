/*
	scr_unfocusOtherChains();
	
	Last Updated: 2018-09-11
	
	Called from: any object
	
	Purpose: unfocus any chain that is not of the type/tier of the current selected tool
	
	Mechanism: iterate over chainGrids of other tiers and mark them as unfocused
	
	Author: Terry DuBois
*/

var tool = argument0;
var grid = obj_chain.rezChainGrid;

switch (tool)
{
	case obj_toolPane.toolRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case obj_toolPane.toolTrackBrush:
		grid = obj_chain.trackChainGrid;
		break;
	case obj_toolPane.toolStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	default:
		break;
}

if (not obj_toolPane.currentTool == tool)
{
	while (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus))
	{
		var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus);
		ds_grid_set(grid, obj_chain.chainGrid_colChainState, rowInChainGrid, obj_chain.chainStateNormal);
	}
}