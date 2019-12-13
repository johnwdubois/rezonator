/// @description Insert description here
// You can write your code in this editor


// Check for CTRL + DEL on  mac
if ( os_type == os_macosx ){
	
	if (keyboard_check(vk_control)) {
		// Delete the entire chain if one is focused
		var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
		if(currentChainRow > -1) {
			scr_deleteEntireChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
		}
	}
	// If a normal delete, delete the singular focused link
	else {
		scr_deleteFromChain();
	}

}