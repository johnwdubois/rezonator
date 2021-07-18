// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_handleVoid(setList) {
	
	if (!scr_isNumericAndExists(setList, ds_type_list)) exit;
	
	var setListSize = ds_list_size(setList);
	var smallVoidExists = false;
	var unitList = ds_list_create();
	var sideLinkList = ds_list_create();
						
	// check to see if the chain has any voids < 1
	for (var j = 0; j < setListSize; j++) {
		var currentEntry = setList[| j];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
		//var currentStretch = currentEntrySubMap[? "stretch"];
		//if (currentStretch) continue;
		var currentTokenID = currentEntrySubMap[? "token"];
		if (scr_isChunk(currentTokenID)) currentTokenID = scr_getFirstWordOfChunk(currentTokenID);
		var currentTokenSubMap = global.nodeMap[? currentTokenID];
		if(!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)){
			continue;	
		}
		var currentUnit = currentTokenSubMap[? "unit"];
		if (ds_list_find_index(unitList, currentUnit) == -1) {
			ds_list_add(unitList, currentUnit);
			var currentVoid = currentTokenSubMap[? "void"];
			if (currentVoid <= 1) smallVoidExists = true;
		}
		else {
			ds_list_add(sideLinkList, currentTokenID);
		}
	}
	
						
	if (!smallVoidExists) {
		// if no tokens in the chain have a small void, we can bring every token back
		for (var j = 0; j < setListSize; j++) {
			var currentEntry = setList[| j];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
			
			var currentTokenID = currentEntrySubMap[? "token"];
			if (scr_isChunk(currentTokenID)) currentTokenID = scr_getFirstWordOfChunk(currentTokenID);
			var currentTokenSubMap = global.nodeMap[? currentTokenID];
			
			var currentDisplayCol = currentTokenSubMap[? "displayCol"];
			currentTokenSubMap[? "displayCol"] = (scr_checkNativeJustification()) ? currentDisplayCol - 1 : currentDisplayCol + 1;
		}
	}
	else {
		// if there are any side links still hanging out in space, bring them back
		var sideLinkListSize = ds_list_size(sideLinkList);
		for (var j = 0; j < sideLinkListSize; j++) {
			var currentTokenID = sideLinkList[| j];
			var currentTokenSubMap = global.nodeMap[? currentTokenID];
			var currentVoid = currentTokenSubMap[? "void"];
			if (currentVoid > 1) {
				var currentDisplayCol = currentTokenSubMap[? "displayCol"];
				currentTokenSubMap[? "displayCol"] = (scr_checkNativeJustification()) ? currentDisplayCol - 1 : currentDisplayCol + 1;
			}							
		}
	}
						
	ds_list_destroy(unitList);
	ds_list_destroy(sideLinkList);

}