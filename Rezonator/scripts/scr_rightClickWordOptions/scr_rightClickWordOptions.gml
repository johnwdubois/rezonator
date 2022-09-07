function scr_rightClickWordOptions(optionSelected) {
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	
	if (optionSelected == "help_label_split-word") {
		scr_destroyAllDropDownsOtherThanSelf();
		if (obj_control.rightClickID != "") {

				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.replace = true;
				}

				obj_control.fromDropDown = true;
				obj_control.dialogueBoxActive = true;
				obj_control.splitWord = true;

				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						
				}
				obj_dialogueBox.inputWindowActive = true;
		
		}
		instance_destroy();

	}
	else if (optionSelected == "option_new-token") {
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "option_zero-0", "option_zero", "option_pronoun", "option_custom");
						

		if (ds_list_size(dropDownOptionList) > 0) {
			scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (optionIndex * optionSpacing), dropDownOptionList, global.optionListTypeNewWord);
		}
	}
	else if (optionSelected == "help_label_new_token") {
		
		scr_newTokenOptions("option_custom");
		instance_destroy();
	}
	else if (optionSelected == "option_zero") {
		//obj_control.newWordPre1 = true;
		obj_control.currentNewWordPre = 1;
			
				
		scr_newToken(scr_get_translation("option_zero-0"), obj_control.rightClickID);
		obj_control.alarm[11] = 60;

		
		obj_control.rightClicked = false;
		instance_destroy();
	}
	else if (optionSelected == "help_label_delete-link") {
		scr_deleteFromChain(true);
		instance_destroy();
	}
	else if (optionSelected == "option_remove-from-trail" || optionSelected == "option_remove-from-resonance") {
		scr_focusRelevantChainOnToken(obj_control.rightClickID, optionSelected == "option_remove-from-trail" ? "trail" : "resonance");
		scr_deleteFromChain(true);
		instance_destroy();
	}
	else if (optionSelected == "option_set-chain-name") {
		scr_setChainName();
		instance_destroy();
	}
	else if (optionSelected == "option_rename-trail" || optionSelected == "option_rename-resonance") {
		scr_focusRelevantChainOnToken(obj_control.rightClickID, optionSelected == "option_rename-trail" ? "trail" : "resonance");
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			global.inputBoxDefStr = scr_setChainNameGetString();
			obj_dialogueBox.inputWindowActive = true;
			obj_control.setChainName = true;
		}
		instance_destroy();
	}
	else if (optionSelected == "Tag Chain") {
		// set field/tags
		if (obj_control.rightClickID != "") {
			var tokenSubMap = global.nodeMap[? obj_control.rightClickID];
			if(scr_isNumericAndExists(tokenSubMap, ds_type_map)){
					
				var inChainsList = tokenSubMap[? "inChainsList"];
				var inChainsListSize = ds_list_size(inChainsList);
					
					
				for(var i = 0; i < inChainsListSize; i++){
					var currentChainID = inChainsList[| i];
					var chainSubMap = global.nodeMap[? currentChainID];						
					if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
						var chainType = chainSubMap[? "type"];							
						if((chainType == "trail" && obj_toolPane.currentMode == obj_toolPane.modeTrack or obj_toolPane.currentMode == obj_toolPane.modeRead)
						or (chainType == "resonance" && obj_toolPane.currentMode == obj_toolPane.modeRez or obj_toolPane.currentMode == obj_toolPane.modeRead)){
							if (obj_panelPane.functionField_chainFieldSelected != "" && obj_panelPane.functionField_chainTagSelected != ""
							&& is_string(obj_panelPane.functionField_chainFieldSelected) && is_string(obj_panelPane.functionField_chainTagSelected)) {
								var chainTagMap = chainSubMap[? "tagMap"];
								if (scr_isNumericAndExists(chainTagMap, ds_type_map)) {
									chainTagMap[? obj_panelPane.functionField_chainFieldSelected] = obj_panelPane.functionField_chainTagSelected;
									show_debug_message("scr_tokenRightClicked ... setting ChainSubMap: " + string(currentChainID) + ", field:" + string(obj_panelPane.functionField_chainFieldSelected) + ", tag: " + string(obj_panelPane.functionField_chainTagSelected));
								}
							}			
						}
					}						
				}
			}
		}
		instance_destroy();
	}
	else if (optionSelected == "Tag Entry") {
		// set field/tags
		if (obj_control.rightClickID != "") {
			var tokenSubMap = global.nodeMap[? obj_control.rightClickID];
			if(scr_isNumericAndExists(tokenSubMap, ds_type_map)){
				var inChainsList = tokenSubMap[? "inChainsList"];
				var inChainsListSize = ds_list_size(inChainsList);
					
				for(var i = 0; i < inChainsListSize; i++){
					var currentChainID = inChainsList[| i];
					var chainSubMap = global.nodeMap[? currentChainID];	
						
					if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
						var chainType = chainSubMap[? "type"];		
							
						if((chainType == "trail" && obj_toolPane.currentMode == obj_toolPane.modeTrack or obj_toolPane.currentMode == obj_toolPane.modeRead)
						or (chainType == "resonance" && obj_toolPane.currentMode == obj_toolPane.modeRez or obj_toolPane.currentMode == obj_toolPane.modeRead)){
								var chainSetList = chainSubMap[? "setIDList"];
								var sizeOfSetList = ds_list_size(chainSetList);
								 
							for(var j = 0 ; j < sizeOfSetList ; j ++){
								var currentEntry = chainSetList[|j];
								var currentEntrySubMap = global.nodeMap[?currentEntry];
									
								if(scr_isNumericAndExists(currentEntrySubMap , ds_type_map)){
									var currentTokenID = currentEntrySubMap[?"token"];
										
									if(currentTokenID == obj_control.rightClickID){
										if (obj_panelPane.functionField_entryFieldSelected != "" && obj_panelPane.functionField_entryTagSelected != ""
										&& is_string(obj_panelPane.functionField_entryFieldSelected) && is_string(obj_panelPane.functionField_entryTagSelected)) {
											var currentEntryTagMap = currentEntrySubMap[? "tagMap"];
											if (scr_isNumericAndExists(currentEntryTagMap, ds_type_map)) {
												currentEntryTagMap[? obj_panelPane.functionField_entryFieldSelected] = obj_panelPane.functionField_entryTagSelected;
												show_debug_message("scr_tokenRightClicked ... setting ChainSubMap: " + string(currentEntry) + ", field:" + string(obj_panelPane.functionField_entryFieldSelected) + ", tag: " + string(obj_panelPane.functionField_entryTagSelected));
											}
										}
									}
								}
							}									
						}
					}						
				}
			}
		}
		instance_destroy();
	}
	else if (optionSelected == "Tag Token") {
		// set field/tags
		if (obj_control.rightClickID != "") {
			var tokenSubMap = global.nodeMap[? obj_control.rightClickID];
			if(scr_isNumericAndExists(tokenSubMap, ds_type_map)){
				if (obj_panelPane.functionField_tokenFieldSelected != "" && obj_panelPane.functionField_tokenTagSelected != ""
				&& is_string(obj_panelPane.functionField_tokenFieldSelected) && is_string(obj_panelPane.functionField_tokenTagSelected)) {
					var tokenTagMap = tokenSubMap[? "tagMap"];
					if (scr_isNumericAndExists(tokenTagMap, ds_type_map)) {
						if(global.steamAPI){
							if(!steam_get_achievement("SA_tag-token")){
								steam_set_achievement("SA_tag-token");
							}
						}
						tokenTagMap[? obj_panelPane.functionField_tokenFieldSelected] = obj_panelPane.functionField_tokenTagSelected;
						show_debug_message("scr_tokenRightClicked ... setting tokenSubMap: " + string(obj_control.rightClickID) + ", field:" + string(obj_panelPane.functionField_tokenFieldSelected) + ", tag: " + string(obj_panelPane.functionField_tokenTagSelected));
					}
				}			
			}
		}
			

		instance_destroy(obj_dropDown);
	}
	else if (optionSelected == "tab_name_tag") {
		obj_control.tokenToChange =	obj_control.rightClickID;
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		if(obj_control.inChunk){
			// localize
			ds_list_add(dropDownOptionList, "Tag Chunk");
		}
		else{
			// localize
			ds_list_add(dropDownOptionList, "Tag Token");
		}
		if(obj_control.inChain){
			// localize
			ds_list_add(dropDownOptionList, "Tag Chain", "Tag Entry");
		}
		if (ds_list_size(dropDownOptionList) > 0) {
			scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeTag);
		}
	}
	else if (optionSelected == "option_delete-chunk") {
		obj_control.deleteChunkWord = true;
		var chunkSubMap = global.nodeMap[?obj_control.rightClickID];
		var inChainsList = chunkSubMap[?"inChainsList"];
		if(ds_list_size(inChainsList) > 0){
			scr_deleteFromChain(true);
		}
		scr_deleteChunk(obj_control.rightClickID);
			
		obj_control.deleteChunkWord = false;
		instance_destroy();
	}
	else if (optionSelected == "option_delete-token") {
		var tokenSubMap = global.nodeMap[?obj_control.rightClickID];
		scr_deleteToken(obj_control.rightClickID);
			
		instance_destroy();
	}
	else if (optionSelected == "word_tip") {
		obj_wordTip.wordTipDisplay = !obj_wordTip.wordTipDisplay;			
		instance_destroy();
	}
	else if (optionSelected == "option_zero-0") {
		scr_newTokenOptions("option_zero-0");
	}
	else if (optionSelected == "option_sync-unit-tab") {
		scr_showInNav(obj_control.rightClickID);
		instance_destroy();
	}
	else if (optionSelected == "option_split-unit") {
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.questionWindowActive = true;
			obj_dialogueBox.splitUnit = true;
		}
		instance_destroy();
	}
	else if (optionSelected == "option_split-token") {
		scr_splitToken(obj_control.rightClickID);
	}
	else if (optionSelected == "option_merge-token") {
		if(!instance_exists(obj_dialogueBox)){
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.questionWindowActive = true;
			obj_control.mergeToken = true;
		}
	}


	obj_control.rightClicked = false;
	
}
