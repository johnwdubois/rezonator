var chainID = argument0;

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

return (ds_grid_get(grid, obj_chain.chainGrid_colAlign, rowInChainGrid));