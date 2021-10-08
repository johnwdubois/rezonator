var localeStrList = scr_localeMaps();
var localeStrListSize = ds_list_size(localeStrList);
show_debug_message("localeStrListSize: " + string(localeStrListSize));


/*
	obj_locale_manager:Create
	
	Last Updated: 2020 - 31 - 08
	
	Author: Giorgia Troiani
*/

// this script presupposes that each glossary is stored separatedly and follows a specific formatting
// check with translators that they are following these conventions

// create 4 global variables that maintain accessibility of translation in entire program
global.lang_codes		= ds_list_create();					// create an array to store the 2-letter code of supported languages
global.lang_index		= 0;
global.locale_map		= ds_map_create();		// create a dictionary that stores the glossaries for all supported languages
global.locale_gloss		= ds_map_create();		// create a dictionary that stores the glossary for a single language

var default_locale_code		= "en";
var default_locale_index	= 0;

var native_locale_code		= os_get_language();	// return language of user's system
var native_locale_index		= 0;
show_debug_message("OS locale: " + native_locale_code);


for (var i = 0; i < localeStrListSize; i++) {
	
	var json_str = localeStrList[| i];	// create an empty variable

	var locale_gloss = json_decode(json_str);					// convert the JSON to a usable ds_map
	show_debug_message("i: " + string(i) + ", map size: " + string(ds_map_size(locale_gloss)));
	
	if ( locale_gloss == -1 || !ds_map_exists( locale_gloss, "locale_code" ) )   // if glossary file does not contain the key "locale_code"
	{
		show_error( "i: " + string(i) + ", LOCALE WARNING: Invalid locale data inside: ", true );
		continue;
	}
	
	
	var locale_code = locale_gloss[? "locale_code"];				// store the value corresponding to the key "locale_code" (a 2-letter lang code)
	ds_map_add_map( global.locale_map, locale_code, locale_gloss );		// add it to a dictionary where "locale_code" is the key and "locale_gloss" (a dictionary) is the value
	show_debug_message("Loaded locale_code " + locale_code + " from ");

	// set up the hierarchy of languages used by user
	if ( locale_code == native_locale_code )						// if this is the native locale, set the native locale index
		native_locale_index = global.lang_index;
	// if this is the default locale, set the default locale index
	else if ( locale_code == default_locale_code )
		default_locale_index = global.lang_index;

	// add this locale's code to the list of available locales
	show_debug_message("global.lang_index: " + string(global.lang_index));
	global.lang_codes[| global.lang_index] = locale_code;
	global.lang_index++;	



	// set the locale to the player's native locale if possible
	if ( ds_map_exists( global.locale_map, native_locale_code ) )				// if in the global dictionary the native_locale_code is present as a key
	{
		show_debug_message("Setting locale to native language.");
		global.locale_gloss = global.locale_map[? native_locale_code];			// store as locale_gloss the value corresponding to the native_locale_code key (a dictionary): this is the glossary of the language of the user's system
		//global.lang_index = native_locale_index;

	// otherwise set it to English
	} else if ( ds_map_exists( global.locale_map, default_locale_code ) ) {
		show_debug_message("Setting locale to default language.");
		global.locale_gloss = global.locale_map[? default_locale_code];
		//global.lang_index = default_locale_index;

	// if all else failes, use the first language on the stack
	} else {
		show_debug_message("Setting locale to fallback language.");
		//global.lang_index = 0;
		global.locale_gloss = global.locale_map[? global.lang_codes[| 0]];
	}
}

show_debug_message("lang_codes: " + scr_getStringOfList(global.lang_codes));

//show_debug_message("Locale set to " + global.lang_codes[| global.lang_index] );
//show_debug_message("locale_gloss size: " + string(ds_map_size(global.locale_gloss)));