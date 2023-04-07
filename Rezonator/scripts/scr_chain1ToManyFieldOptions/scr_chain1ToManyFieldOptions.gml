function scr_chain1ToManyFieldOptions(optionSelected) {
	
	var chain1toManyColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == NAVTAB_RESONANCE) chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
			else if (functionChainList_currentTab == NAVTAB_TRACK) chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
			else if (functionChainList_currentTab == NAVTAB_STACK) chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
		}
	}
	
	if (ds_exists(chain1toManyColFieldList, ds_type_list)) {
		
		
		var colListIndex = obj_control.chain1ToManyColFieldToChange;
		var optionSelectedPrevIndex = ds_list_find_index(chain1toManyColFieldList,optionSelected);
		if (optionSelectedPrevIndex >= 0 && colListIndex != optionSelectedPrevIndex) {
			scr_listSwap(chain1toManyColFieldList, colListIndex, optionSelectedPrevIndex);
		}
		else if (optionSelectedPrevIndex == -1) {
			ds_list_set(chain1toManyColFieldList, colListIndex, optionSelected);
		}
	}

}
