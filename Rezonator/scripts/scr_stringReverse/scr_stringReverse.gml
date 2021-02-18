// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_stringReverse(inputString){
	
	if (ds_map_exists(global.reverseStrMap, inputString)) {
		return ds_map_find_value(global.reverseStrMap, inputString);
	}
	else {
		var newString = "";
		var letterCount = string_length(inputString);
		var nonReverseChars = "";
		var newNonReverseChars = "";
		var isNotHE = false;
		var isPrevNotHE = false;
		var previousUnicodeValue = 1425;
		for(var i = letterCount;i > 0; i--){
			var charToAdd = string_char_at(inputString,i);
			if(charToAdd == "\n" ||charToAdd == "\r" ){continue;}
			
			var unicodeValue = ord(string_char_at(inputString,i));
			show_debug_message("scr_stringReverse: unicodeValue: " + string(unicodeValue) + ",   char: " + string(charToAdd));
			
			if ( 1424 > unicodeValue or unicodeValue > 1535 ){
				isNotHE = true;
				show_debug_message("scr_stringReverse: unicodeValue is not HE: " + string(unicodeValue) + ",     isNotHE: " + string(isNotHE) +",   isPrevNotHE: " + string(isPrevNotHE));
			}
			else{
				isNotHE = false;
			}
			if ( 1424 > previousUnicodeValue or previousUnicodeValue > 1535 ){
				isPrevNotHE = true;
			}
			else{
				isPrevNotHE = false;
			}
			
			
			if(isNotHE){
				nonReverseChars+=charToAdd
				show_debug_message("scr_stringReverse: nonreversed: " + string(nonReverseChars));
				if(i == 1){
					var nonReverseletterCount = string_length(nonReverseChars);
					for(var j = nonReverseletterCount;j > 0; j--){
						newNonReverseChars += string_char_at(nonReverseChars,j);
					}
					newString += newNonReverseChars;
					newNonReverseChars = "";
					nonReverseChars = "";
				
				}
			}
			else{
				if(isPrevNotHE){
					var nonReverseletterCount = string_length(nonReverseChars);
					for(var j = nonReverseletterCount;j > 0; j--){
						newNonReverseChars += string_char_at(nonReverseChars,j);
					}
					newString += newNonReverseChars;
					newNonReverseChars = "";
					nonReverseChars = "";
					show_debug_message("scr_stringReverse: newString newnonreversed: " + string(newString));

				}
				newString += charToAdd;
			}
			previousUnicodeValue = unicodeValue;
		}
		ds_map_add(global.reverseStrMap, inputString, newString);
		return newString;
	}
	
}