function scr_filterDropDownList(fullList, subList, str){

	str = string_lower(str);
	ds_list_clear(subList);
	
	var optionListSize = ds_list_size(fullList);
	for (var i = 0; i < optionListSize; i++) {
		var currentOption = fullList[| i];
		var currentOptionLower = string_lower(currentOption);
		if (currentOption == "option_add-to-tag-set" || currentOption == "menu_clear" || string_count(str, currentOptionLower) > 0) {
			ds_list_add(subList, currentOption);
		}
	}
	
	
}