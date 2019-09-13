var chainGrid = currentChainGrid;


for (var i = 0; i < 3; i++) {
	switch (i) {
		case 0:
			chainGrid = obj_chain.rezChainGrid;
			break;
		case 1:
			chainGrid = obj_chain.trackChainGrid;
			break;
		case 2:
			chainGrid = obj_chain.stackChainGrid;
			break;
		default:
			break;
	}
	
	while (ds_grid_value_exists(chainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(chainGrid), chainStateFocus)) {
		var index = ds_grid_value_y(chainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(chainGrid), chainStateFocus);	
		ds_grid_set(chainGrid, chainGrid_colChainState, index, chainStateNormal);
	}
}


ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);


scr_killEmptyChains(rezChainGrid);
scr_killEmptyChains(trackChainGrid);
scr_killEmptyChains(stackChainGrid);


mouseLineWordID = -1;