// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_stringReverse(inputString){
	var newString = "";
	var letterCount = string_length(inputString);
	for(var i = letterCount;i > 0; i--){
		newString += string_char_at(inputString,i);
	}
	return newString;
}