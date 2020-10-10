// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_isStrOnlyWhitespace(str){
	
	if (live_call(str)) return live_result;
	
	str = string_replace(str, "\n", "");
	str = string_replace(str, "\r", "");
	
	var strLen = string_length(str);
	
	if (strLen <= 0) {
		return true;
	}
	
	var spaceCount = string_count(" ", str);
	var tabCount = string_count("	", str);
	
	return (spaceCount + tabCount == strLen);
	
}
