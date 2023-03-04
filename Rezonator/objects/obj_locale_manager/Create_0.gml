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

global.html5 = os_browser != browser_not_a_browser;
global.html5RezFile = "";
global.html5FileRipStr = "";

var delimiter = (os_type == os_windows) ? "\\" : "/";
if (global.html5) delimiter = "/";

if (true) {
	default_locale_code		= "en";
	default_locale_index	= 0;

	native_locale_code		= os_get_language();	// return language of user's system
	native_locale_index		= 0;
	show_debug_message("OS locale: " + native_locale_code);

	if (global.html5) {
		scr_loadLocaleFile("locale_ca.json", delimiter);
		scr_loadLocaleFile("locale_en.json", delimiter);
		scr_loadLocaleFile("locale_es.json", delimiter);
		scr_loadLocaleFile("locale_gu.json", delimiter);
		scr_loadLocaleFile("locale_he.json", delimiter);
		scr_loadLocaleFile("locale_hy.json", delimiter);
		scr_loadLocaleFile("locale_it.json", delimiter);
		scr_loadLocaleFile("locale_ja.json", delimiter);
		scr_loadLocaleFile("locale_kk.json", delimiter);
		scr_loadLocaleFile("locale_ru.json", delimiter);
		scr_loadLocaleFile("locale_vi.json", delimiter);
		scr_loadLocaleFile("locale_zh.json", delimiter);
	}
	else {
		var locale_file_name = file_find_first("IncludedFiles" + delimiter + "Localization" + delimiter + "locale_*.json", 0);		// find the first glossary file matching naming convention
		if ( locale_file_name == "" )										// if file name does not follow convention, ignore it
		{
			show_error( "No locale files found!", true);
			return;
		}
		while ( locale_file_name != "" )									// if file name follows convention
		{
			scr_loadLocaleFile(locale_file_name, delimiter);
			locale_file_name = file_find_next();	
		}
		file_find_close();
	}
	
	

	// set the locale to the player's native locale if possible
	if ( ds_map_exists( global.locale_map, native_locale_code ) )				// if in the global dictionary the native_locale_code is present as a key
	{
		show_debug_message("Setting locale to native language.");
		global.locale_gloss = global.locale_map[? native_locale_code];			// store as locale_gloss the value corresponding to the native_locale_code key (a dictionary): this is the glossary of the language of the user's system
		global.lang_index = native_locale_index;

	// otherwise set it to English
	} else if ( ds_map_exists( global.locale_map, default_locale_code ) ) {
		show_debug_message("Setting locale to default language.");
		global.locale_gloss = global.locale_map[? default_locale_code];
		global.lang_index = default_locale_index;

	// if all else failes, use the first language on the stack
	} else {
		show_debug_message("Setting locale to fallback language.");
		global.lang_index = 0;
		global.locale_gloss = global.locale_map[? global.lang_codes[| 0]];
	}

	show_debug_message("Locale set to " + global.lang_codes[| global.lang_index]);
}