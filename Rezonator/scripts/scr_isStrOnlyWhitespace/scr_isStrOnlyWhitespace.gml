

function scr_isStrOnlyWhitespace(str){
	
	// returns whether a given string is entirely comprised of spaces or tabs
	
	// remove any linebreaks from string
	str = string_replace(str, "\n", "");
	str = string_replace(str, "\r", "");
	
	// get length of string
	var strLen = string_length(str);
	
	// if this string is empty, then we consider it a whitespace string
	if (strLen <= 0) {
		return true;
	}
	
	// get the amount of spaces and tabs in the string
	var spaceCount = string_count(" ", str);
	var tabCount = string_count("	", str);
	
	// if this string is entirely made of spaces & tabs, then
	// the total string length will equal (amount of spaces + amount of tabs)
	return (spaceCount + tabCount == strLen);
	
}
