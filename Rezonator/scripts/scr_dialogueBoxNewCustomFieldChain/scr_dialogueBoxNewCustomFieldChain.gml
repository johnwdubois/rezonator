function scr_dialogueBoxNewCustomFieldChain() {
	
	// set the new field to be viewed in the chainContents pane
	var newField = obj_control.inputText;
	show_debug_message("scr_dialogueBoxNewCustomFieldChain(), newField: " + string(newField));
	
	var chain1to1ColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) chain1to1ColFieldList = obj_control.chain1to1ColFieldListRez;
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) chain1to1ColFieldList = obj_control.chain1to1ColFieldListTrack;
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) chain1to1ColFieldList = obj_control.chain1to1ColFieldListStack;
		}
	}
	if (ds_exists(chain1to1ColFieldList, ds_type_list)) {
		ds_list_set(chain1to1ColFieldList, obj_control.chain1To1ColFieldToChange, newField);
	}
	
	// create a new tagSet and shortcutSet for the new field
	var tagSet = ds_list_create();
	var shortcutSet = ds_list_create();
	scr_addToChainFieldMap(global.chainFieldMap, newField, tagSet, shortcutSet, true, true, true);

}
