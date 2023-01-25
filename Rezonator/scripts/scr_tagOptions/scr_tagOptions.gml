function scr_tagOptions(optionSelected) {
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	if (optionSelected == "Tag Token") {
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, obj_control.tokenFieldList);
		ds_list_add(dropDownOptionList, "option_create-new-field");
		scr_createDropDown(x + windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeTokenFields);
	
	}
	if (optionSelected == "Tag Chunk") {
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, obj_control.chunkFieldList);
		ds_list_add(dropDownOptionList, "option_create-new-field");
		scr_createDropDown(x + windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeChunkFields);
	
	}
	else if (optionSelected == "Tag Unit") {
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, obj_control.unitFieldList);
		ds_list_add(dropDownOptionList, "option_create-new-field");
		scr_createDropDown(x + windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeUnitFields);

	}
	else if (optionSelected == "Tag Entry") {
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, global.chainEntryFieldList);
		ds_list_add(dropDownOptionList, "option_create-new-field");
		scr_deleteFromList(dropDownOptionList, "gapUnits");
		scr_deleteFromList(dropDownOptionList, "gapWords");
		scr_deleteFromList(dropDownOptionList, "tokenCount");
		scr_deleteFromList(dropDownOptionList, "charCount");
		scr_createDropDown(x + windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeEntryFields);

	}
	else if (optionSelected == "Tag Chain") {
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, global.chainFieldList);
		ds_list_add(dropDownOptionList, "option_create-new-field");
		scr_deleteFromList(dropDownOptionList, "chainSize");
		scr_createDropDown(x + windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeChainFields);

	}

}
