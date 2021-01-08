function scr_chainDeselect() {
	
	obj_chain.currentFocusedChainID = "";
	
	ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
	ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
	ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), false);
	ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), false);
	ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), false);
	
	scr_killEmptyChains(rezChainGrid);
	scr_killEmptyChains(trackChainGrid);
	scr_killEmptyChains(stackChainGrid);
	
	/*
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
	
		while (ds_grid_value_exists(chainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(chainGrid), obj_chain.chainStateFocus)) {
			var index = ds_grid_value_y(chainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(chainGrid), obj_chain.chainStateFocus);	
			ds_grid_set(chainGrid, obj_chain.chainGrid_colChainState, index, obj_chain.chainStateNormal);
		}
	}


	ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
	ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);


	scr_killEmptyChains(rezChainGrid);
	scr_killEmptyChains(trackChainGrid);
	scr_killEmptyChains(stackChainGrid);

	*/


}
