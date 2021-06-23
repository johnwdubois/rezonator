function scr_splitStringImport(str, delim) {
	//script credit to: yellow afterlife : https://yal.cc/gamemaker-split-string/
	
	str = string(str);
	var list = ds_list_create();

	var p = string_pos(delim, str);
	var dl = string_length(delim);
	if (dl) while (p) {
	    p -= 1;
	    ds_list_add(list, string_copy(str, 1, p));
	    str = string_delete(str, 1, p + dl);
	    p = string_pos(delim, str);
	}
	ds_list_add(list, str);

	return list;
}