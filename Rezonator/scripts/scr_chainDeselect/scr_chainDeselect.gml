function scr_chainDeselect() {
	
	show_debug_message("scr_chainDeselect()");
	obj_chain.currentFocusedChainID = "";
	
	ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);



}
