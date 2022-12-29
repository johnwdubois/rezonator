function scr_objControlKeyDelete(){

	// putting this stuff in its own script so that it's the same for Windows & Mac
	

	if (obj_control.gridView || instance_exists(obj_dialogueBox)|| instance_exists(obj_inputBox) || obj_control.navWindowTaggingID != "") {
		exit;	
	}

	show_debug_message("scr_objControlKeyDelete");


	if (global.ctrlHold) {
		
		// if there is a valid chain focused, prompt a dialogue box to confirm deletion
		if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID) && obj_chain.currentFocusedChainID != "" && is_string(obj_chain.currentFocusedChainID)) {
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_control.selectedChainID = obj_chain.currentFocusedChainID;
				obj_dialogueBox.clearChain = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		}
	}
	// If a normal delete, delete the singular focused link
	else {

	
		scr_deleteFromChain(true);
	
		if (obj_chain.currentFocusedChunkID != "") {
			scr_deleteChunk(obj_chain.currentFocusedChunkID);
		}
		
		with(obj_panelPane){
			if(functionChainList_currentTab == functionChainList_tabShow && functionChainContents_showID != ""){
				scr_deleteShow(obj_control.selectedChainID);
			}	
			if(functionChainList_currentTab == functionChainList_tabTree && obj_panelPane.functionTree_treeLinkSelected != ""){
				scr_deleteTreeLink();
				exit;
			}
			if(functionChainList_currentTab == functionChainList_tabTree && obj_control.deleteEntryPressed == false){
				scr_deleteTreeEntry();
				exit;
			}

		}
	
	}



}