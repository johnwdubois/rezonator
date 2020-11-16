// This script works with obj_locale_manager
// Author: Giorgia Troiani
// Last update : 2020 - 11 - 04

function scr_get_translation(key){
	
if ( variable_global_exists("locale_gloss") && ds_map_exists( global.locale_gloss, key ) )
{
	return ds_map_find_value( global.locale_gloss, key );
} else {
	
	// return the English value if nothing is found
	// return ds_map_find_value( "locale_en" , key );
	
	// substitute this code line immediately above to test translation for debugging purposes.
	// it will print the kay value of each pair for which the translation is missing:
	
	return string(key);
}


}