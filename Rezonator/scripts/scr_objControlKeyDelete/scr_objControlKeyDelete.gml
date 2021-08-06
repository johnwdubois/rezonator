// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_objControlKeyDelete(){

	// putting this stuff in its own script so that it's the same for Windows & Mac
	

	if (gridView || instance_exists(obj_dialogueBox)) {
		exit;	
	}

	show_debug_message("scr_objControlKeyDelete");


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
		if(deleteEntryPressed == false){
			scr_deleteTreeLink();
		}
	
		scr_deleteFromChain(true);
	
		if (obj_chain.currentFocusedChunkID != "") {
			scr_deleteChunk(obj_chain.currentFocusedChunkID);
		}
	
	}



}