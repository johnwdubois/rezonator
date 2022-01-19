


function scr_alignChain2ElectricBoogaloo(chainID){
	
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) exit;
	var chainType = chainSubMap[? "type"];
	if (chainType != "resonance") exit;
	
	if (obj_control.chainStretchCheck) {
		if (scr_appearancesInList(obj_control.chainStretchCheckList, chainID) > 10) {
			var newestEntrySubMap = global.nodeMap[? obj_control.newestEntry];
			if (!scr_isNumericAndExists(newestEntrySubMap, ds_type_map)) exit;
			newestEntrySubMap[? "stretch"] = true;
			show_debug_message("Race to infinity brute force check: chain " + string(chainID) + " appears in chainStretchCheckList over 15 times");
			exit;
		}
	}	
	ds_list_add(obj_control.chainStretchCheckList, chainID);
	show_debug_message("scr_alignChain2() ... chainID: " + string(chainID));	
	

	
	
	var unitList = ds_list_create();
	
	
	// first, find the word with furthest display col in chain
	var furthestDisplayCol = (scr_checkNativeJustification()) ? -1 : 9999999;
	var currentChunkFirstWord = -1;
	var setIDList = chainSubMap[? "vizSetIDList"];
	var setIDListSize = ds_list_size(setIDList);
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
		var currentStretch = currentEntrySubMap[? "stretch"];
		if (currentStretch) continue;

		var currentTokenID = currentEntrySubMap[? "token"];
		if(scr_isChunk(currentTokenID)){currentTokenID = scr_getFirstWordOfChunk(currentTokenID);}
		var currentTokenSubMap = global.nodeMap[? currentTokenID];
		if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
		var currentUnitID = currentTokenSubMap[? "unit"];
		
		// check if we've seen this unit before
		if (ds_list_find_index(unitList, currentUnitID) == -1) {
			ds_list_add(unitList, currentUnitID);
			
			var currentDisplayCol = currentTokenSubMap[? "displayCol"];
			if (!is_numeric(currentDisplayCol)) continue;
			if (scr_checkNativeJustification()) {
				if (currentDisplayCol > furthestDisplayCol) furthestDisplayCol = currentDisplayCol;
			}
			else {
				if (currentDisplayCol < furthestDisplayCol) furthestDisplayCol = currentDisplayCol;
			}
		}
	}
	
	show_debug_message("alignChain ... furthestDisplayCol: " + string(furthestDisplayCol));

	
	
	ds_list_clear(unitList);
	
	
	
	// set all words to have display col as furthest word
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
		var currentStretch = currentEntrySubMap[? "stretch"];
		if (currentStretch) continue;
		
		var currentTokenID = currentEntrySubMap[? "token"];
		if(scr_isChunk(currentTokenID)){currentTokenID = scr_getFirstWordOfChunk(currentTokenID);}
		var currentTokenSubMap = global.nodeMap[? currentTokenID];
		if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
		var currentUnitID = currentTokenSubMap[? "unit"];
		
		if (ds_list_find_index(unitList, currentUnitID) == -1) {
			ds_list_add(unitList, currentUnitID);
			currentTokenSubMap[? "displayCol"] = furthestDisplayCol;
			//show_debug_message("setting token " + string(currentTokenID) + " to displayCol " + string(furthestDisplayCol));
		}
	}
	
	
	ds_list_destroy(unitList);

}