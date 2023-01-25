function scr_loadLocaleFile(locale_file_name, delimiter) {

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

}