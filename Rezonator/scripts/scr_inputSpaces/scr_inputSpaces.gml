

function scr_inputSpaces(fullString){
	
			var newString = "";
			var letterCount = string_length(fullString);
			for(var j = 1;j <= letterCount; j++){
				var charFromFile = string_char_at(fullString,j);
				var nextChar = string_char_at(fullString,j+1);
				var unicodeValue = ord(charFromFile);
				var nextUnicodeValue = ord(nextChar);
				
				newString += charFromFile;
				
				if ( (12288 <= unicodeValue  and unicodeValue <= 40959)  or
				(63744 <= unicodeValue  and unicodeValue <= 64255) or
				(131072 <= unicodeValue  and unicodeValue <= 183983) or
				(194560 <= unicodeValue  and unicodeValue <= 195103) ){
					newString += " ";
				}
				else if ( (12288 <= nextUnicodeValue  and nextUnicodeValue <= 40959)  or
				(63744 <= nextUnicodeValue  and nextUnicodeValue <= 64255) or
				(131072 <= nextUnicodeValue  and nextUnicodeValue <= 183983) or
				(194560 <= nextUnicodeValue  and nextUnicodeValue <= 195103) ){
					newString += " ";
				}
				
			}
			
			return newString;

}