function scr_swapAdjacentUnit(swapUp) {
	
	// get lists from docNode
	var docSubMap = global.nodeMap[? global.discourseNode];
	var unitList = docSubMap[? "unitList"];
	var unitListSize = ds_list_size(unitList);
	var displayUnitList = docSubMap[? "displayUnitList"];
	var tokenList = docSubMap[? "tokenList"];
	
	// get ID and index of the two units to swap
	var unitA = obj_control.rightClickID;
	var unitAIndex = ds_list_find_index(unitList, unitA);
	if (unitAIndex < 0) {
		show_debug_message("scr_swapAdjacentUnit, invalid unitAIndex");
		exit;
	}
	var unitBIndex = swapUp ? unitAIndex - 1 : unitAIndex + 1;
	if (unitBIndex < 0 || unitBIndex >= unitListSize) {
		show_debug_message("scr_swapAdjacentUnit, invalid unitBIndex");
		exit;
	}
	var unitB = unitList[| unitBIndex];
	
	// change unitSeq values
	var unitASubMap = global.nodeMap[? unitA];
	var unitASeq = unitASubMap[? "unitSeq"];
	var unitBSubMap = global.nodeMap[? unitB];
	var unitBSeq = unitBSubMap[? "unitSeq"];
	unitASubMap[? "unitSeq"] = unitBSeq;
	unitBSubMap[? "unitSeq"] = unitASeq;
	
	// swap indexes in unitList
	scr_listSwap(unitList, unitAIndex, unitBIndex);
	if (displayUnitList != unitList) {
		ds_list_copy(displayUnitList, unitList);
	}

	
	// repopulate tokenList
	ds_list_clear(tokenList);
	unitListSize = ds_list_size(unitList);
	for (var i = 0; i < unitListSize; i++) {
		var currentUnit = unitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		
		if (scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {
			var currentEntryList = currentUnitSubMap[? "entryList"];
			var currentEntryListSize = ds_list_size(currentEntryList);
		
			for (var j = 0; j < currentEntryListSize; j++) {
				var currentEntry = currentEntryList[| j];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				var currentToken = currentEntrySubMap[? "token"];
				var currentTokenSubMap = global.nodeMap[? currentToken];
				
				// update docTokenSeq for every token
				currentTokenSubMap[? "docTokenSeq"] = ds_list_size(tokenList) + 1;
				ds_list_add(tokenList, currentToken);
			}
		}
	}
	
}