function scr_tokenRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox)) {
		
		var tokenSubMap = global.nodeMap[?obj_control.rightClickID];
		if(!scr_isNumericAndExists(tokenSubMap, ds_type_map)){exit;}
		//deselect tree pane chain entities
		obj_panelPane.functionTree_treeLinkSelected = "";
		obj_chain.currentFocusedEntryID = "";
		
		var tokenInChainsList = tokenSubMap[?"inChainsList"];
		var unitID = tokenSubMap[?"unit"]
		
		var unitSubMap = global.nodeMap[?unitID];
		var entryList = unitSubMap[?"entryList"];
		var firstEntry = entryList[|0];
		var firstEntrySubMap = global.nodeMap[?firstEntry];
		
		obj_control.rightClicked = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();
			
		// check if this is the first word in its line

		var firstWordInLine = (firstEntrySubMap[?"token"] == obj_control.rightClickID);

		var tokenInChainsListSize = ds_list_size(tokenInChainsList);

		// Options for a word in a Chain
		if(tokenInChainsListSize > 0){

			ds_list_add(dropDownOptionList,  "help_label_delete-link", "option_set-chain-name");
			
			
			for(var i = 0; i < ds_list_size(tokenInChainsList); i++){
				var chainID = tokenInChainsList[|i];
				var chainSubMap = global.nodeMap[?chainID];
				if(scr_isNumericAndExists(chainSubMap, ds_type_map)){

					obj_control.inChain = true;
	
				}
			
				// check whether we should refocus this word's entry or not
				obj_chain.currentFocusedChainID = chainID;
				scr_refocusChainEntry(obj_control.rightClickID);
			}
					
		}
		// Options for a chainless word
		else{
	
		}
		
		if (obj_panelPane.functionField_tokenFieldSelected != "" && obj_panelPane.functionField_tokenTagSelected != ""
			&& is_string(obj_panelPane.functionField_tokenFieldSelected) && is_string(obj_panelPane.functionField_tokenTagSelected)) {
				//scr_addToListOnce(dropDownOptionList , "Tag Token");
		}
		
		ds_list_add(dropDownOptionList, "word_tip", "option_zero", "option_delete-token", "tab_name_tag");
		if (!firstWordInLine && obj_control.showDevVars) {
			//ds_list_add(dropDownOptionList, "Split Line");
		}
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeRightClickWord);
		}
	}
}