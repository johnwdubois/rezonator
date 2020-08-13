var optionSelected = argument[0];



//show_message("COL: "+string(obj_control.tokenImportColToChange)+ "        ROW: "+ string(obj_control.tokenImportRowToChange));


if(optionSelected == "Add new Tag"){


	//user would be prompted for input hereererer
	// say the chose Emotion
	obj_control.newCustomTagToken = true;
	obj_control.dialogueBoxActive = true;

	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	
	//ds_list_add(tempList, get_string("",""));
	//show_message(scr_getStringOfList(tempList));
	
	//show_message(scr_getStringOfList(ds_map_find_value(global.tokenImportTagMap, obj_control.tokenImportColToChange)))
	
}
else {
	ds_grid_set(global.tokenImportGrid, obj_control.tokenImportColToChange, obj_control.tokenImportRowToChange, optionSelected);
}


if (obj_control.wordView == obj_panelPane.selectedCol) {
	scr_toggleTranscriptionMulti(global.tokenImportGrid, obj_control.tokenImportColToChange);
}