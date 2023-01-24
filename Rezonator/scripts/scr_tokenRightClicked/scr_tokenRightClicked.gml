function scr_tokenRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox)) {
		
		var tokenSubMap = global.nodeMap[?obj_control.rightClickID];
		if(!scr_isNumericAndExists(tokenSubMap, ds_type_map)){exit;}
		//deselect tree pane chain entities
		obj_panelPane.functionTree_treeLinkSelected = "";
		obj_chain.currentFocusedEntryID = "";
		
		var tokenInChainsList = tokenSubMap[?"inChainsList"];
		var unitID = tokenSubMap[?"unit"];
		var unitSubMap = global.nodeMap[? unitID];
		var entryList = unitSubMap[?"entryList"];
		var firstEntry = entryList[| 0];
		var firstEntrySubMap = global.nodeMap[? firstEntry];
		var lastEntry = entryList[| ds_list_size(entryList) - 1];
		var lastEntrySubMap = global.nodeMap[? lastEntry];
		
		obj_control.rightClicked = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();
			
		// check if this is the first/last token in its unit
		var isFirstToken = (firstEntrySubMap[? "token"] == obj_control.rightClickID);
		var isLastToken = (lastEntrySubMap[? "token"] == obj_control.rightClickID);

		
		ds_list_add(dropDownOptionList, "option_sync-unit-tab");
		
		// Options for a word in a Chain
		var tokenInChainsListSize = ds_list_size(tokenInChainsList);
		for(var i = 0; i < ds_list_size(tokenInChainsList); i++){
			var chainID = tokenInChainsList[| i];
			var chainSubMap = global.nodeMap[? chainID];
			if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
				obj_control.inChain = true;
				var chainType = chainSubMap[? "type"];
				if (chainType == "trail") ds_list_add(dropDownOptionList, "option_remove-from-trail", "option_rename-trail");
				else if (chainType == "resonance") ds_list_add(dropDownOptionList, "option_remove-from-resonance", "option_rename-resonance");
				
				// check whether we should refocus this word's entry or not
				obj_chain.currentFocusedChainID = chainID;
				scr_refocusChainEntry(obj_control.rightClickID);
			}
		}
		
		// add the rest of the dropdown options
		ds_list_add(dropDownOptionList, "word_tip", "option_zero"); //"help_label_new_token", "Add endnote", "option_delete-token", "option_split-token"); // localize
		if (!isLastToken) ds_list_add(dropDownOptionList, "option_extend-chunk-next");
		if (!isFirstToken) ds_list_add(dropDownOptionList, "option_extend-chunk-previous");
		ds_list_add(dropDownOptionList, "tab_name_tag", "menu_edit");
		
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeRightClickWord);
		}
	}
}