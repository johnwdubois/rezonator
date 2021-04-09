/// @description Delete for Mac

///@description Remove Link
//show_message("delete");
if(gridView || instance_exists(obj_dialogueBox)) {
	exit;	
}

// Check for CTRL + DEL
// Gotta check for MacOS
//var deleteChainCheck = false;
/*if (os_type == os_macosx) {
	deleteChainCheck = keyboard_check(vk	
}*/
if (keyboard_check(vk_control)) {
	// Delete the entire chain if one is focused
	if(ds_map_exists(global.nodeMap,obj_chain.currentFocusedChainID)) {
		scr_deleteChain(obj_chain.currentFocusedChainID);
	}
}
// If a normal delete, delete the singular focused link
else {
	scr_deleteFromChain(true);
}
