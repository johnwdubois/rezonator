function scr_getListFromString(argument0, argument1, argument2) {
	// Extract a single value from the specified string

	var fullString = argument0;
	var subString = argument1;
	var delimiter = argument2;

	var charAt = 1;
	var charStart = 1;

	var strCopy = "";

	if (string_count(subString, fullString) > 0) {
	
		charAt = string_pos(subString, fullString) + string_length(subString);
		charStart = charAt;
	
		while (string_char_at(fullString, charAt) != delimiter and charAt < string_length(fullString)) {
			charAt++;
		}
	
		strCopy = string_copy(fullString, charStart, charAt - charStart);

	
	}

	return strCopy;


}
