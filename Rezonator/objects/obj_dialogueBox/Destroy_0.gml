if (instance_exists(obj_inputBox)) {
	show_debug_message("diaglogue box has murdered the input box");
	instance_destroy(obj_inputBox);
}

if (scr_isNumericAndExists(inputBoxList, ds_type_list)) {
	ds_list_destroy(inputBoxList);
}