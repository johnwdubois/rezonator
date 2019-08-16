///@description GridList
ds_list_add(gridList,
	obj_chain.linkGrid,
	obj_chain.vizLinkGrid,
	obj_chain.rezPlayLinkGrid,
	obj_chain.DepRelLinkGrid,
	obj_chain.rezChainGrid,
	obj_chain.trackChainGrid,
	obj_chain.stackChainGrid,
	obj_chain.placeChainGrid,
	obj_chain.chunkGrid,
	obj_chain.unitInStackGrid,
	obj_chain.cliqueGrid,
	obj_chain.cliqueDisplayGrid,
	obj_chain.goldStandardGrid
	);



for (var i = 0; i < ds_list_size(gridList); i++) {
	
	var currentGridViewColXList = ds_list_create();
	var currentGrid = ds_list_find_value(gridList, i);
	var defaultGridColWidth = windowWidth / ds_grid_width(currentGrid);
	
	var currentColX = windowX;
	for (var j = 0; j < ds_grid_width(currentGrid); j++) {
		ds_list_add(currentGridViewColXList, currentColX + scrollBarWidth);
		currentColX += defaultGridColWidth;
	}
	
	ds_map_add_list(gridViewColXListMap, currentGrid, currentGridViewColXList);
}