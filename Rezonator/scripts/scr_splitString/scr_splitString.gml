function scr_splitString(str, delim, includeDelim = false, maxSplits = -1) {
	
	var list = ds_list_create();
	var pos = string_pos(delim, str);
	var i = 1;
	var strLen = string_length(str);
	var delimLen = string_length(delim);
	var split = "";
	var splits = 1;
	
	if (delimLen >= 1) {
		while (pos >= 1 && pos <= strLen && (splits < maxSplits || maxSplits <= 0)) {
			splits++;
			split = includeDelim ? string_copy(str, i, pos - i + delimLen) : string_copy(str, i, pos - i);
			ds_list_add(list, split);
			i = pos + delimLen;
			pos = string_pos_ext(delim, str, i);
		}
	}
	
	split = string_delete(str, 1, i - 1);
	ds_list_add(list, split);
	
	return list;

}
