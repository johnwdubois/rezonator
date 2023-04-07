function scr_dialogueBoxNewCustomFieldEntry() {
	
	// set the new field to be viewed in the chainContents pane
	var newField = obj_control.inputText;
	show_debug_message("scr_dialogueBoxNewCustomFieldEntry(), newField: " + string(newField));
	if (!is_string(newField) || string_length(string(newField)) < 1) {
		show_debug_message("new field is invalid or blank string, exiting...");
		exit;
	}
	
	var chain1toManyColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == NAVTAB_RESONANCE) chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
			else if (functionChainList_currentTab == NAVTAB_TRACK) chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
			else if (functionChainList_currentTab == NAVTAB_STACK) chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
		}
	}
	

	if (scr_isNumericAndExists(chain1toManyColFieldList, ds_type_list)) {
		scr_addToListOnce(chain1toManyColFieldList, newField);
		show_debug_message("chain1toManyColFieldList: " + scr_getStringOfList(chain1toManyColFieldList));
	}
	else {
		scr_addToListOnce(obj_control.chain1toManyColFieldListRez, newField);
		scr_addToListOnce(obj_control.chain1toManyColFieldListTrack, newField);
		scr_addToListOnce(obj_control.chain1toManyColFieldListStack, newField);
	}
	

	
	// create a new tagSet and shortcutSet for the new field
	var tagSet = ds_list_create();
	scr_addToChainFieldMap(global.entryFieldMap, newField, tagSet, true, true, true);
	scr_sortList(global.chainEntryFieldList);
}
