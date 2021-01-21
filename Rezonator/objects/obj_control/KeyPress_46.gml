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

	if(ds_map_exists(global.nodeMap,obj_chain.currentFocusedChainID)) {
		scr_deleteChain(obj_chain.currentFocusedChainID);
	}
}
// If a normal delete, delete the singular focused link
else {
	if (obj_chain.currentFocusedChainID == "" and hoverChunkID != -1) {
		//show_message(hoverChunkIDRow);
		//show_message(hoverChunkID);
		deleteChunkWord = true;
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, hoverChunkIDRow, obj_chain.chainStateFocus);
	}
	scr_deleteFromChain();
}
