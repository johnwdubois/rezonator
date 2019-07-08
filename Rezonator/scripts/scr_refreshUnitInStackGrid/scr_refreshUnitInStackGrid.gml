for (var i = 0; i < ds_grid_height(obj_chain.unitInStackGrid); i++) {
	
	var currentCellString = scr_drawGridViewerGetItemString(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, i);
	
	if (real(string_digits(currentCellString)) > 0) {
		if (ds_grid_height(obj_chain.stackChainGrid) < 1) {
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, i, -1);
		}
	}
	
}