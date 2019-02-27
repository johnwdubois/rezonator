// Create the quickStack

// Check for things caught in mouse drag rectangle
if(ds_list_size(inRectUnitIDList) > 1 and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)) {
	// Loop through words found in rectangle at time of mouse release
	for(var quickStackLoop = 0; quickStackLoop < ds_list_size(inRectUnitIDList); quickStackLoop++) {
		var currentWordID = ds_list_find_value(inRectWordIDList,quickStackLoop);
		var currentUnitID = ds_list_find_value(inRectUnitIDList,quickStackLoop);
		with(obj_chain){
			scr_wordClicked(currentWordID, currentUnitID);
		}
	}
}
// Clear lists for next quickStack
if(ds_list_size(inRectUnitIDList) != 0) {
	ds_list_clear(inRectUnitIDList);
	ds_list_clear(inRectWordIDList);
}

// Reset mouse drag rectangle
mouseHoldRectX1 = 0; 
mouseHoldRectX2 = 0; 
mouseHoldRectY1 = 0; 
mouseHoldRectX2 = 0; 
mouseRectMade = false;
quickStackAbleToInitiate = true;