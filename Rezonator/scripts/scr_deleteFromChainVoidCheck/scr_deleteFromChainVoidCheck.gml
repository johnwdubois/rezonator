// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteFromChainVoidCheck(chainID){

	// get chain submap and make sure it exists
	var chainSubMap = global.nodeMap[? chainID];
	if (!is_numeric(chainSubMap)) exit;
	if (!ds_exists(chainSubMap, ds_type_map)) exit;
	var chainType = chainSubMap[? "type"];
	var chainSetList = chainSubMap[? "setIDList"];
	
	// check chain for voids (if this is a rezChain)
	if (chainType == "rezChain") {
		
		var smallVoidExists = false;
		var chainSetListSize = ds_list_size(chainSetList);
		for (var i = 0; i < chainSetListSize; i++) {
		
			var currentEntry = chainSetList[| i];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!is_numeric(currentEntrySubMap)) continue;
			if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
			var currentWordID = currentEntrySubMap[? "word"];
			
			var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
			var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
			
			if (currentWordSeq > 1) {
				var prevDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 2);
				if (is_numeric(prevDisplayCol)) {
					var currentVoid = currentDisplayCol - prevDisplayCol;
					show_debug_message("currentVoid: " + string(currentVoid));
					if (currentVoid <= 1) {
						smallVoidExists = true;
					}
				}
			}
			else if (currentDisplayCol == 0) {
				smallVoidExists = true;
			}
		}
		
		if (!smallVoidExists) {
			// bring all the words back so that they have a void of 1
			for (var i = 0; i < chainSetListSize; i++) {
				var currentEntry = chainSetList[| i];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				if (!is_numeric(currentEntrySubMap)) continue;
				if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
				
				var currentWordID = currentEntrySubMap[? "word"];
				var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
			
				if (currentWordSeq > 1) {
					var prevDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 2);
					currentDisplayCol = prevDisplayCol + 1;
				}
				else {
					currentDisplayCol = 0;
				}
				
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol);
			}
			
			scr_alignChain2ElectricBoogaloo(chainID);
		}
	}
	
	
}