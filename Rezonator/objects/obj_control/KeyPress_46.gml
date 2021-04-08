///@description Remove Link

if (gridView || instance_exists(obj_dialogueBox)) {
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
	if (ds_map_exists(global.nodeMap,obj_chain.currentFocusedChainID)) {
		scr_deleteChain(obj_chain.currentFocusedChainID);
	}
}
// If a normal delete, delete the singular focused link
else {

	
	with(obj_panelPane){
		if(functionChainList_currentTab == functionChainList_tabShow && functionChainContents_showID != ""){
			scr_deleteShow(obj_control.selectedChainID);
		}
	
	}
	
	scr_deleteFromChain(true);
	
	if (obj_chain.currentFocusedChunkID != "") {
		scr_deleteChunk(obj_chain.currentFocusedChunkID);
	}
	
}
