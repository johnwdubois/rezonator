function scr_checkExpandable(option, optionType){
	
	// find the list for this specific option, check if its optionType is in the optionTypeList
	var optionTypeList = global.expandableDropDownMap[? option];
	var isExpandable = false;
	if (scr_isNumericAndExists(optionTypeList, ds_type_list)) {
		if (ds_list_find_index(optionTypeList, optionType) >= 0) isExpandable = true;
	}
	
	// every field in the tagging dropDowns should be expandable
	if (optionType == global.optionListTypeTokenFields || optionType == global.optionListTypeChunkFields
	|| optionType == global.optionListTypeUnitFields || optionType == global.optionListTypeEntryFields
	|| optionType == global.optionListTypeChainFields) {
		if (option != "option_create-new-field") {
			isExpandable = true;
		}
	}
	
	return isExpandable;
	
}