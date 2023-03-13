function scr_changeActiveStackType(newStackType){
	
	show_debug_message("scr_changeActiveStackType, newStackType: " + string(newStackType));
	
	// make sure we have a non-empty string
	if (!is_string(newStackType) || newStackType == "") {
		exit;
	}
	
	// check if making new stackType
	if (newStackType == "New stackType") {
		
		// create dialog box to ask for new stackType name
		if (!instance_exists(obj_dialogueBox)) {
			var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			with (inst) inputWindowActive = true;
			with (obj_control) createNewStackType = true;
		}
	}
	else {
		
		// first, let's make sure newStackType is in the stackTypeList
		scr_addToListOnce(obj_control.stackTypeList, newStackType);
		
		// now, we need to clear any references to chains that are no longer of the active stackType
		var stackList = global.nodeMap[? "stackList"];
		var stackListSize = ds_list_size(stackList);
		for (var i = 0; i < stackListSize; i++) {
			
			// get data for current stack
			var currentStack = stackList[| i];
			var currentStackSubMap = global.nodeMap[? currentStack];
			var currentStackType = currentStackSubMap[? "stackType"];
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
				if (currentStackType == newStackType) {
					scr_addToListOnce(currentStackEntryUnitInChainsList, currentStack);
				}
				else {
					scr_deleteFromList(currentStackEntryUnitInChainsList, currentStack);
				}
			}
		}
		
		// set this new stackType to be the active stackType
		with (obj_control) activeStackType = newStackType;
	}

}