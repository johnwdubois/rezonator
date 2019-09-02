/// @description StackShow on Start

if(obj_control.currentStackShowListPosition == -1) {
	//Create the list
	//set currentStackShowListPosition to 0
	/*currentStackShowListPosition = 0;
	for(var stackShowListLoop = 0; stackShowListLoop < ds_grid_height(obj_chain.stackChainGrid); stackShowListLoop++) {
		var currentStackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, stackShowListLoop);
		ds_list_add(stackShowList, currentStackID);	
	}
	
	// Clear the Filter of all chains
	ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.rezChainGrid), false);
	ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.trackChainGrid), false);
	ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);*/
	
	obj_control.prevCenterDisplayRow = obj_control.scrollPlusYDest;
	// Instantiate the screen for users to select which stacks go in the stackShow

	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
		obj_dialogueBox.stackShowWindowActive = true;
}