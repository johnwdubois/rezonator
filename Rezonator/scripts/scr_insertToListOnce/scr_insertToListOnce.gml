function scr_insertToListOnce(list, pos, value) {
	
	// insert into list at specific position, but only 
	// if the list does not contain the value already
	if (ds_list_find_index(list, value) == -1) {
		ds_list_insert(list, pos, value);
	}

}