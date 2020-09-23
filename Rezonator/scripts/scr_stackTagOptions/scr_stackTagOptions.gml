// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_stackTagOptions(){
	var optionSelected = argument[0];
	
	
	if (optionSelected == "Delete tag") {
		ds_grid_set(obj_chain.stackChainGrid, obj_control.stackColToChange, obj_control.stackRowToChange, 0);
	}
	else {
		ds_grid_set(obj_chain.stackChainGrid, obj_control.stackColToChange, obj_control.stackRowToChange, optionSelected);
	}
}