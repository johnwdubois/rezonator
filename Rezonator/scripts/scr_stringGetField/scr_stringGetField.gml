// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_stringGetField(str){
	
	if (live_call(str)) return live_result;
	
	var field = "";
	
	// if this string has no characters at all, return ""
	var strLen = string_length(str);
	if (strLen <= 0) {
		return "";
	}
	
	// if this string only consists of whitespace, return ""
	if (scr_isStrOnlyWhitespace(str)) {
		return "";
	}
	
	// if the first character is not a "\" then return ""
	if (string_char_at(str, 1) != "\\") {
		return "";
	}
	
	
	var firstSpace = string_pos(" ", str);
	var firstTab = string_pos("	", str);
		
	// if there is a space but no tab, copy from the first character to the space
	if (firstSpace > 0 && firstTab == 0) {
		field = string_copy(str, 1, firstSpace);
	}
	// if there is a tab but no space, copy from the first character to the tab
	else if (firstTab > 0 && firstSpace == 0) {
		field = string_copy(str, 1, firstTab);
	}
	// if there is a space and a tab...
	else if (firstSpace > 0 && firstTab > 0) {
		
		// if the space comes before the tab, copy to the first space
		if (firstSpace <= firstTab) {
			field = string_copy(str, 1, firstSpace);
		}
		// if the tab comes before the space, copy to the first tab
		else {
			field = string_copy(str, 1, firstTab);
		}
		
	}
	// the only other possibility is that there is no space and no tab,
	// then the field is the entire string
	else {
		field = str;
	}
	
	field = string_replace_all(field," ","");
	field = string_replace_all(field,"	","");
	
	return field;
}