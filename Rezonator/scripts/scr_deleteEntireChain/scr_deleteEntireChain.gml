var currentChainID = argument[0];
var currentChainGridRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.currentChainGrid)-1, currentChainID);
var currentChainWordIDList = ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colWordIDList, currentChainGridRow);
// Focus a link on the relevant chain
var currentLinkGridRow = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(obj_chain.linkGrid), currentChainID);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, currentLinkGridRow, true);

for(var deleteLoop = 0; deleteLoop < ds_list_size(currentChainWordIDList); deleteLoop++) {
	with(obj_control) {
		scr_deleteFromChain();	
	}
}