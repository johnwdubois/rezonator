function scr_listSwap(list, indexA, indexB) {
	
	// takes a list and swaps the positions of indexA and indexB
	var valueA = ds_list_find_value(list, indexA);
	var valueB = ds_list_find_value(list, indexB);
	ds_list_set(list, indexA, valueB);
	ds_list_set(list, indexB, valueA);

}