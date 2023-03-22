function scr_splitStringWhitespace(str) {
	
	var splitList = ds_list_create();
	
	var firstSpace = string_pos(" ", str);
	var firstTab = string_pos("	", str);
	
	// if there is no space and no tab in the string, put the entire str in splitList and return splitList
	if (firstSpace == 0 && firstTab == 0) {
		ds_list_add(splitList, str);
	}
	else {
	
		// if either a space or tab still exists in the string, find the first of the two and copy until then
		while (firstSpace > 0 || firstTab > 0) {
		
			var strClip = "";
		
			// if there is a space but no tab, copy from the first character to the space
			if (firstSpace > 0 && firstTab == 0) {
				strClip = string_copy(str, 1, firstSpace - 1);
				str = string_delete(str, 1, firstSpace);
			}
			// if there is a tab but no space, copy from the first character to the tab
			else if (firstTab > 0 && firstSpace == 0) {
				strClip = string_copy(str, 1, firstTab - 1);
				str = string_delete(str, 1, firstTab);
			}
			// if there is a space and a tab...
			else if (firstSpace > 0 && firstTab > 0) {
		
				// if the space comes before the tab, copy to the first space
				if (firstSpace <= firstTab) {
					strClip = string_copy(str, 1, firstSpace - 1);
					str = string_delete(str, 1, firstSpace);
				}
				// if the tab comes before the space, copy to the first tab
				else {
					strClip = string_copy(str, 1, firstTab - 1);
					str = string_delete(str, 1, firstTab);
				}
			}
		
			// add strClip to the splitList
			if (!scr_isStrOnlyWhitespace(strClip)) {
				ds_list_add(splitList, strClip);
			}
		
			// reset firstSpace and firstTab
			firstSpace = string_pos(" ", str);
			firstTab = string_pos("	", str);
		}
		
		// if there is anything left in str that is not whitespace, add it to the splitList
		if (!scr_isStrOnlyWhitespace(str)) {
			ds_list_add(splitList, str);
		}
	}
	
	return splitList;

}