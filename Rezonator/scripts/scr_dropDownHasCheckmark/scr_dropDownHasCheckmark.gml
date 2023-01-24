function scr_dropDownHasCheckmark(option){

	var hasCheck = false;
	if (ds_map_exists(global.checkDropdownMap, option) && optionListType != global.optionListTypeDelete){
		scr_updateCheckMap(option);
		hasCheck = ds_map_find_value(global.checkDropdownMap, option);
		if (optionListType == global.optionListTypeNav) hasCheck = false;
	}

	// some checks for duplicate optionText that shouldnt have checkmarks
	if(optionListType == global.optionListTypeTools and option == "menu_stack") hasCheck = false;
	if(optionListType == global.optionListTypeAddToFilter and option == "menu_track") hasCheck = false;
	if(optionListType == global.optionListTypeView and option == "menu_prose") hasCheck = false;
	
	return hasCheck;
}