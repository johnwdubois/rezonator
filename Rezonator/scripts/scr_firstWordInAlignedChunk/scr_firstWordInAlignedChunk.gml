// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_firstWordInAlignedChunk(wordID){
	
	// if this word is the first word in an aligned chunk,
	// then return the chainID for the aligned chain on that chunk
	// otherwise return ""
	
	var alignedChunkChainID = "";
	var wordInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, wordID - 1);
	var wordInBoxListSize = ds_list_size(wordInBoxList);
	for (var i = 0; i < wordInBoxListSize; i++) {
		var currentChunk = wordInBoxList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) {
			var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
			if (scr_isNumericAndExists(currentChunkInChainsList, ds_type_list)) {
				if (scr_getFirstWordOfChunk(currentChunk) == wordID) {
					var currentChunkInChainsListSize = ds_list_size(currentChunkInChainsList);
					for (var j = 0; j < currentChunkInChainsListSize; j++) {
						var currentChunkInChain = currentChunkInChainsList[| j];
						var currentChunkInChainSubMap = global.nodeMap[? currentChunkInChain];
						if (currentChunkInChainSubMap[? "alignChain"]) alignedChunkChainID = currentChunkInChain;
					}
				}
			}
		}
	}
	
	return alignedChunkChainID;

}