/*
	scr_setChainAlign(chainID, aligned);
	
	Last Updated: 2019-02-20
	
	Called from: obj_chain
	
	Purpose: Set aligned value for given chain to given aligned
	
	Mechanism: Find which chainGrid to set, and set the correct cell to given aligned variable
	
	Author: Terry DuBois
*/

var chainID = argument0;
var aligned = argument1;

var rowInLinkGrid = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(obj_chain.linkGrid), chainID);

if (rowInLinkGrid < 0 or rowInLinkGrid >= ds_grid_height(obj_chain.linkGrid)) {
	exit;
}

var chainTier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowInLinkGrid);
var grid = obj_chain.rezChainGrid;
if (chainTier == 1) {
	grid = obj_chain.trackChainGrid;
}

var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(grid), chainID);

if (rowInChainGrid < 0 or rowInChainGrid >= ds_grid_height(grid)) {
	exit;
}

ds_grid_set(grid, obj_chain.chainGrid_colAlign, rowInChainGrid, aligned);