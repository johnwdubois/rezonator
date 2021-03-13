// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_languageOptions(optionSelected){
	switch(optionSelected){

		case "menu_language-en":

			var indexOfLanguage = ds_list_find_index(global.lang_codes, "en")
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
		case "menu_language-zh" :
		
			var indexOfLanguage = ds_list_find_index(global.lang_codes, "zh")
			global.locale_gloss = global.locale_map[? global.lang_codes[| indexOfLanguage]];	
			global.lang_index = indexOfLanguage;
		
		break;	
		
	}
	scr_fontGlobalUpdate();
	
	with(obj_dropDown){
		instance_destroy();
	}
}