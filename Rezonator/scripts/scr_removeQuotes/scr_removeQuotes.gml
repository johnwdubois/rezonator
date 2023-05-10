function scr_removeQuotes(str){
	
	str = string_replace_all(str, "\"{", "{");
	str = string_replace_all(str, "}\"", "}");
	return str;
	
}