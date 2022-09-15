function scr_mergeUnit(){
	
	if (ds_list_size(obj_control.mergeUnitList) < 2) {
		show_debug_message("scr_mergeUnit, not enough units");
		exit;
	}
	
	// get both units to merge, make sure they're valid
	var unit1ID = obj_control.mergeUnitList[| 0];
	var unit1SubMap = global.nodeMap[? unit1ID];
	var unit2ID = obj_control.mergeUnitList[| 1];
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
	show_debug_message("scr_mergeUnit, unit1Seq: " + string(unit1Seq) + ", unit2Seq: " + string(unit2Seq));
	
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

	
	var unit2TagMap = unit2SubMap[? "tagMap"];
	var unit2InChainsList = unit2SubMap[? "inChainsList"];
	var unit1InChainsList = unit1SubMap[? "inChainsList"];
	
	//update all chains related to unit2
	var unit2InChainsListSize = ds_list_size(unit2InChainsList);
	var unit1InChainsListSize = ds_list_size(unit1InChainsList);
	show_debug_message("unit1InChainsListSize: "+string(unit1InChainsListSize) + ",    unit2InChainsListSize: "+string(unit2InChainsListSize))
	
	
	//first unit has a stack
	if(unit2InChainsListSize >= 1){
		//and second unit doesn't has a stack
		if(unit1InChainsListSize == 0){
			//we adjust the broken enttry in the first unit's chain to poin to new unit;
			for (var i = 0; i < unit2InChainsListSize; ++i) {
			    var currentStack = unit2InChainsList[|i];
				var stackSubMap = global.nodeMap[?currentStack];
				if(scr_isNumericAndExists(stackSubMap,ds_type_map)){
					var entryList = stackSubMap[?"setIDList"];
					var entryListSize = ds_list_size(entryList);
					for (var j = 0; j < entryListSize; ++j) {
					     var currentCard = entryList[|j];
						 var cardMap = global.nodeMap[?currentCard];
						 
						 var cardUnit = cardMap[?"unit"];
						 if(cardUnit == unit2ID){
							cardMap[?"unit"] = unit1ID;
							scr_addToListOnce(unit1InChainsList,currentStack);
						 }
					}
				}
			}
		}
	}
	

	// we remove unit2 from all of the unitLists, so that we can reevaulate unitSeq
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
	
	
	// deal with the stacks that unit2 was in
	show_debug_message("dealing with unit2InChainsList: " + scr_getStringOfList(unit2InChainsList) + ", unit2InChainsListSize: " + string(unit2InChainsListSize));
	while (ds_list_size(unit2InChainsList) >= 1) {
		var currentStack = unit2InChainsList[| 0];
		var currentStackSubMap = global.nodeMap[? currentStack];
		var currentStackEntryList = currentStackSubMap[? "setIDList"];
		var currentStackEntryListSize = ds_list_size(currentStackEntryList);
		
		// find the stack entry that points to unit2
		var deleteFromCurrentStack = false;
		for (var j = 0; j < currentStackEntryListSize; j++) {
			var currentStackEntry = currentStackEntryList[| j];
			var currentStackEntrySubMap = global.nodeMap[? currentStackEntry];
			var currentStackEntryUnit = currentStackEntrySubMap[? "unit"];
			if (currentStackEntryUnit == unit2ID) {
				deleteFromCurrentStack = true;
				currentStackSubMap[? "focused"] = currentStackEntry;
			}
		}
		
		if (deleteFromCurrentStack) {
			obj_chain.currentFocusedChainID = currentStack;
			scr_deleteFromChain(true);
		}
		
		scr_deleteFromList(unit2InChainsList, currentStack);
	}
	
	var unit1InClique = unit1SubMap[? "inClique"];
	var unit2InClique = unit2SubMap[? "inClique"];
	
	// now let's destroy the unit2 node and all of its contents
	ds_map_destroy(unit2TagMap);
	ds_list_destroy(unit2EntryList);
	ds_map_destroy(unit2SubMap);
	scr_deleteFromNodeMap(unit2ID);
	ds_list_destroy(unit2InChainsList);
	
	
	
	// if both units are in cliques...
	show_debug_message("scr_mergeUnit, unit1InClique: " + string(unit1InClique) + ", unit2InClique: " + string(unit2InClique));
	if (is_string(unit1InClique) && unit1InClique != "" && is_string(unit2InClique) && unit2InClique != "") {
		
		scr_refreshClique(unit1InClique);
		if (unit1InClique != unit2InClique) {
			// if they are different cliques, we merge them
			scr_mergeCliques(unit1InClique, unit2InClique);
		}
	}
	
}