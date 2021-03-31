// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getFirstWordOfChunk(chunkID){
	
	var firstWord = -1;
	
	// get chunkSubMap and see if it exists
	var chunkSubMap = global.nodeMap[? chunkID];
	if (is_numeric(chunkSubMap)) {
		if (ds_exists(chunkSubMap, ds_type_map)) {
			
			// get the chunk's token list and get that list's first item
			var tokenList = chunkSubMap[? "tokenList"];
			if (is_numeric(tokenList)) {
				if (ds_exists(tokenList, ds_type_list)) {
					if (ds_list_size(tokenList) > 0) {
						firstWord = tokenList[| 0];
					}
				}
			}			
		}
	}
	
	return firstWord;

}