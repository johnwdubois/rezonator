if (calloutBubbleGridCurrentRow < 0 or calloutBubbleGridCurrentRow >= ds_grid_height(calloutBubbleGrid)) {
	exit;
}

if (not instance_exists(obj_calloutBubble)) {
	var currentBubbleString = ds_grid_get(calloutBubbleGrid, calloutBubbleGrid_colString, calloutBubbleGridCurrentRow);
	var currentBubbleWordID = ds_grid_get(calloutBubbleGrid, calloutBubbleGrid_colWordID, calloutBubbleGridCurrentRow);
	if(currentBubbleWordID > -1) {
		var calloutBubbleInst = instance_create_layer(-500, -500, "Instances", obj_calloutBubble);
		calloutBubbleInst.currentBubbleDir = bubbleDirLeft;
		calloutBubbleInst.destroyMethod = 0;
	
		calloutBubbleInst.followWordID = currentBubbleWordID;
		calloutBubbleInst.bubbleString = currentBubbleString;
	
		calloutBubbleGridCurrentRow++;
	}
	
}