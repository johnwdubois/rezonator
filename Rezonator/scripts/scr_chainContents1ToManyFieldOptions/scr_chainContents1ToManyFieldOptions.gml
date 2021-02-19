function scr_chainContents1ToManyFieldOptions(optionSelected) {
	
	var chain1toManyColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
		}
	}
	
	if (ds_exists(chain1toManyColFieldList, ds_type_list)) {
		var fieldToChange = obj_control.chain1ToManyColFieldToChange;
		ds_list_set(chain1toManyColFieldList, fieldToChange, optionSelected);
	}

}
