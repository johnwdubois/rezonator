function scr_insertColumnDropDown(fullFieldList, navFieldList, type){
	
	var optionSpacingMulti = ds_list_find_index(optionList, "Insert column");
	scr_destroyAllDropDownsOtherThanSelf();
	
	
	// if this is an entry, we need to get only the fields that apply to the correct chain type
	if (type == "entry") {
		var entryType = "";
		with (obj_panelPane) {
			if (currentFunction == functionChainList) {
				if (functionChainList_currentTab == functionChainList_tabRezBrush) {
					entryType = "rez";
				}
				else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
					entryType = "track";
				}
				else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					entryType = "card";
				}
			}
		}
		fullFieldList = ds_list_create();
		var entryFieldListSize = ds_list_size(global.chainEntryFieldList);
		for (var i = 0; i < entryFieldListSize; i++) {
			var currentEntryField = global.chainEntryFieldList[| i];
			var currentEntryFieldSubMap = global.entryFieldMap[? currentEntryField];
			if (currentEntryFieldSubMap[? entryType]) {
				ds_list_add(fullFieldList, currentEntryField);
			}
		}
	}
	

	
	// go through fullFieldlist, check which ones are not in navFieldList
	var dropDownOptionList = ds_list_create();
	var fullFieldListSize = ds_list_size(fullFieldList);
	for (var i = 0; i < fullFieldListSize; i++) {
		var currentField = fullFieldList[| i];
		if (ds_list_find_index(navFieldList, currentField) == -1) {
			ds_list_add(dropDownOptionList, currentField);
		}
	}
	scr_createDropDown(x + windowWidth, y + (optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeInsertCol);
	
}