

function scr_stringReverse(inputString){
	
	if (ds_map_exists(global.reverseStrMap, inputString)) {
		return ds_map_find_value(global.reverseStrMap, inputString);
	}
	else {
		var newString = "";
		var letterCount = string_length(inputString);
		var nonReverseChars = "";
		var newNonReverseChars = "";
		var isRTL = false;
		var isPrevRTL = false;
		var previousUnicodeValue = 1425;
		for(var i = letterCount;i > 0; i--){
			var charToAdd = string_char_at(inputString,i);
			if(charToAdd == "\n" ||charToAdd == "\r" ){continue;}
			var unicodeValue = ord(string_char_at(inputString,i));
			
			
			if ( 1424 <= unicodeValue and unicodeValue <= 1969 ||
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
				isRTL = true;
			}
			else{
				isRTL = false;
			}
			if ( 1424 <= previousUnicodeValue and previousUnicodeValue <= 1969 ||
			 1984 <= previousUnicodeValue and previousUnicodeValue <= 2143 ||
			 2208 <= previousUnicodeValue and previousUnicodeValue <= 2303 ||
			 64336 <= previousUnicodeValue and previousUnicodeValue <= 65023 ||
			 65136 <= previousUnicodeValue and previousUnicodeValue <= 65279 ||
			 67648 <= previousUnicodeValue and previousUnicodeValue <= 67679 ||
			 68864 <= previousUnicodeValue and previousUnicodeValue <= 68921 ||
			 69216 <= previousUnicodeValue and previousUnicodeValue <= 69247 ||
			 125184 <= previousUnicodeValue and previousUnicodeValue <= 125279 ||
			 126064 <= previousUnicodeValue and previousUnicodeValue <= 126143 ||
			 126208 <= previousUnicodeValue and previousUnicodeValue <= 126287 ||
			 126464 <= previousUnicodeValue and previousUnicodeValue <= 126719){
				isPrevRTL = true;
			}
			else{
				isPrevRTL = false;
			}
			
			
			if(!isRTL){
				nonReverseChars+=charToAdd
				if(i == 1){
					var nonReverseletterCount = string_length(nonReverseChars);
					for(var j = nonReverseletterCount;j > 0; j--){
						if(j == nonReverseletterCount){
							newNonReverseChars += " ";
						}
						newNonReverseChars += string_char_at(nonReverseChars,j);
					}
					newString += newNonReverseChars;
					newNonReverseChars = "";
					nonReverseChars = "";
				
				}
			}
			else{
				if(!isPrevRTL){
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
		show_debug_message("input:  "+ string(inputString) + "   -  reversed: "+string(newString))
		ds_map_add(global.reverseStrMap, inputString, newString);
		return newString;
	}
	
}