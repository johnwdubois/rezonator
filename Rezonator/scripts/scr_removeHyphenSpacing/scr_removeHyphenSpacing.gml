// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_removeHyphenSpacing(str){
	
	str = string(str);
	var strLen = string_length(str);
	var charIndex = 1;
	
	
	while (charIndex < strLen) {
		
		// get current & prev char
		var currentChar = string_char_at(str, charIndex);
		var prevChar = "";
		if (charIndex > 1) prevChar = string_char_at(str, charIndex - 1);
		var prevCharIsSpace = (prevChar == " " || prevChar == "	");
		

		if (charIndex > 1 && charIndex < strLen) {
			if (currentChar == "-") {
				if (!prevCharIsSpace) {
					// if we're here, we have a hyphen AFTER the text
					// in this case, let's delete until we find a non-whitespace character
					var delIndex = charIndex + 1;
					while (string_char_at(str, delIndex) == " " || string_char_at(str, delIndex) == "	") {
						delIndex++;
					}
					var delCount = max((delIndex - charIndex) - 1, 0);
					str = string_delete(str, charIndex + 1, delCount);
				}
				else {
					// if we're here, we have a hyphen BEFORE the text
					// in this case, we will delete *backwards* until we find a non-whitespace character
					var delIndex = charIndex - 1;
					while (string_char_at(str, delIndex) == " " || string_char_at(str, delIndex) == "	") {
						delIndex--;
					}
					var delCount = max((charIndex - delIndex) - 1, 0);
					str = string_delete(str, delIndex + 1, delCount);
					
					charIndex -= delCount;
				}
			}
		}
		
		charIndex++;
	}

	return str;


}