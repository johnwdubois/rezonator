obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
// Instantiate the screen for users to select which stacks go in the stackShow
scr_setValueForAllChains("stackChain", "filter", true);
if (!instance_exists(obj_stackShow)) {
	instance_create_layer(x, y, "InstancesAudio", obj_stackShow);
}

// Let the dialogue box know what to draw
obj_control.stackShowWindowActive = true;

// Which game are we playing?
if(global.wheresElmo) {
	obj_toolPane.tracksOnlyStackShow = true;
}
else if (global.rezzles) {
	//obj_toolPane.rezOnlyStackShow = true;
}
		
