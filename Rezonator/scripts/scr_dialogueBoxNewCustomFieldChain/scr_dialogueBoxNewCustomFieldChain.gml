function scr_dialogueBoxNewCustomFieldChain() {
	
	// set the new field to be viewed in the chainContents pane
	var newField = obj_control.inputText;
	show_debug_message("scr_dialogueBoxNewCustomFieldChain(), newField: " + string(newField));
	if (!is_string(newField) || string_length(string(newField)) < 1) {
		show_debug_message("new field is invalid or blank string, exiting...");
		exit;
	}
	
	var chain1to1ColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) chain1to1ColFieldList = obj_control.chain1to1ColFieldListRez;
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) chain1to1ColFieldList = obj_control.chain1to1ColFieldListTrack;
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) chain1to1ColFieldList = obj_control.chain1to1ColFieldListStack;
		}
	}
	

	if (scr_isNumericAndExists(chain1to1ColFieldList, ds_type_list)) {
		scr_addToListOnce(chain1to1ColFieldList, newField);
		show_debug_message("chain1to1ColFieldList: " + scr_getStringOfList(chain1to1ColFieldList));
	}
	else {
		scr_addToListOnce(obj_control.chain1to1ColFieldListRez, newField);
		scr_addToListOnce(obj_control.chain1to1ColFieldListTrack, newField);
		scr_addToListOnce(obj_control.chain1to1ColFieldListStack, newField);
	}
	
	var currentChain1to1ColAmount = obj_panelPane.chain1to1ColAmount;
	with (obj_panelPane) {
		chain1to1ColAmount = min(currentChain1to1ColAmount + 1, 6);
	}
	

	// create a new tagSet and shortcutSet for the new field
	var tagSet = ds_list_create();
	scr_addToChainFieldMap(global.chainFieldMap, newField, tagSet, true, true, true);
	scr_sortList(global.chainFieldList);
}
