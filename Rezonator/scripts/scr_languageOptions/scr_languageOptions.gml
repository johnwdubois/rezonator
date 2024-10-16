function scr_languageOptions(optionSelected) {
	
	switch(optionSelected) {

		case "menu_language-en":

			var indexOfLanguage = ds_list_find_index(global.lang_codes, "en")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;
		
		case "menu_language-ca":

			var indexOfLanguage = ds_list_find_index(global.lang_codes, "ca")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;
		
		case "menu_language-it" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "it")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;		

		case "menu_language-es" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "es")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;	
		case "menu_language-he" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "he")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;	
		case "menu_language-vi" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "vi")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;	
		case "menu_language-ja" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "ja")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;
		case "menu_language-gu" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "gu")
			show_debug_message(string(indexOfLanguage))
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;	
		case "menu_language-hy" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "hy")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;	
		case "menu_language-zh" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "zh")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;	
		case "menu_language-kk" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "kk")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;
		case "menu_language-ru" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "ru")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;
		
	}
	
	scr_preImportInitiate();
	
	with (obj_dropDown) {
		instance_destroy();
	}
}