var chainID = argument0;

var rowInRezChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), chainID);
var rowInTrackChainGrid = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), chainID);
var rowInStackChainGrid = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), chainID);

if (rowInRezChainGrid > -1 and rowInRezChainGrid < ds_grid_height(obj_chain.rezChainGrid)) {
	if (ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, rowInRezChainGrid) == obj_chain.chainStateFocus) {
		ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, rowInRezChainGrid, obj_chain.chainStateNormal);
	}
}
if (rowInTrackChainGrid > -1 and rowInTrackChainGrid < ds_grid_height(obj_chain.trackChainGrid)) {
	if (ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, rowInTrackChainGrid) == obj_chain.chainStateFocus) {
		ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, rowInTrackChainGrid, obj_chain.chainStateNormal);
	}
}
if (rowInStackChainGrid > -1 and rowInStackChainGrid < ds_grid_height(obj_chain.stackChainGrid)) {
	if (ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, rowInStackChainGrid) == obj_chain.chainStateFocus) {
		ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, rowInStackChainGrid, obj_chain.chainStateNormal);
	}
}