// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_isStrRTL(str){
	
	// loop through the string and check if it has any RTL characters
	var RTL = false;
	var letterCount = string_length(str);
	for (var i = 0; i <= letterCount; i++) {
		var unicodeValue = ord(string_char_at(str, i));
		if ( 1424 <= unicodeValue and unicodeValue <= 1439 ||
			 1441 <= unicodeValue and unicodeValue <= 1452 ||
			 1454 <= unicodeValue and unicodeValue <= 1484 ||
			 1486 <= unicodeValue and unicodeValue <=1969 ||
			 1984 <= unicodeValue and unicodeValue <= 2143 ||
			 2208 <= unicodeValue and unicodeValue <= 2303 ||
			 64336 <= unicodeValue and unicodeValue <= 65023 ||
			 65136 <= unicodeValue and unicodeValue <= 65279 ||
			 67648 <= unicodeValue and unicodeValue <= 67679 ||
			 68864 <= unicodeValue and unicodeValue <= 68921 ||
			 69216 <= unicodeValue and unicodeValue <= 69247 ||
			 125184 <= unicodeValue and unicodeValue <= 125279 ||
			 126064 <= unicodeValue and unicodeValue <= 126143 ||
			 126208 <= unicodeValue and unicodeValue <= 126287 ||
			 126464 <= unicodeValue and unicodeValue <= 126719){
			RTL = true;
			show_debug_message( string(str) + ":   "+ string(unicodeValue));
		}
	}
	return RTL;

}