obj_control.prevCenterDisplayRow = obj_control.scrollPlusYDest;
// Instantiate the screen for users to select which stacks go in the stackShow
ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), true);
if (!instance_exists(obj_dialogueBox)) {
	instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
}

// Let the dialogue box know what to draw
obj_dialogueBox.stackShowWindowActive = true;

// Which game are we playing?
if(global.wheresElmo) {
	obj_toolPane.tracksOnlyStackShow = true;
}
else if (global.rezzles) {
	//obj_toolPane.rezOnlyStackShow = true;
}
		
