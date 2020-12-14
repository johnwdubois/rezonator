// This script works with obj_locale_manager
// Author: Giorgia Troiani
// Last update : 2020 - 11 - 04

function scr_get_translation(key){
	
	
	if ( variable_global_exists("locale_gloss") && ds_map_exists( global.locale_gloss, key ) )
	{
		return ds_map_find_value( global.locale_gloss, key );
	}
	else {
		
		// if we cannot find the translated string...
		// check if developer variables are on
		// if they are, show the raw key value to reveal missing translations
		// if dev variables are off, show the English translation
		
		string(key);
		
	}

}