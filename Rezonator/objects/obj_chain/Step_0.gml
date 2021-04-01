/*
	obj_chain: Step
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Consistently update attributes of chain objects
	
	Mechanism: Hide/reveal the mouseLine depending on mouse position, use on the grid connected to the tool in use, and keep focused chains visible in the focus view. 
	
	Author: Terry DuBois
*/

if(keyboard_check_pressed(ord("A")) and keyboard_check(vk_control) and not (!obj_control.shortcutsEnabled || obj_control.dialogueBoxActive || obj_panelPane.discoSelectionActive)) {
	//kinda broken rn
	//showPlaceChains = !showPlaceChains;	
}


// set mouseLineWordID & fillRect
mouseLineWordID = -1;
ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
if (ds_map_exists(global.nodeMap, currentFocusedChainID)) {
	var chainSubMap = ds_map_find_value(global.nodeMap, currentFocusedChainID);
	if (ds_exists(chainSubMap, ds_type_map)) {
		var chainType = ds_map_find_value(chainSubMap, "type");
		if (chainType == "rezChain" || chainType == "trackChain") {
			var focusedEntry = ds_map_find_value(chainSubMap, "focused");
			var focusedEntrySubMap = ds_map_find_value(global.nodeMap, focusedEntry);
			if (is_numeric(focusedEntrySubMap)) {
				if (ds_exists(focusedEntrySubMap, ds_type_map)) {
					var focusedEntryWordID = ds_map_find_value(focusedEntrySubMap, "word");
					var focusedEntryChunkFirstWord = scr_getFirstWordOfChunk(focusedEntryWordID);
					mouseLineWordID = (focusedEntryChunkFirstWord >= 0) ? focusedEntryChunkFirstWord : focusedEntryWordID;
					if(focusedEntryChunkFirstWord < 0){
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, focusedEntryWordID - 1, true);
					}
				}
			}
		}
	}
}


ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, 0, obj_control.wordDrawGrid_colFocused, ds_grid_height(obj_control.wordDrawGrid), false);

if (ds_map_exists(global.nodeMap, currentFocusedChainID)) {
	
	var currentFocusedChainSubMap = ds_map_find_value(global.nodeMap, currentFocusedChainID);
	var currentFocusedChainType = ds_map_find_value(currentFocusedChainSubMap, "type");
	
	if (currentFocusedChainType == "rezChain" or currentFocusedChainType == "trackChain") {
		var setIDList = ds_map_find_value(currentFocusedChainSubMap, "setIDList");
		if (is_numeric(setIDList)) {
			if (ds_exists(setIDList, ds_type_list)) {
				var setIDListSize = ds_list_size(setIDList);
				for (var i = 0; i < setIDListSize; i++) {
					var currentEntry = ds_list_find_value(setIDList, i);
					var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
					var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
					focusedEntryChunkFirstWord = scr_getFirstWordOfChunk(currentWordID);
					//set grid stuff if is not a chunk
					if(focusedEntryChunkFirstWord < 0){
								
						var isVisible = ds_grid_get(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colVisible, currentWordID - 1);
						var isChunk = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
			
						if (isVisible || isChunk) {
							ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentWordID - 1, true);
						}
					
					}
				}
			}
		}
	}
	// CHAIN REHAUL: revisit this chunk stuff
	// Focus specifically for Chunks
	/*
	else if (currentChainGrid == chunkGrid) {
		var chunkWordID = ds_grid_get(chunkGrid, chainGrid_colName, currentFocusedChainIndex);
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, chunkWordID - 1, true);
	}
	*/
	
}
else {
	currentFocusedChainID = "";
}



if (ds_map_exists(global.nodeMap, currentFocusedChunkID)) {
}
else{
	//currentFocusedChunkID = "";
}



mouseLineHide = false;
if (obj_control.mouseoverPanelPane) {
	mouseLineHide = true;
}