function scr_filterDropDownList(fullList, subList, filterStr) {
	
	var curIndex = -1;
	with (obj_inputBox) curIndex = cursorIndex;
	if (curIndex >= 0) filterStr = string_copy(filterStr, 1, curIndex);
	

	filterStr = string_lower(filterStr);
	ds_list_clear(subList);
	
	var optionListSize = ds_list_size(fullList);
	for (var i = 0; i < optionListSize; i++) {
		var currentOption = fullList[| i];
		var currentOptionLower = string_lower(currentOption);
		var strMatch = (string_pos(filterStr, currentOptionLower) == 1) || filterStr == "";
		
		if (strMatch) {
			ds_list_add(subList, currentOption);
		}
	}	
	
	var navWindowTaggingLastChar = "";
	with (obj_control) {
		if (navWindowTaggingKeyboardLastChar != "") {
			navWindowTaggingLastChar = navWindowTaggingKeyboardLastChar;
			navWindowTaggingKeyboardLastChar = "";
		}
	}
	
	// grab the first item in the list and set inputBox str to that value
	if (keyboard_check_pressed(vk_anykey) || navWindowTaggingLastChar != "") {
		var lastChar = (navWindowTaggingLastChar == "") ? keyboard_lastchar : navWindowTaggingLastChar;


		if (ds_list_size(subList) > 0 && filterStr != "" && scr_isCharLetter(lastChar) && !keyboard_check_pressed(vk_backspace)) {
			var firstValue = subList[| 0];
			with (obj_inputBox) {
				str = firstValue;
				cursorIndex = string_length(filterStr);
				highlightIndex = string_length(str);
			}
			keyboard_lastchar = "";
		}
	}
	else if (optionCurrent >= 0 && (keyboard_check(vk_up) || keyboard_check(vk_down))) {
		if (ds_list_size(subList) > 0) {
			var hoverValue = subList[| optionCurrent];
			with (obj_inputBox) {
				str = hoverValue;
				cursorIndex = string_length(filterStr);
				highlightIndex = string_length(str);
			}
		}
	}
	
}