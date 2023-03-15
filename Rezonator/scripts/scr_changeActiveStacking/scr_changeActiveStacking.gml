function scr_changeActiveStacking(stacking){
	
	show_debug_message("scr_changeActiveStacking, stacking: " + string(stacking));
	
	// make sure we have a non-empty string
	if (!is_string(stacking) || stacking == "") {
		exit;
	}
	
	// check if making new stacking
	if (stacking == "New stacking") {
		
		// create dialog box to ask for new stacking name
		if (!instance_exists(obj_dialogueBox)) {
			var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			with (inst) inputWindowActive = true;
			with (obj_control) createNewStacking = true;
		}
	}
	else {
		
		// first, let's make sure stacking is in the stackTypeList
		scr_addToListOnce(obj_control.stackTypeList, stacking);
		
		// now, we need to clear any references to chains that are no longer of the active stacking
		var stackList = global.nodeMap[? "stackList"];
		var stackListSize = ds_list_size(stackList);
		for (var i = 0; i < stackListSize; i++) {
			
			// get data for current stack
			var currentStack = stackList[| i];
			var currentStackSubMap = global.nodeMap[? currentStack];
			var currentStacking = currentStackSubMap[? "stacking"];
			var currentStackSetList = currentStackSubMap[? "setIDList"];
			
			// loop through entries in this stack to edit their units' inChainsLists
			var currentStackSetListSize = ds_list_size(currentStackSetList);
			for (var j = 0; j < currentStackSetListSize; j++) {
				var currentStackEntry = currentStackSetList[| j];
				var currentStackEntrySubMap = global.nodeMap[? currentStackEntry];
				var currentStackEntryUnit = currentStackEntrySubMap[? "unit"];
				var currentStackEntryUnitSubMap = global.nodeMap[? currentStackEntryUnit];
				var currentStackEntryUnitInChainsList = currentStackEntryUnitSubMap[? "inChainsList"];
				
				// add or delete the stack from the unit's inChainsList, depending on activeStack
				if (currentStacking == stacking) {
					scr_addToListOnce(currentStackEntryUnitInChainsList, currentStack);
				}
				else {
					scr_deleteFromList(currentStackEntryUnitInChainsList, currentStack);
				}
			}
		}
		
		// set this new stacking to be the active stacking
		with (obj_control) activeStacking = stacking;
	}

}