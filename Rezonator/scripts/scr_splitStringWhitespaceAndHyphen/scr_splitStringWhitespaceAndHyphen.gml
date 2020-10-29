// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_splitStringWhitespaceAndHyphen(str) {
	
	//show_debug_message("scr_splitStringWhitespaceAndHyphen() ... str : " + string(str));
	
	var splitList = ds_list_create();
	
	var whitespaceSplitList = scr_splitStringWhitespace(str);
	var whitespaceSplitListSize = ds_list_size(whitespaceSplitList);
	
	for (var i = 0; i < whitespaceSplitListSize; i++) {
		var currentStr = ds_list_find_value(whitespaceSplitList, i);
		
		var firstHyphen = string_pos("-", currentStr);
		
		// if there is no hyphen in the current string, that entire string is the token
		if (firstHyphen == 0) {
			ds_list_add(splitList, currentStr);
		}
		// if there is a hyphen, we need to check if there is a non-whitespace character on either side
		else {
			// because we have already split on whitespace, we can just check that the hyphen is neither
			// the first or last character of the string, which will tell us whether we need to split on it
			if (firstHyphen > 1 && firstHyphen < string_length(currentStr)) {
				
				while (firstHyphen > 1 && firstHyphen < string_length(currentStr)) {
					
					// get a clip of the string from the first character to the first hyphen
					var strClip = string_copy(currentStr, 1, firstHyphen);
					currentStr = string_delete(currentStr, 1, firstHyphen);
					
					// add the clip to the splitList
					ds_list_add(splitList, strClip);
					
					// reset firstHyphen
					firstHyphen = string_pos("-", currentStr);
				}
				// if there is anything left in currentStr, add it to the splitList
				if (currentStr != "-" && string_length(currentStr) > 0) {
					ds_list_add(splitList, currentStr);
				}
			}
			else {
				ds_list_add(splitList, currentStr);
			}
		}
	}
	
	//show_debug_message("scr_splitStringWhitespaceAndHyphen() ... splitList : " + scr_getStringOfList(splitList));
	
	ds_list_destroy(whitespaceSplitList);
	return splitList;

}