function scr_splitStringMulti(str, delims, includeDelim = false, maxSplits = -1, exceptions = undefined) {
	
	// splits str on multiple delimiters
	var list = ds_list_create();
	var posStruct = stringPosExtMulti(delims, str, 1);
	var _pos = posStruct.pos;
	var _delim = posStruct.subStr;
	delete posStruct;
	var i = 1;
	var strLen = string_length(str);
	var splits = 1;
	
	while (_pos >= 1 && _pos <= strLen && (splits < maxSplits || maxSplits <= 0)) {
		splits++;
		var split = includeDelim ? string_copy(str, i, _pos - i + string_length(_delim)) : string_copy(str, i, _pos - i);
		
		// trim whitespace
		split = string_trim(split)
		if (string_length(split) >= 1) ds_list_add(list, split);
		
		i = _pos + string_length(_delim);
		posStruct = stringPosExtMulti(delims, str, i, exceptions);
		_pos = posStruct.pos;
		_delim = posStruct.subStr;
		delete posStruct;
	}
	
	split = string_delete(str, 1, i - 1);
	split = string_trim(split);
	if (string_length(split) >= 1) ds_list_add(list, split);
	
	return list;
}

function stringPosExtMulti(subStrs, str, startPos, exceptions = undefined) {
	
	// find the first instance of any of the given substrings
	var result = {
		pos : 0,
		subStr : ""
	};
	
	var subStrsSize = ds_list_size(subStrs);
	for (var i = 0; i < subStrsSize; i++) {
		var _subStr = subStrs[| i];
		var strPos = stringPosExtExceptions(_subStr, str, startPos, exceptions);
		
		if (strPos >= 1 && (strPos < result.pos || result.pos < 1)) {
			result.pos = strPos;
			result.subStr = _subStr;
		}
	}
	
	return result;
}

function stringPosExtExceptions(subStr, str, startPos, exceptions) {
	
	// like string_pos_ext, but also ignoring a list of exceptions
	var pos = string_pos_ext(subStr, str, startPos);
	if (!is_numeric(exceptions)) return pos;
	if (!ds_exists(exceptions, ds_type_list)) return pos;
	
	// if we could not find the subStr at all, return
	if (pos < 1) return pos;
	
	// assuming we were able to find the subStr, check if it is in any exceptions
	var exceptionsSize = ds_list_size(exceptions);
	for (var i = 0; i < exceptionsSize; i++) {
		var _exception = exceptions[| i];
		var _exceptionLen = string_length(_exception);
		var _copyPos = pos - _exceptionLen + 1;
		
		if (_copyPos >= 1) {
			var _copy = string_copy(str, _copyPos, _exceptionLen);
			if (_copy == _exception) {
				// we have found an exception and should skip to the next string_pos_ext
				// we do this by moving the start position up further
				pos = stringPosExtExceptions(subStr, str, pos + 1, exceptions);
			}
		}
	}
	
	return pos;
}