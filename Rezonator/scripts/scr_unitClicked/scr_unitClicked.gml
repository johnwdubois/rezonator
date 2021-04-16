// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_unitClicked(unitID, unitSubMap){

	// set inChainsList to be this word's inChainsList ... and if this is a stack, we make a "fakeInChainsList" 
	var inChainsList = unitSubMap[?"inChainsList"];
	
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
	// loop through the chains that this word is already in (if any) to refocus that chain
	show_debug_message("scr_unitClicked() inChainsList: " + scr_getStringOfList(inChainsList));
	if (obj_toolPane.currentTool != obj_toolPane.toolPlaceChains and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChainID = inChainsList[| i];
			var currentChainSubMap = global.nodeMap[? currentChainID];
			var currentChainType = currentChainSubMap[? "type"];
			
			// check whether we should refocus this word's entry or not
			var refocusEntry = (currentChainType == "rezChain" && obj_toolPane.currentTool == obj_toolPane.toolRezBrush)
			or (currentChainType == "trackChain" && obj_toolPane.currentTool == obj_toolPane.toolTrackBrush)
			or (currentChainType == "stackChain" && obj_toolPane.currentTool == obj_toolPane.toolStackBrush)
			or (obj_toolPane.currentMode == obj_toolPane.modeRead);
	
			if (refocusEntry) {
				
				obj_chain.currentFocusedChainID = currentChainID;
				scr_unFocusAllChains();
				scr_refocusChainEntry(unitID);
				exit;
				
			}
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