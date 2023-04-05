if (instance_exists(obj_inputBox) && room == rm_mainScreen) {
	show_debug_message("obj_dialogueBox destroying obj_inputBox");
	instance_destroy(obj_inputBox);
}

if (scr_isNumericAndExists(inputBoxList, ds_type_list)) {
	ds_list_destroy(inputBoxList);
}