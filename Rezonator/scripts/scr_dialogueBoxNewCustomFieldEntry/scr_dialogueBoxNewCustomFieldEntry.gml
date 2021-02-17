function scr_dialogueBoxNewCustomFieldEntry() {
	
	// set the new field to be viewed in the chainContents pane
	var newField = obj_control.inputText;
	ds_list_set(obj_control.chain1toManyColFieldList, obj_control.chain1ToManyColFieldToChange, newField);
	
	// create a new tagSet and shortcutSet for the new field
	var tagSet = ds_list_create();
	var shortcutSet = ds_list_create();
	scr_addToEntryFieldMap(newField, tagSet, shortcutSet, true, true, true);

}
