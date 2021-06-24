function scr_splitStringImport(str, delim, skipDelim) {
	//script credit to: yellow afterlife : https://yal.cc/gamemaker-split-string/
	
	str = string(str);
	var list = ds_list_create();

	var p = string_pos(delim, str);
	var dl = string_length(delim);
	if (dl) while (p) {
	    p -= 1;
		
		var strCopy = string_copy(str, 1, p);
		if(skipDelim){
			show_debug_message("str copy: "+string(strCopy) + ",  delim: "+ string(delim));
		}
		if !(skipDelim && strCopy == "") {
			ds_list_add(list, strCopy);
		}

		
	    str = string_delete(str, 1, p + dl);
	    p = string_pos(delim, str);
	}
	ds_list_add(list, str);

	return list;
}