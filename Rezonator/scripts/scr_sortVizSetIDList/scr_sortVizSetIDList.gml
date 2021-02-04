// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_sortVizSetIDList(chainID){
	
	// get chain's submap
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	if (!is_numeric(chainSubMap)) {
		show_debug_message("scr_sortVizSetIDList() ... chainSubMap is non-numeric");
		exit;
	}
	if (!ds_exists(chainSubMap, ds_type_map)) {
		show_debug_message("scr_sortVizSetIDList() ... chainSubMap does not exist");
		exit;
	}
	
	var chainType = ds_map_find_value(chainSubMap, "type");
	show_debug_message("scr_sortVizSetIDList() ... sorting chain: " + string(chainID) + ", type: " + string(chainType));
	
	// get set list from chain
	var setIDList = ds_map_find_value(chainSubMap, "setIDList");
	var setIDListSize = ds_list_size(setIDList);
	var vizSetIDList = ds_map_find_value(chainSubMap, "vizSetIDList");
	
	// make a temp grid that we can sort
	var tempGrid_colEntryID = 0;
	var tempGrid_colUnitSeq = 1;
	var tempGrid_colWordOrder = 2;
	var tempGrid = ds_grid_create(3, setIDListSize);
	
	// loop down set list and put them entries in the tempGrid
	for (var i = 0; i < setIDListSize; i++) {
		// get word info from this entry
		var currentEntry = ds_list_find_value(setIDList, i);
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		if (!is_numeric(currentEntrySubMap)) continue;
		if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
		
		var currentWordID = -1;
		var currentUnitSeq = -1;
		var currentWordOrder = -1;
		
		// if this is a rez/track, get each entry's UnitSeq and WordOrder ... if this is a stack, we just get each entry's UnitSeq
		if (chainType == "rezChain" || chainType == "trackChain") {
			currentWordID = ds_map_find_value(currentEntrySubMap, "word");
			currentUnitSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
			currentWordOrder = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
		}
		else if (chainType == "stackChain") {
			currentWordID = -1;
			currentUnitSeq = ds_map_find_value(currentEntrySubMap, "unit");
			currentWordOrder = -1;
		}
		
		// set values in tempGrid
		ds_grid_set(tempGrid, tempGrid_colEntryID, i, currentEntry);
		ds_grid_set(tempGrid, tempGrid_colUnitSeq, i, currentUnitSeq);
		ds_grid_set(tempGrid, tempGrid_colWordOrder, i, currentWordOrder);
	}
	
	
	
	// sort the tempGrid!!!
	scr_gridMultiColSort(tempGrid, tempGrid_colUnitSeq, true, tempGrid_colWordOrder, true);
	
	// refresh vizSetIDList based on the sorted tempGrid
	ds_list_clear(vizSetIDList);
	var prevUnit = -1;
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = ds_grid_get(tempGrid, tempGrid_colEntryID, i);
		ds_list_add(vizSetIDList, currentEntry);
		
		// set gap tag in this entry's tagmap
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		if (is_numeric(currentEntrySubMap)) {
			if (ds_exists(currentEntrySubMap, ds_type_map)) {
				
				// get unit from this entry
				var currentUnit = -1;
				if (chainType == "rezChain" || chainType == "trackChain") {
					var currentWord = ds_map_find_value(currentEntrySubMap, "word");
					currentUnit = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWord - 1);
				}
				else if (chainType == "stackChain") {
					currentUnit = ds_map_find_value(currentEntrySubMap, "unit");
				}
				
				// calculate gapUnits
				var currentGapUnits = "N/A";
				if (prevUnit >= 0) {
					currentGapUnits = currentUnit - prevUnit;
				}

				// set the tags
				var currentTagMap = ds_map_find_value(currentEntrySubMap, "tagMap");
				if (is_numeric(currentTagMap)) {
					if (ds_exists(currentTagMap, ds_type_map)) {
						scr_setMap(currentTagMap, "gapUnits", currentGapUnits);
					}
				}
				
				prevUnit = currentUnit;
			}
		}
	}
	
	// we dont need tempGrid anymore
	ds_grid_destroy(tempGrid);

}