// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_unitClicked(unitID){
	
	if (global.delayInput > 0) exit;
	
	// get submap for this unit and make sure it exists
	var unitSubMap = global.nodeMap[? unitID];
	if (!scr_isNumericAndExists(unitSubMap, ds_type_map)) exit;
	show_debug_message("scr_unitClicked ... unitID: " + string(unitID));
	
	// get inChainsList for this unit
	var inChainsList = unitSubMap[? "inChainsList"];
	var inChainsListSize = ds_list_size(inChainsList);
	
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
	
	// refocus any chain that this unit is in
	for (var i = 0; i < inChainsListSize; i++) {
		var currentChainID = inChainsList[| i];
		var currentChainSubMap = global.nodeMap[? currentChainID];

		if (!scr_isNumericAndExists(currentChainSubMap, ds_type_map)) {continue;}
		var currentChainType = currentChainSubMap[? "type"];
			
		// check whether we should refocus this word's entry or not
		var refocusEntry = (currentChainType == "stackChain");
		if (refocusEntry) {
			obj_chain.currentFocusedChainID = currentChainID;
			scr_refocusChainEntry(unitID);
			exit;
		}
	}


	// if there is not a focused chain, we create a new chain
	if (!ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		scr_newChain(unitID);
	}

	// add new link and refresh chain grid
	scr_newLink(unitID);

	obj_control.allSaved = false;
	
	scr_refocusChainEntry(unitID);
	
}