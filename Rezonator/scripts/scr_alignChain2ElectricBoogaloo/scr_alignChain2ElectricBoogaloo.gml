// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_alignChain2ElectricBoogaloo(chainID){
	
	if (scr_appearancesInList(obj_control.chainStretchCheckList, chainID) > 3) {
		var newestEntrySubMap = global.nodeMap[? obj_control.newestEntry];
		if (!scr_isNumericAndExists(newestEntrySubMap, ds_type_map)) exit;
		newestEntrySubMap[? "stretch"] = true;
		exit;
	}
	ds_list_add(obj_control.chainStretchCheckList, chainID);
	show_debug_message("scr_alignChain2() ... chainID: " + string(chainID));
	
	// get chain map
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) exit;
	var chainType = chainSubMap[? "type"];
	if (chainType != "rezChain") exit;
	
	
	var unitList = ds_list_create();
	
	
	// first, find the word with furthest display col in chain
	var furthestDisplayCol = -1;
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
		var currentUnitID = currentTokenSubMap[? "unit"];
		
		// check if we've seen this unit before
		if (ds_list_find_index(unitList, currentUnitID) == -1) {
			ds_list_add(unitList, currentUnitID);
			
			var currentDisplayCol = currentTokenSubMap[? "displayCol"];
			if (!is_numeric(currentDisplayCol)) continue;
			if (currentDisplayCol > furthestDisplayCol) furthestDisplayCol = currentDisplayCol;
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
		var currentUnitID = currentTokenSubMap[? "unit"];
		
		if (ds_list_find_index(unitList, currentUnitID) == -1) {
			ds_list_add(unitList, currentUnitID);
			currentTokenSubMap[? "displayCol"] = furthestDisplayCol;
		}
	}
	
	
	ds_list_destroy(unitList);

}