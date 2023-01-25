// This script works with obj_locale_manager
// Author: Giorgia Troiani
// Last update : 2020 - 11 - 04

function scr_get_translation(key) {
	
	// look for the key in the current language's map
	// if we can find the translation, return the translation
	
	if (variable_global_exists("locale_gloss") && ds_map_exists( global.locale_gloss, key )) {
		var outputString = ds_map_find_value( global.locale_gloss, key );
		var letterCount = string_length(outputString);
		var isRTL = false;
		for (var i = 0; i <= letterCount; i++) {
			
			var unicodeValue = ord(string_char_at(outputString,i));

			if ( 1424 <= unicodeValue and unicodeValue <= 1969 ||
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
		if (isRTL) {outputString = scr_stringReverse(outputString)}
		return outputString;
	}
	else if (room == rm_mainScreen) {
			
		// if we can't find the translation, we will see if we
		// can find the key in English
		if (!obj_control.showDevVars) {
			var englishMap = ds_map_find_value(global.locale_map, "en");
			if (ds_map_exists(englishMap, key)) {
				return ds_map_find_value(englishMap, key);
			}
		}
		
	}
	else if (room == rm_openingScreen) {
			
		// if we can't find the translation, we will see if we
		// can find the key in English
		if (!obj_openingScreen.showDevVars) {
			var englishMap = ds_map_find_value(global.locale_map, "en");
			if (ds_map_exists(englishMap, key)) {
				return ds_map_find_value(englishMap, key);
			}
		}
		
	}
	else if (room == rm_importScreen) {
			
		// if we can't find the translation, we will see if we
		// can find the key in English
		if (!obj_importMapping.showDevVars) {
			var englishMap = ds_map_find_value(global.locale_map, "en");
			if (ds_map_exists(englishMap, key)) {
				return ds_map_find_value(englishMap, key);
			}
		}
		
	}
	
	// if we cannot find anything, we will just return a string version of the key
	return string(key);

}