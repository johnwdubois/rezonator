var currentChainID = argument[0];
var currentChainGridRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.currentChainGrid)-1, currentChainID);
var currentChainWordIDList = ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colWordIDList, currentChainGridRow);

for(var deleteLoop = 0; deleteLoop < ds_list_size(currentChainWordIDList); deleteLoop++) {
	scr_deleteFromChain();	
}