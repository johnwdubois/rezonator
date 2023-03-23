/*
	Purpose: Consistently update attributes of chain objects
*/

scr_setFocusedChainWordID();


ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, 0, obj_control.wordDrawGrid_colFocused, ds_grid_height(obj_control.wordDrawGrid), false);

mouseLineHide = false;
if (obj_control.mouseoverPanelPane) {
	mouseLineHide = true;
}