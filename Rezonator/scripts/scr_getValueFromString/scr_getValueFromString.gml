function scr_getValueFromString(fullString, subString, delimiter) {
	// Extract a single value from the specified string

	var charAt = 1;
	var charStart = 1;

	var strCopy = "";

	if (string_count(subString, fullString) > 0) {
	
		charAt = string_pos(subString, fullString) + string_length(subString);
		charStart = charAt;
	
		while (string_char_at(fullString, charAt) != delimiter and charAt < string_length(fullString)) {
			charAt++;
		}
	
		strCopy = string_copy(fullString, charStart, charAt - charStart - 2);
	}

	return strCopy;


}
