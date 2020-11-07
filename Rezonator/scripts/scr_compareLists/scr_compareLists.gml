function scr_compareLists(list1, list2) {
	// Check if the 2 lists are exactly the same

	if (ds_list_size(list1) != ds_list_size(list2)) {
		return false;
	}

	var list1Size = ds_list_size(list1);
	for (var i = 0; i < list1Size; i++) {
		if (ds_list_find_value(list1, i) != ds_list_find_value(list2, i)) {
			return false;
		}
	}

	return true;


}
