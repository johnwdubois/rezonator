///@description Remove Link

if(gridView) {
	exit;	
}
obj_control.normalDelete = true
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
	scr_deleteFromChain();
}

obj_control.normalDelete = false;
obj_control.chunkDeleted = false;
obj_control.deleteChunkWord = false;
/*
if(obj_control.deleteChunkWord){
show_message("BUH");
}
else{
show_message("jUH");
}
*/