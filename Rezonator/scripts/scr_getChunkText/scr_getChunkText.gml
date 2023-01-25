

function scr_getChunkText(chunkID) {
	
	// this function will return a concatenated string of the tokens in the chunkID, for the specified tokenField
	var chunkText = "";
	var chunkSubMap = global.nodeMap[? chunkID];
	
	var rtl = scr_checkRTL();



	if (global.displayTokenField != "" && is_string(global.displayTokenField)) {
		if (scr_isNumericAndExists(chunkSubMap, ds_type_map)) {
			var tokenList = chunkSubMap[? "tokenList"];
			var tokenListSize = ds_list_size(tokenList);
			
			var i = (rtl) ? tokenListSize - 1 : 0;
			
			repeat (tokenListSize) {
				var currentTokenID = tokenList[| i];
				var tokenSubMap = global.nodeMap[?currentTokenID];
				if (scr_isNumericAndExists(tokenSubMap, ds_type_map)) {
					var tokenTagMap = tokenSubMap[? "tagMap"];
					var currentTokenStr = tokenTagMap[?global.displayTokenField];
					chunkText += string(currentTokenStr);
					if (!rtl && i < tokenListSize - 1) chunkText += " ";
					else if (rtl && i > 0) chunkText += " ";
				}
				
				i += (rtl) ? -1 : 1;
			}
		}
	}

	return chunkText;

}