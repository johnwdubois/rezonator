function scr_strOnlyNumAndPeriod(str){
	
	if (!is_string(str)) return "";
	
	// takes a string, removes any characters that are not numbers or periods
	// used for getting a valid version number string
	var strLen = string_length(str);
	var _str = "";
	for (var i = 1; i <= strLen; i++) {
		var _char = string_char_at(str, i);
		if (_char == "0" || _char == "1" || _char == "2"
		|| _char == "3" || _char == "4" || _char == "5"
		|| _char == "6" || _char == "7" || _char == "8"
		|| _char == "9" || _char == ".") _str += _char;
	}
	
	return _str;

}