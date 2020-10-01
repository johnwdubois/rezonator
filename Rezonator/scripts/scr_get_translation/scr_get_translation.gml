// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_get_translation(key){
	
if ( variable_global_exists("locale_gloss") && ds_map_exists( global.locale_gloss, key ) )
{
	return ds_map_find_value( global.locale_gloss, key );
} else {
	return "MISSING TRANSLATION: " + string(key);
}

// add here another loop to specify that if translation is missing, program has to run the english value
}