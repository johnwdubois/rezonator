

function scr_appearancesInList(list, val) {
	
	// returns how many times val appears in list
	
	var listCopy = ds_list_create();
	ds_list_copy(listCopy, list);
	var count = 0;
	
	var index = ds_list_find_index(listCopy, val);
	while (index >= 0) {
		count++;
		ds_list_delete(listCopy, index);
		index = ds_list_find_index(listCopy, val);
	}
	
	ds_list_destroy(listCopy);
	return count;
	
}