function scr_dialogueBoxNewCustomFieldLink() {
	
	// set the new field to be viewed in the chainContents pane
	var newField = obj_control.inputText;
	show_debug_message("scr_dialogueBoxNewCustomFieldLink(), newField: " + string(newField));
	
	
	// create a new tagSet and shortcutSet for the new field
	var tagSet = ds_list_create();
	var shortcutSet = ds_list_create();
	scr_addToChainFieldMap(global.linkFieldMap, newField, tagSet, shortcutSet, true, true, true);
}
