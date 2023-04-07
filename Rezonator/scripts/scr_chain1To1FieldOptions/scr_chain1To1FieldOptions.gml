function scr_chain1To1FieldOptions(optionSelected) {
	
	var chain1to1ColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == NAVTAB_RESONANCE) chain1to1ColFieldList = obj_control.chain1to1ColFieldListRez;
			else if (functionChainList_currentTab == NAVTAB_TRACK) chain1to1ColFieldList = obj_control.chain1to1ColFieldListTrack;
			else if (functionChainList_currentTab == NAVTAB_STACK) chain1to1ColFieldList = obj_control.chain1to1ColFieldListStack;
		}
	}
	
	if (ds_exists(chain1to1ColFieldList, ds_type_list)) {

		var fieldToChange = obj_control.chain1To1ColFieldToChange;
		var optionSelectedPrevIndex = ds_list_find_index(chain1to1ColFieldList,optionSelected);
		scr_listSwap(chain1to1ColFieldList, fieldToChange, optionSelectedPrevIndex);

	}
	

}