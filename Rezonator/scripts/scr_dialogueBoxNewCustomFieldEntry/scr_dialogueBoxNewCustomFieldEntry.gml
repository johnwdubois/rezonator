function scr_dialogueBoxNewCustomFieldEntry() {
	
	// set the new field to be viewed in the chainContents pane
	var newField = obj_control.inputText;
	show_debug_message("scr_dialogueBoxNewCustomFieldEntry(), newField: " + string(newField));
	
	var chain1toManyColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
		}
	}
	if (ds_exists(chain1toManyColFieldList, ds_type_list)) {
		ds_list_set(chain1toManyColFieldList, obj_control.chain1ToManyColFieldToChange, newField);
	}
	
	// create a new tagSet and shortcutSet for the new field
	var tagSet = ds_list_create();
	var shortcutSet = ds_list_create();
	scr_addToChainFieldMap(global.entryFieldMap, newField, tagSet, shortcutSet, true, true, true);

}
