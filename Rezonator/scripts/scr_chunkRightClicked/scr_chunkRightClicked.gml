function scr_chunkRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox)) {
		
		var chunkSubMap = global.nodeMap[? obj_control.rightClickID];
		if(!scr_isNumericAndExists(chunkSubMap, ds_type_map)){exit;}
		//deselect tree pane chain entities
		obj_panelPane.functionTree_treeLinkSelected = "";
		obj_chain.currentFocusedEntryID = "";
		
		var chunkInChainsList = chunkSubMap[?"inChainsList"];

		obj_control.rightClicked = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();
		
		// Options for a word in a Chain
		if (ds_list_size(chunkInChainsList) > 0) {
					
			ds_list_add(dropDownOptionList, "help_label_delete-link");

			for (var i = 0; i < ds_list_size(chunkInChainsList); i++) {
				var chainID = chunkInChainsList[|i];
				var chainSubMap = global.nodeMap[?chainID];
				var chainType = "";
				if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
					chainType = chainSubMap[?"type"];
					obj_control.inChain = true;
					if (chainType == "trail") ds_list_add(dropDownOptionList, "option_rename-trail");
					else if (chainType == "resonance") ds_list_add(dropDownOptionList, "option_rename-resonance");
				}
			
				// check whether we should refocus this word's entry or not
				var refocusEntry = (chainType == "resonance" && obj_toolPane.currentMode == obj_toolPane.modeRez)
					or (chainType == "trail" && obj_toolPane.currentMode == obj_toolPane.modeTrack)
					or (obj_toolPane.currentMode == obj_toolPane.modeRead);
				
				if (refocusEntry) {
					obj_chain.currentFocusedChainID = chainID;
					scr_refocusChainEntry(obj_control.rightClickID);
				}
			}	
		}

		ds_list_add(dropDownOptionList, "tab_name_tag", "option_delete-chunk", "option_sync-unit-tab", "option_extend-chunk-previous", "option_extend-chunk-next", "option_remove-chunk-start", "option_remove-chunk-end");
		obj_control.inChunk = true;
				
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeRightClickWord);
		}
	}
}