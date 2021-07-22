// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_expandChunk(chunkID){

	var chunkSubMap = global.nodeMap[? chunkID];
	if(!scr_isNumericAndExists(chunkSubMap, ds_type_map)){exit;}
	if(ds_list_find_index(obj_chain.encounteredChunkList, chunkID) >= 0){exit;}
	ds_list_add(obj_chain.encounteredChunkList, chunkID);
	
	var chunkNest = chunkSubMap[?"nest"];
	chunkSubMap[?"nest"] = chunkNest + 1;
	
	show_debug_message("scr_expandChunk, chunkID: " + string(chunkID));
	
	var tokenList = chunkSubMap[?"tokenList"];
	var tokenListSize = ds_list_size(tokenList);
	
	for(var i = 0; i < tokenListSize; i++){
	
		var currentToken = tokenList[|i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var tokenInChunkList = currentTokenSubMap[?"inChunkList"];
		
		var chunkListSize = ds_list_size(tokenInChunkList);
		for(var j = 0; j < chunkListSize; j++){
			var currentChunk = tokenInChunkList[|j];
			var currentChunkSubMap = global.nodeMap[? currentChunk];
			var currentChunkNest = currentChunkSubMap[? "nest"];
			
			if (currentChunkNest >= chunkNest) scr_expandChunk(currentChunk);
		}
	}

}