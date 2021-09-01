// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_removeChainFromInChainsList(chainID, entryID, tokenID) {
	
	show_debug_message("scr_removeChainFromInChainsList, chainID: " + string(chainID) + ", entryID: " + string(entryID) + ", tokenID: " + string(tokenID) + ", isChunk: " + string(scr_isChunk(tokenID)));
	
	var tokenSubMap = global.nodeMap[? tokenID];
	if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) exit;
	
	// remove the chainID from the word/chunk/token's inChainsList
	var inChainsList = -1;
	var inEntryList = -1;
	var isChunk = scr_isChunk(tokenID);
	if (isChunk) {
		var chunkSubMap = global.nodeMap[? tokenID];
		inChainsList = chunkSubMap[? "inChainsList"];
		inEntryList = chunkSubMap[? "inEntryList"];
	}
	else {
		inChainsList = tokenSubMap[? "inChainsList"];
		inEntryList = tokenSubMap[? "inEntryList"];
	}
	scr_deleteFromList(inChainsList, chainID);
	scr_deleteFromList(inEntryList, entryID);
	

	
}