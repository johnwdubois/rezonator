// This script works with obj_locale_manager
// Author: Giorgia Troiani
// Last update : 2020 - 11 - 04

function scr_get_translation(key){
	
	// look for the key in the current language's map
	// if we can find the translation, return the translation
	
	if (variable_global_exists("locale_gloss") && ds_map_exists( global.locale_gloss, key )) {
		return ds_map_find_value( global.locale_gloss, key );
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