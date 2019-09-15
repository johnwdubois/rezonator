/// @description Insert description here
// You can write your code in this editor
//show_message("here");
if(obj_control.showDevVars) {
	var randomWordID = floor(random(ds_grid_height(obj_control.wordGrid)));
	if(randomWordID < ds_grid_height(obj_control.wordGrid) - 1 and randomWordID > -1) {
		var randomUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, randomWordID);
		with(obj_chain) {
			scr_wordClicked(randomWordID, randomUnitID);
		}
	}
}
