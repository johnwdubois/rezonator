// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_removeChainFromInChainsList(chainID, tokenID) {
	
	show_debug_message("scr_removeChainFromInChainsList, chainID: " + string(chainID) + ", tokenID: " + string(tokenID) + ", isChunk: " + string(scr_isChunk(tokenID)));
	
	var tokenSubMap = global.nodeMap[? tokenID];
	if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) exit;
	
	// remove the chainID from the word/chunk/token's inChainsList
	var inChainsList = -1;
	var isChunk = scr_isChunk(tokenID);
	if (isChunk) {
		var chunkSubMap = global.nodeMap[? tokenID];
		inChainsList = chunkSubMap[? "inChainsList"];
	}
	else {
		inChainsList = tokenSubMap[? "inChainsList"];				;
	}
	scr_deleteFromList(inChainsList, chainID);
	
	
	/*
	if(!isChunk){
		var wordDrawCol = entryType == "rez" ? obj_control.wordDrawGrid_colBorder : obj_control.wordDrawGrid_colBorderRounded;
		ds_grid_set(obj_control.wordDrawGrid, wordDrawCol, tokenID - 1, false);
		
		var effectColor = 0;
		
		if(ds_list_size(inChainsList) == 1){
			var otherChain = inChainsList[|0]
			var otherChainsSubMap = global.nodeMap[?otherChain];
			effectColor = otherChainsSubMap[?"chainColor"];
			var otherChainType = otherChainsSubMap[?"type"];
			if(otherChainType == "trackChain"){
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, tokenID - 1, true);
			}
			else{
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, tokenID - 1, true);
			}
		}
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, tokenID - 1, effectColor);
	}
	*/
	
}