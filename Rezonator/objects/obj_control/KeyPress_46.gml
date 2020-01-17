///@description Remove Link

if(gridView) {
	exit;	
}

// Check for CTRL + DEL
// Gotta check for MacOS
/*var deleteChainCheck = false;
if (os_type == os_macosx) {
	deleteChainCheck = keyboard_check(vk_)	
}*/
if (keyboard_check(vk_control)) {
	// Delete the entire chain if one is focused
	var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
	if(currentChainRow > -1) {
		scr_deleteEntireChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
	}
}
// If a normal delete, delete the singular focused link
else {
	if(obj_chain.currentFocusedChainID < 0 and hoverChunkID != -1) {
		//show_message(hoverChunkIDRow);
		//show_message(hoverChunkID);
		deleteChunkWord = true;
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, hoverChunkIDRow, obj_chain.chainStateFocus);
	}
	scr_deleteFromChain();
}
