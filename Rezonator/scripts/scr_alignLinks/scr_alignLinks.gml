var chainID = argument0;

var currentRowInLinkGrid = ds_grid_value_y(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, 0, obj_chain.vizLinkGrid_colChainID, ds_grid_height(obj_chain.vizLinkGrid), currentChain);
if (currentRowInLinkGrid < 0 or currentRowInLinkGrid >= ds_grid_height(obj_chain.vizLinkGrid))
{
	exit;
}


while (ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, currentRowInLinkGrid) == chainID)
{
	currentRowInLinkGrid++;
}