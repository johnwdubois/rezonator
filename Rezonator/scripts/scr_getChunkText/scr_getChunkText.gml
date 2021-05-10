// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getChunkText(chunkID){
	
	// this function will return a concatenated string of the tokens in the chunkID, for the specified tokenField
	var chunkText = "";
	var chunkSubMap = global.nodeMap[? chunkID];
	
	var nodeType = chunkSubMap[?"type"];



	if (global.displayTokenField != "" && is_string(global.displayTokenField)) {
		if (scr_isNumericAndExists(chunkSubMap, ds_type_map)){
			var tokenList = chunkSubMap[? "tokenList"];
			var tokenListSize = ds_list_size(tokenList);
			for (var i = 0; i < tokenListSize; i++) {
				var currentTokenID = tokenList[| i];
				var tokenSubMap = global.nodeMap[?currentTokenID];
				if (scr_isNumericAndExists(tokenSubMap, ds_type_map)) {
					var tokenTagMap = tokenSubMap[?"tagMap"];
					var currentTokenStr = tokenTagMap[?global.displayTokenField];
					chunkText += string(currentTokenStr);
					if (i < tokenListSize - 1) chunkText += " ";
				}
			}
		}
	}

	return chunkText;

}