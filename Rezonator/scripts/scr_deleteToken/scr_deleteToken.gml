// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteToken(tokenID){
	
	// get token submap and make sure it exists
	show_debug_message("scr_deleteToken ... tokenID: " + string(tokenID));
	var tokenSubMap = global.nodeMap[? tokenID];
	if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) exit;
	
	
	// get the unit for this token, and find what index this token is in that unit's entry list
	var unitID = tokenSubMap[? "unit"];
	var unitSubMap = global.nodeMap[? unitID];
	var entryListIndex = -1;
	var entryList = unitSubMap[? "entryList"];
	var entryListSize = ds_list_size(entryList);
	for (var i = 0; i < entryListSize; i++) {
		var currentEntry = entryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		if (currentToken == tokenID) {
			entryListIndex = i;
		}
	}
	
	// update tokenSeq values
	var tokenSeq = tokenSubMap[? "tokenSeq"];
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var discourseTokenList = discourseSubMap[? "tokenList"];
	var discourseTokenListSize = ds_list_size(discourseTokenList);
	var tokenListIndex = ds_list_find_index(discourseTokenList, tokenID);
	for (var i = tokenListIndex + 1; i < discourseTokenListSize; i++) {
		var currentToken = discourseTokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentUnit = currentTokenSubMap[? "unit"];
		
		// if this token is in the same unit as our deleted token, let's decrement its tokenSeq
		if (currentUnit == unitID) {
			currentTokenSubMap[? "tokenSeq"]--;
		}
		
		// always decrement discourseTokenSeq
		currentTokenSubMap[? "discourseTokenSeq"]--;
	}
	
	
	// remove this token from all chains that it is in
	var inChainsList = tokenSubMap[?"inChainsList"];
	while (ds_list_size(inChainsList) > 0) {
		scr_deleteFromChain(true);
	}
	
	
	// remove this token's entry from the unit's entry list
	ds_list_delete(entryList, entryListIndex);
	
	// remove this token from the discourse's tokenList
	scr_deleteFromList(discourseTokenList, tokenID);
	
	// remove this token from the nodeMap :o
	ds_map_delete(global.nodeMap, tokenID);
	
	// collect & destroy all of this token's sub-data structures
	var tagMap = tokenSubMap[? "tagMap"];
	var inChainsList = tokenSubMap[? "inChainsList"];
	var inChunkList = tokenSubMap[? "inChunkList"];
	if (scr_isNumericAndExists(tagMap, ds_type_map)) ds_map_destroy(tagMap);
	if (scr_isNumericAndExists(inChainsList, ds_type_list)) ds_list_destroy(inChainsList);
	if (scr_isNumericAndExists(inChunkList, ds_type_list)) ds_list_destroy(inChunkList);
	
	// destroy this token's submap
	ds_map_destroy(tokenSubMap);
	

}