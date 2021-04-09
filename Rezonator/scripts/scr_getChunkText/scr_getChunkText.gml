// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getChunkText(chunkID, tokenField){
	
	// this function will return a concatenated string of the tokens in the chunkID, for the specified tokenField
	var chunkText = "";
	var chunkSubMap = global.nodeMap[? chunkID];
	
	var fieldIndex = ds_list_find_index(global.tokenImportColNameList, tokenField);
	if (fieldIndex >= 0) {
		if (is_numeric(chunkSubMap)) {
			if (ds_exists(chunkSubMap, ds_type_map)) {
			
				var tokenList = chunkSubMap[? "tokenList"];
				var tokenListSize = ds_list_size(tokenList);
				for (var i = 0; i < tokenListSize; i++) {
					var currentTokenID = tokenList[| i];
					if (is_numeric(currentTokenID)) {
						var currentTokenStr = ds_grid_get(global.tokenImportGrid, fieldIndex, currentTokenID - 1);
						chunkText += string(currentTokenStr);
						if (i < tokenListSize - 1) chunkText += " ";
					}
				}
			
			}
		}
	}
	
	
	return chunkText;

}