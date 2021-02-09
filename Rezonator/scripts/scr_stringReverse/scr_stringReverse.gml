// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_stringReverse(inputString){
	
	if (ds_map_exists(global.reverseStrMap, inputString)) {
		return ds_map_find_value(global.reverseStrMap, inputString);
	}
	else {
		var newString = "";
		var letterCount = string_length(inputString);
		for(var i = letterCount;i > 0; i--){
			newString += string_char_at(inputString,i);
		}
		ds_map_add(global.reverseStrMap, inputString, newString);
		return newString;
	}
	
}