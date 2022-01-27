function scr_filterDropDownList(fullList, subList, str){
	


	str = string_lower(str);
	ds_list_clear(subList);
	
	var optionListSize = ds_list_size(fullList);
	for (var i = 0; i < optionListSize; i++) {
		var currentOption = fullList[| i];
		var currentOptionLower = string_lower(currentOption);
		var strMatch = (string_pos(str, currentOptionLower) == 1) || str == "";
		
		if (strMatch) {
			ds_list_add(subList, currentOption);
		}
	}
	
	ds_list_sort(subList, true);
}