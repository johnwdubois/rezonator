///@description QuickStack Creation
// Create the quickStack

var firstUnitID = 0;
var firstWordID = 0;

// Check for things caught in mouse drag rectangle
if (ds_list_size(inRectUnitIDList) > 0 and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and quickLinkAllowed  and !instance_exists(obj_stackShow)) {
	if((mouseHoldRectY1 - mouseHoldRectY2) < 0) {
		firstUnitID = ds_list_find_value(inRectUnitIDList, 0);
		firstWordID = ds_list_find_value(inRectWordIDList, 0);
	}
	else {
		firstUnitID = ds_list_find_value(inRectUnitIDList, ds_list_size(inRectUnitIDList) - 1);
		firstWordID = ds_list_find_value(inRectWordIDList, ds_list_size(inRectWordIDList) - 1);
	}
	// Loop through words found in rectangle at time of mouse release
	for(var quickStackLoop = 0; quickStackLoop < ds_list_size(inRectUnitIDList); quickStackLoop++) {
		var currentWordID = ds_list_find_value(inRectWordIDList, quickStackLoop);
		var currentUnitID = ds_list_find_value(inRectUnitIDList, quickStackLoop);
		with (obj_chain) {
			scr_wordClicked(firstWordID, firstUnitID);
			scr_wordClicked(currentWordID, currentUnitID);
		}
	}
	// Unfocus all links and chains
	scr_unFocusAllChains();
	ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
}


//show_message(scr_getStringOfList(inRectUnitIDList));
// Clear lists for next quickStack
if (ds_list_size(inRectUnitIDList) > 0) {
	ds_list_clear(inRectUnitIDList);
	ds_list_clear(inRectWordIDList);
}

// Reset mouse drag rectangle
mouseHoldRectX1 = 0; 
mouseHoldRectX2 = 0; 
mouseHoldRectY1 = 0; 
mouseHoldRectY2 = 0; 
mouseRectMade = false;
mouseRectReleased = false;
quickStackAbleToInitiate = true;
quickStackAbleToSwitch = true;
firstUnitID = 0;
firstWordID = 0;
mouseRectBeginBetweenWords = -1;