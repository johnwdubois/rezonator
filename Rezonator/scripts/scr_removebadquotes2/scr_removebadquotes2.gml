function scr_removeBadQuotes2(str) {
	
	show_debug_message("scr_removeBadQuotes2, str: " + string(str));
	str = string_replace_all(str, "\"{", "{");
	str = string_replace_all(str, "}\"", "}");
	show_debug_message("scr_removeBadQuotes2, end: " + string(str));
	
	return str;
	
}