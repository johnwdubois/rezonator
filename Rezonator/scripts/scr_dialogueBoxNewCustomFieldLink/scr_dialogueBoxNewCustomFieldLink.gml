function scr_dialogueBoxNewCustomFieldLink() {
	
	// set the new field to be viewed in the chainContents pane
	var newField = obj_control.inputText;
	if (ds_list_find_index(global.linkFieldList, newField) != -1) exit;
	show_debug_message("scr_dialogueBoxNewCustomFieldLink(), newField: " + string(newField));
	if (!is_string(newField) || string_length(string(newField)) < 1) {
		show_debug_message("new field is invalid or blank string, exiting...");
		exit;
	}
	
	
	// create a new tagSet and shortcutSet for the new field
	var tagSet = ds_list_create();
	var shortcutSet = ds_list_create();
	scr_addToChainFieldMap(global.linkFieldMap, newField, tagSet, shortcutSet, true, true, true);
}