// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteNewWord(){
	
	var currentWordID = -1;
	
	
	if(obj_control.newWordHoverWordID > -1 and obj_control.newWordHoverWordID <=(ds_grid_height(obj_control.dynamicWordGrid))) {
		currentWordID = obj_control.newWordHoverWordID;
	}
	
	
	var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
	
	if(currentWordState != obj_control.wordStateChunk and currentWordState != obj_control.wordStateNew) {
		exit;
	}
	
	var inChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordID - 1);
	var inChainsListSize = ds_list_size(inChainsList);
	
	// next, we need see if the new word had any chains it was apart of and remove it from them
	var chainToSelect = "";
	repeat(inChainsListSize){
		var currentChain = inChainsList[|0];
		chainToSelect = currentChain;
	
		if (chainToSelect != "" || ds_map_exists(global.nodeMap, chainToSelect)) {
			show_debug_message("scr_rightclickwordOptions() ... word has no chains no slectioon should happen...");
			obj_chain.currentFocusedChainID = chainToSelect;
			scr_refocusChainEntry(currentWordID)
			scr_deleteFromChain(true);
			scr_unFocusAllChains();
		}
	
	}
	
	// Set the word state to dead
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1, obj_control.wordStateDead);


}