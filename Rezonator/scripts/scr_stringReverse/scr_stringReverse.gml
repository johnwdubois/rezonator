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
			
			
			if ( 1424 > unicodeValue or unicodeValue > 1535 ){
				isNotHE = true;
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

				}
				newString += charToAdd;
			}
			previousUnicodeValue = unicodeValue;
		}
		ds_map_add(global.reverseStrMap, inputString, newString);
		return newString;
	}
	
}