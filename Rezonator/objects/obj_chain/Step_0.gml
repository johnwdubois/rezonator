/*
	Purpose: Consistently update attributes of chain objects
*/

scr_setFocusedChainWordID();


ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, 0, obj_control.wordDrawGrid_colFocused, ds_grid_height(obj_control.wordDrawGrid), false);
/*
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
					var currentWordID = ds_map_find_value(currentEntrySubMap, "token");
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
}
else {
	currentFocusedChainID = "";
}
*/


mouseLineHide = false;
if (obj_control.mouseoverPanelPane) {
	mouseLineHide = true;
}