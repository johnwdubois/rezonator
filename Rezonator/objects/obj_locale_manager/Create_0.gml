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

var delimiter = (os_type == os_macosx) ? "/" : "\\";
var locale_file_name = file_find_first( "IncludedFiles" + delimiter + "Localization" + delimiter + "locale_*.json", 0 );		// find the first glossary file matching naming convention

show_debug_message("locale_file_name: " + string(locale_file_name));
if ( locale_file_name == "" )										// if file name does not follow convention, ignore it
{
	show_error( "No locale files found!", true );
	return;
}
while ( locale_file_name != "" )									// if file name follows convention
{
	var locale_file_name_full = "IncludedFiles" + delimiter + "Localization" + delimiter + locale_file_name;
	show_debug_message("Loading locale file: " + locale_file_name_full );

	var locale_file	= file_text_open_read( locale_file_name_full );		// open the glossary file for reading
	if ( locale_file == -1 )										// return error message if there are issues within the glossary file
	{
		show_error( "LOCALE WARNING: Error reading locale file " + locale_file_name, true);
		return;
	}

	var json_str	= "";									// create an empty variable
	var j = 0;
	while ( !file_text_eof(locale_file) )					// until the end of file is reached
	{
		json_str += file_text_read_string(locale_file);		// add to json_str the content of each file
		file_text_readln(locale_file);
		j++;
	}
	file_text_close(locale_file);
	show_debug_message( "Loaded locale_map from " + string(j) + " lines of text." );

	var locale_gloss = json_decode(json_str);					// convert the JSON to a usable ds_map
	
	if ( locale_gloss == -1 || !ds_map_exists( locale_gloss, "locale_code" ) )   // if glossary file does not contain the key "locale_code"
	{
		show_error( "LOCALE WARNING: Invalid locale data inside: " + locale_file_name, true );
		return;
	}
	
	var locale_code = locale_gloss[? "locale_code"];				// store the value corresponding to the key "locale_code" (a 2-letter lang code)
	ds_map_add( global.locale_map, locale_code, locale_gloss );		// add it to a dictionary where "locale_code" is the key and "locale_gloss" (a dictionary) is the value
	show_debug_message("Loaded locale_code " + locale_code + " from " + locale_file_name);

	// set up the hierarchy of languages used by user
	if ( locale_code == native_locale_code )						// if this is the native locale, set the native locale index
		native_locale_index = global.lang_index;
	// if this is the default locale, set the default locale index
	else if ( locale_code == default_locale_code )
		default_locale_index = global.lang_index;

	// add this locale's code to the list of available locales
	global.lang_codes[| global.lang_index] = locale_code;
	global.lang_index++;	

	locale_file_name = file_find_next();	
}
file_find_close();

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

show_debug_message("Locale set to " + global.lang_codes[| global.lang_index] );