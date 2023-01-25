function scr_removeBadQuotes(str, subStr) {
	
	var strCopy = str;
	show_debug_message("scr_removeBadQuotes, str: " + string(str) + ", subStr: " +string(subStr));
	var mapValueStr = subStr;//"\"mapValue\"";
	var replaceValue = "REPLACETHISVALUE!";
	var mapValueCount = string_count(mapValueStr, strCopy);
	show_debug_message("scr_removeBadQuotes, mapValueCount: " + string(mapValueCount));
	
	while (mapValueCount > 0) {
		
		// find first instance of "mapValue", replace with a temp string
		var charIndex = string_pos(mapValueStr, strCopy);
		strCopy = string_replace(strCopy, mapValueStr, replaceValue);
		charIndex += string_length(replaceValue);
		
		// find first " after "mapValue" and delete it
		while (string_char_at(strCopy, charIndex) != "\"") {
			charIndex++;
		}
		strCopy = string_delete(strCopy, charIndex, 1);
		
		// count open/close brackets to find the next bad "
		charIndex--;
		var firstBracketFound = false;
		var bracketCounter = 0;
		while (bracketCounter != 0 || !firstBracketFound) {
			
			var openBracket = (string_char_at(strCopy, charIndex) == "{");
			var closeBracket = (string_char_at(strCopy, charIndex) == "}");
			if (openBracket) firstBracketFound = true;
			
			if (openBracket) bracketCounter++;
			else if (closeBracket) bracketCounter--;
			
			//show_debug_message("bracketCounter: " + string(bracketCounter) + ", charIndex: " + string(charIndex));
			charIndex++;
		}
		
		// next " we find is bad, so we delete it
		while (string_char_at(strCopy, charIndex) != "\"") {
			charIndex++;
		}
		strCopy = string_delete(strCopy, charIndex, 1);
		
		mapValueCount = string_count(mapValueStr, strCopy);
	}
	
	
	
	str = string_replace_all(strCopy, replaceValue, mapValueStr);
	show_debug_message("scr_removeBadQuotes END!!!! str: " + string(str));

	return str;
}