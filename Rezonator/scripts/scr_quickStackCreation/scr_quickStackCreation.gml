// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_quickStackCreation(){
	
	show_debug_message("scr_quickStackCreation ... inRectUnitIDList: " + scr_getStringOfList(inRectUnitIDList));

	var inRectUnitIDListSize = ds_list_size(inRectUnitIDList);

	// Check for things caught in mouse drag rectangle
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
	if (inRectUnitIDListSize > 0 && quickLinkAllowed) {
	
		// if there is a focused chain that's not a stack, deselect it
		var focusedChainIDSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
		if (scr_isNumericAndExists(focusedChainIDSubMap, ds_type_map)) {
			var focusedChainType = focusedChainIDSubMap[? "type"];
			if (focusedChainType != "stackChain") {
				scr_chainDeselect();
			}
		}
		
		// click on every unit in inRectUnitIDList
		for (var i = 0; i < inRectUnitIDListSize; i++) {
			var currentUnit = inRectUnitIDList[| i];
			scr_unitClicked(currentUnit);
		}
		
		global.delayInput = 5;
		
		scr_chainDeselect();
	}


	// Reset mouse drag rectangle
	mouseRectMade = false;
	mouseRectReleased = false;
	quickStackAbleToInitiate = true;
	quickStackAbleToSwitch = true;
	mouseRectBeginBetweenWords = -1;
}