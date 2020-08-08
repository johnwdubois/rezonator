var optionSelected = argument[0];



//show_message("COL: "+string(obj_control.tokenImportColToChange)+ "        ROW: "+ string(obj_control.tokenImportRowToChange));


if(optionSelected == "Add new Tag"){
	var tempList = ds_map_find_value(global.tokenImportTagMap, obj_control.tokenImportColToChange);

	//user would be prompted for input hereererer
	// say the chose Emotion
	
	ds_list_add(tempList, "Emotion");
	show_message(scr_getStringOfList(tempList));
	
	show_message(scr_getStringOfList(ds_map_find_value(global.tokenImportTagMap, obj_control.tokenImportColToChange)))
	
	
}