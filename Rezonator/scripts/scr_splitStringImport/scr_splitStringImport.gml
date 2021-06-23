function scr_splitStringImport(str, delim) {
	str = string(str);
	var list = ds_list_create();

	var partIndex = 1;
	var firstCopyComplete = false;
	
	var strLen = string_length(str);
	for (var i = 1; i <= strLen; i++) {
		if (string_char_at(str, i) ==  delim && i - partIndex > 0) {
			ds_list_add(list, string_copy(str, firstCopyComplete ? partIndex + 1 : partIndex, firstCopyComplete ? i - partIndex - 1 : i - partIndex));
			partIndex = i;
			firstCopyComplete = true;
		}
	}
	if (partIndex < strLen) {
		ds_list_add(list, string_copy(str, partIndex, strLen - partIndex));
	}
	
	return list;

}
