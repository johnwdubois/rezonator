// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_isStrRTL(str){
	
	// loop through the string and check if it has any RTL characters
	var RTL = false;
	var letterCount = string_length(str);		
	for (var i = 0; i <= letterCount; i++) {
		var unicodeValue = ord(string_char_at(str, i));
		if ( 1424 <= unicodeValue and unicodeValue <= 1535 ){
			RTL = true;
		}
	}
	return RTL;

}