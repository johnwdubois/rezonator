// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_stackTagOptions(){
	var optionSelected = argument[0];
	
	
	if (optionSelected == "Delete tag") {
		ds_grid_set(obj_chain.stackChainGrid, obj_control.stackColToChange, obj_control.stackRowToChange, 0);
	}
	else if (optionSelected == "Add tag option") {
		// prompt user for name of new stack tag
		obj_control.newCustomTagStack = true;
		obj_control.dialogueBoxActive = true;
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	}
	else {
		// set selected tag in stackChainGrid
		ds_grid_set(obj_chain.stackChainGrid, obj_control.stackColToChange, obj_control.stackRowToChange, optionSelected);
	}
}