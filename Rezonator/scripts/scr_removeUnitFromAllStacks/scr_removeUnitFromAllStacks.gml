function scr_removeUnitFromAllStacks(unit){
	
	// get list of all stacks
	var stackList = global.nodeMap[? "stackList"];
	if (!scr_isNumericAndExists(stackList, ds_type_list)) exit;
	
	// go through all stacks and check if any contain entries that point to the unit
	var stackListSize = ds_list_size(stackList);
	for (var i = 0; i < stackListSize; i++) {
		var currentStack = stackList[| i];
		var currentStackSubMap = global.nodeMap[? currentStack];
		var currentStackEntryList = currentStackSubMap[? "setIDList"];
		var currentStackEntryListSize = ds_list_size(currentStackEntryList);
		
		// find the stack entry that points to the unit
		var deleteFromCurrentStack = false;
		for (var j = 0; j < currentStackEntryListSize; j++) {
			var currentStackEntry = currentStackEntryList[| j];
			var currentStackEntrySubMap = global.nodeMap[? currentStackEntry];
			var currentStackEntryUnit = currentStackEntrySubMap[? "unit"];
			
			// if this entry points to the unit, we will focus this entry
			if (currentStackEntryUnit == unit) {
				deleteFromCurrentStack = true;
				currentStackSubMap[? "focused"] = currentStackEntry;
			}
		}
		
		// if we found an entry pointing to the unit, we will delete the entry we focused
		if (deleteFromCurrentStack) {
			with (obj_chain) currentFocusedChainID = currentStack;
			scr_deleteFromChain(true);
		}
	}

}