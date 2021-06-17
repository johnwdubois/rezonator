// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_autoCreateChunks(){
	
	// check if we are in an IGT import and that a Word Delimiter is specified
	if (global.importType != global.importType_IGT) exit;
	if (global.wordImportWordDelimColName == "" || !is_string(global.wordImportWordDelimColName)) exit;
	
	show_debug_message("scr_autoCreateChunks");
	
	// make sure we're not in a chain mode, so we're not making chains
	obj_toolPane.currentMode = obj_toolPane.modeRead;
	
	// get full token list
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	if (!scr_isNumericAndExists(discourseSubMap, ds_type_map)) exit;
	var tokenList = discourseSubMap[? "tokenList"];
	if (!scr_isNumericAndExists(tokenList, ds_type_list)) exit;
	var tokenListSize = ds_list_size(tokenList);
	
	// clear inRectToken list and inRectUnit list
	var inRectTokenIDList = obj_control.inRectTokenIDList;
	var inRectUnitIDList = obj_control.inRectUnitIDList;
	ds_list_clear(inRectTokenIDList);
	ds_list_clear(inRectUnitIDList);
	
	var prevWordID = -1;
	
	// loop over tokens and generate chunks based on their ~WordID
	for (var i = 0; i < tokenListSize; i++) {
		
		// get token's tagMap
		var currentToken = tokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) exit;
		var currentTagMap = currentTokenSubMap[? "tagMap"];
		if (!scr_isNumericAndExists(currentTagMap, ds_type_map)) exit;
		
		
		var currentUnit = currentTokenSubMap[? "unit"];
		var currentWordID = currentTagMap[? "~WordID"];
		
		if (i == 0) prevWordID = currentWordID;
		
		// check if this wordID is different, and therefore we should make a new chunk
		if (currentWordID != prevWordID) {
			with (obj_control) scr_createChunk();
			ds_list_clear(inRectTokenIDList);
			ds_list_clear(inRectUnitIDList);
			prevWordID = currentWordID;
		}
		
		// add the current token to the inRect lists
		scr_addToListOnce(inRectTokenIDList, currentToken);
		scr_addToListOnce(inRectUnitIDList, currentUnit);
	}
	
	// make a final chunk if there are any remaining tokens in inRect list
	with (obj_control) scr_createChunk();
	ds_list_clear(inRectTokenIDList);
	ds_list_clear(inRectUnitIDList);
	
	// set user back to track mode
	obj_toolPane.currentMode = obj_toolPane.modeTrack;

}