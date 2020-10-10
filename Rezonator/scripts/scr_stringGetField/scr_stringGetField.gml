// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_stringGetField(str){
	
	if (live_call(str)) return live_result;
	
	show_debug_message("scr_stringGetField() ... str: " + string(str));
	
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
	
	// find the first character in the string that is not whitespace
	var firstNonwhitespaceCharAt = 1;
	while (string_char_at(str, firstNonwhitespaceCharAt) == " " && string_char_at(str, firstNonwhitespaceCharAt) == "	" && firstNonwhitespaceCharAt <= strLen) {
		firstNonwhitespaceCharAt++;
	}
	
	// if there is any whitespace at the beginning of the line, clip that out for this test
	if (firstNonwhitespaceCharAt > 1) {
		str = string_copy(str, firstNonwhitespaceCharAt, strLen - firstNonwhitespaceCharAt);
		show_debug_message("scr_stringGetField() ... newStr: " + string(str));
	}
	
	// if the first non-whitespace character is not a "\" then return ""
	var firstNonwhitespaceChar = string_char_at(str, firstNonwhitespaceCharAt);
	if (firstNonwhitespaceChar != "\\") {
		show_debug_message("scr_stringGetField() ... firstNonwhitespaceCharAt: " + string(firstNonwhitespaceCharAt) + " ... firstNonwhitespaceChar: " + string(firstNonwhitespaceChar));
		return "";
	}
	
	var firstSpace = string_pos(" ", str);
	var firstTab = string_pos("	", str);
	if (firstSpace > 0 && firstSpace < firstTab) {
		field = string_copy(str, 1, firstSpace);
	}
	else if (firstTab > 0 && firstTab < firstSpace) {
		field = string_copy(str, 1, firstTab);
	}
	else if (firstSpace == 0 && firstTab == 0) {
		return str;
	}
	
	return field;
}