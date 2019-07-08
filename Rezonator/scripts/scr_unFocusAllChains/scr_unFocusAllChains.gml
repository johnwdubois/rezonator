/*
	scr_unfocusAllChains();
	
	Last Updated: 2018-09-11
	
	Called from: any object
	
	Purpose: flag every chain in chainGrids as unfocused
	
	Mechanism: loop through every chainGrid until there are no chains marked as focused
	
	Author: Terry DuBois, Georgio Klironomos
*/

// Unfocus all rez chains
while (ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus))
{
	var rowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus);
	// Keep track of previously focused chains
	obj_chain.oldRezFocus = rowInChainGrid;
	if(rowInChainGrid >= 0){
		ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, rowInChainGrid, obj_chain.chainStateNormal);
	}
}

// Unfocus all track chains
while (ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus))
{
	var rowInChainGrid = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus);
	// Keep track of previously focused chains
	obj_chain.oldTrackFocus = rowInChainGrid;
	if(rowInChainGrid >= 0){
		ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, rowInChainGrid, obj_chain.chainStateNormal);
	}
}

// Unfocus all stack chains
while (ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus))
{
	var rowInChainGrid = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
	// Keep track of previously focused chains
	obj_chain.oldStackFocus = rowInChainGrid;
	if(rowInChainGrid >= 0){
		ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, rowInChainGrid, obj_chain.chainStateNormal);
	}
}