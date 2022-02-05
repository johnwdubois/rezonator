function scr_mergeUnit(){
	
	if (ds_list_size(obj_control.mergeUnitList) < 2) {
		show_debug_message("scr_mergeUnit, not enough units");
		exit;
	}
	
	// get both units to merge, make sure they're valid
	var unit1ID = obj_control.mergeUnitList[| 1];
	var unit1SubMap = global.nodeMap[? unit1ID];
	var unit2ID = obj_control.mergeUnitList[| 0];
	var unit2SubMap = global.nodeMap[? unit2ID];
	if (!scr_isNumericAndExists(unit1SubMap, ds_type_map) || !scr_isNumericAndExists(unit2SubMap, ds_type_map)) {
		show_debug_message("scr_mergeUnit, units don't exist");
		exit;		
	}
	
	// get some useful vars
	var docSubMap = global.nodeMap[? global.discourseNode];
	var unitList = docSubMap[? "unitList"];
	var tokenList = docSubMap[? "tokenList"];
	var displayUnitList = docSubMap[? "displayUnitList"];
	var unit1EntryList = unit1SubMap[? "entryList"];
	var unit2EntryList = unit2SubMap[? "entryList"];
	var unit1Seq = unit1SubMap[? "unitSeq"];
	var unit2Seq = unit2SubMap[? "unitSeq"];
	show_debug_message("scr_mergeUnit, unit1ID: " + string(unit1ID) + ", unit2ID: " + string(unit2ID));
	show_debug_message("scr_mergeUnit, merging unit " + string(unit1Seq) + " and unit " + string(unit2Seq));
	
	// add every unit2 entry into unit1's entry list
	// also make every entry & token that was in unit2 now point to unit1
	var unit2EntryListSize = ds_list_size(unit2EntryList);
	var i = (unit1Seq < unit2Seq) ? 0 : unit2EntryListSize - 1;
	repeat(unit2EntryListSize) {
		var currentUnit2Entry = unit2EntryList[| i];
		var currentUnit2EntrySubMap = global.nodeMap[? currentUnit2Entry];
		var currentUnit2Token = currentUnit2EntrySubMap[? "token"];
		var currentUnit2TokenSubMap = global.nodeMap[? currentUnit2Token];
		
		if (unit1Seq < unit2Seq) {
			// if unit1 comes before unit2, we will add unit2's entries to the back of unit1's entry list
			scr_addToListOnce(unit1EntryList, currentUnit2Entry);
		}
		else {
			// if unit1 comes after unit2, we will add unit2's entries to the front of unit1's entry list
			scr_addToListOnce(unit1EntryList, currentUnit2Entry, true);
		}
		
		currentUnit2TokenSubMap[? "unit"] = unit1ID;
		currentUnit2EntrySubMap[? "unit"] = unit1ID;
		
		i += (unit1Seq < unit2Seq) ? 1 : -1;
	}

	
	// now let's destroy the unit2 node and all of its contents
	var unit2TagMap = unit2SubMap[? "tagMap"];
	var unit2InChainsList = unit2SubMap[? "inChainsList"];
	ds_map_destroy(unit2TagMap);	
	ds_list_destroy(unit2InChainsList);	
	ds_list_destroy(unit2EntryList);
	ds_map_destroy(unit2SubMap);
	scr_deleteFromNodeMap(unit2ID);
	scr_deleteFromList(unitList, unit2ID);
	scr_deleteFromList(displayUnitList, unit2ID);
	scr_deleteFromList(obj_control.mergeUnitList, unit2ID);
	
	// now that unit2 is gone, let's reevaluate the unitSeq, and also reevaluate docTokenSeq
	ds_list_clear(tokenList);
	var unitListSize = ds_list_size(unitList);
	for (var i = 0; i < unitListSize; i++) {
		var currentUnit = unitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		currentUnitSubMap[? "unitSeq"] = i + 1;
		
		var currentUnitEntryList = currentUnitSubMap[? "entryList"];
		var currentUnitEntryListSize = ds_list_size(currentUnitEntryList);
		for (var j = 0; j < currentUnitEntryListSize; j++) {
			var currentEntry = currentUnitEntryList[| j];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			var currentToken = currentEntrySubMap[? "token"];
			var currentTokenSubMap = global.nodeMap[? currentToken];
			
			scr_addToListOnce(tokenList, currentToken);
			currentTokenSubMap[? "docTokenSeq"] = ds_list_size(tokenList);
		}
	}
	
	// refresh/reevaluate alignment & order values for each token in the newly merged unit
	scr_refreshPrevTokenUnit(unit1ID);
	var unit1EntryListSize = ds_list_size(unit1EntryList);
	for (var i = 0; i < unit1EntryListSize; i++) {
		var currentEntry = unit1EntryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		currentTokenSubMap[? "tokenOrder"] = i + 1;
	}
	
	
}