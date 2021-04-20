// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setMouseLineWordID(){
	
	// set which word the mouse line (pickwhip) should be coming out of
	// we do this by checking the focused chain's focused entry
	mouseLineWordID = -1;
	ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
	if (ds_map_exists(global.nodeMap, currentFocusedChainID)) {
		var chainSubMap = global.nodeMap[? currentFocusedChainID];
		if (ds_exists(chainSubMap, ds_type_map)) {
			var chainType = chainSubMap[? "type"];
			if (chainType == "rezChain" || chainType == "trackChain") {
				var focusedEntry = chainSubMap[? "focused"];
				var focusedEntrySubMap = global.nodeMap[? focusedEntry];
				if (scr_isNumericAndExists(focusedEntrySubMap, ds_type_map)) {
					var focusedEntryWordID = focusedEntrySubMap[? "token"];
					var focusedEntryWordIDIsChunk = scr_isChunk(focusedEntryWordID);
					mouseLineWordID = focusedEntryWordIDIsChunk ? scr_getFirstWordOfChunk(focusedEntryWordID) : focusedEntryWordID;
					if (!focusedEntryWordIDIsChunk) {
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, focusedEntryWordID - 1, true);
					}
				}
			}
		}
	}

}