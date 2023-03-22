// Call this script every time before using draw_text
// This script handles setting text size for different fonts and reversing strings for RTL fonts
function scr_adaptFont(str, size, isTitle = false) {
	var setTitleFont = false;
	if (argument_count > 2) {
		setTitleFont = isTitle;
	}
	// make sure we're dealing with a string
	if (!is_string(str)) str = string(str);

	// get rid of any newlines in this string
	if (string_count("\n", str) > 0) str = string_replace_all(str, "\n", "");
	if (string_count("\r", str) > 0) str = string_replace_all(str, "\r", "");
	
	// determine if this string is latin, CJK, or hebrew
	var isCJK = false;
	var isRTL = false;
	if (ds_map_exists(global.strToLangMap, str)) {
		var langCode = ds_map_find_value(global.strToLangMap, str);
		if (langCode == "CJK") isCJK = true;
		else if (langCode == "RTL") isRTL = true;
	}
	else {
		var letterCount = string_length(str);
		for (var i = 0;i <= letterCount; i++) {
			var unicodeValue = ord(string_char_at(str,i));
			// check if char is in CJK unicode range
			if ((12288 <= unicodeValue and unicodeValue <= 65535) or
			(131072 <= unicodeValue  and unicodeValue <= 183983) or
			(194560 <= unicodeValue  and unicodeValue <= 195103)) {

				isCJK = true;
				break;
			
			}
			// check if char is in RTL unicode range
			if (1424 <= unicodeValue and unicodeValue <= 1969 ||
			 1984 <= unicodeValue and unicodeValue <= 2143 ||
			 2208 <= unicodeValue and unicodeValue <= 2303 ||
			 64336 <= unicodeValue and unicodeValue <= 65023 ||
			 65136 <= unicodeValue and unicodeValue <= 65279 ||
			 67648 <= unicodeValue and unicodeValue <= 67679 ||
			 68864 <= unicodeValue and unicodeValue <= 68921 ||
			 69216 <= unicodeValue and unicodeValue <= 69247 ||
			 125184 <= unicodeValue and unicodeValue <= 125279 ||
			 126064 <= unicodeValue and unicodeValue <= 126143 ||
			 126208 <= unicodeValue and unicodeValue <= 126287 ||
			 126464 <= unicodeValue and unicodeValue <= 126719) {
				isRTL = true;
			}
		}
		
		// attach a language code to the string and put it in strToLang map
		var langCode = "";
		if (isCJK) langCode = "CJK";
		else if (isRTL) langCode = "RTL";
		else langCode = "LATIN";
		ds_map_add(global.strToLangMap, str, langCode);
	}
		
		
	// determine the font to set
	var fontScaledName = fnt_nonCJK_size3;
	if (isCJK) {
		if (setTitleFont) {
			fontScaledName = global.html5 ? fnt_CJK_size3 : global.localeCJK_Title;
		}
		else {
			fontScaledName = global.fontMap[? "CJK_" + size + "_" + string(global.fontSize)];
		}
	}
	else {
		if (setTitleFont) {
			fontScaledName = global.html5 ? fnt_nonCJK_size3 : global.localeEN_Title;
		}
		else {
			fontScaledName = global.fontMap[? "nonCJK_" + size + "_" + string(global.fontSize)];
		}
	}
	
	
	draw_set_font(fontScaledName);

	
	// flip the string if it's RTL!
	if (isRTL) str = scr_stringReverse(str);
	
	return str;
}