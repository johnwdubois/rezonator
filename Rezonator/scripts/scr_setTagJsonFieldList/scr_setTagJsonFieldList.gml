function scr_setTagJsonFieldList(tagJsonFieldList, navFieldList) {
	
	if (scr_isNumericAndExists(tagJsonFieldList, ds_type_list)) {
		if (ds_list_size(tagJsonFieldList) >= 1) {
			navFieldList = tagJsonFieldList;
		}
	}

}