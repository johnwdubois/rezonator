function scr_isStrNumeric(str) {

	// first let's make sure it's a string
	if (!is_string(str)) return false;
	
	var strLen = string_length(str);
	var strDigits = string_digits(str);
	var strLenDigits = string_length(strDigits);
	
	// make sure it's not a blank string
	if (strLen < 1 || strLenDigits < 1) return false;
	
	// check for positive integer
	if (strLen == strLenDigits) return true;
	
	var decimalFound = string_count(".", str) == 1;
	var hyphenFound = string_count("-", str) == 1 && string_char_at(str, 1) == "-";
	
	if (strLen == strLenDigits + 1 && decimalFound) return true; // check for positive float
	else if (strLen == strLenDigits + 1 && hyphenFound) return true; // check for negative integer
	else if (strLen == strLenDigits + 2 && decimalFound && hyphenFound) return true; // check for negative float
	else return false;

}