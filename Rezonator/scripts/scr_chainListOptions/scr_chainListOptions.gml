function scr_chainListOptions(optionSelected) {
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			

		
			obj_control.selectedChainID = obj_chain.currentFocusedChainID;
			if (!ds_map_exists(global.nodeMap, obj_control.selectedChainID) || obj_control.selectedChainID == "") {
				show_debug_message("scr_chainListOptions() exiting...");
				exit;
			}


			//"help_label_rename", "Recolor", "help_label_delete_plain"
			switch (optionSelected) {
				case "help_label_rename":

					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.rename = true;
					}

					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
					obj_dialogueBox.inputWindowActive = true;
					instance_destroy(obj_dropDown);
					
					break;
				case "option_recolor":
					//might be a special case

					var dropDownOptionList = ds_list_create();
					ds_list_add(dropDownOptionList, "option_red", "option_blue", "option_green", "option_gold", "option_custom");
						
					if (ds_list_size(dropDownOptionList) > 0) {
						with (obj_dropDown) if (level > 1) instance_destroy();
						scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + obj_dropDown.optionSpacing, dropDownOptionList, global.optionListTypeChainRecolor);
					}
	
					break;
				case "help_label_delete_plain":

						
					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						obj_dialogueBox.clearChain = true;
						obj_dialogueBox.questionWindowActive = true;
					}
		
					instance_destroy(obj_dropDown);

					break;
				case "help_label_caption":
		
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.caption = true;
					}


					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
					obj_dialogueBox.inputWindowActive = true;
						instance_destroy(obj_dropDown);

					break;
				case "option_clip":
					
					// Create a clip file based on that Stack
					scr_clipFromStack(obj_control.selectedChainID);
					
					// Destory the Dropdown
					instance_destroy(obj_dropDown);
					break;
				case "option_create-tree":
					
					var chainSubMap = global.nodeMap[? obj_control.selectedChainID];
					if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
						var tokenList = ds_list_create();
						var setIDList = chainSubMap[? "setIDList"];
						var setIDListSize = ds_list_size(setIDList);
						show_debug_message("setIDListSize:   "+ string(setIDListSize));
						for (var i = 0; i < setIDListSize; i++) {
							var currentChainEntry = setIDList[| i];
							var currentEntrySubMap = global.nodeMap[? currentChainEntry];
							
							var currentUnit = currentEntrySubMap[? "unit"];
							
							var unitSubMap = global.nodeMap[? currentUnit];
							
							var entryList = unitSubMap[? "entryList"];
							var entryListSize = ds_list_size(entryList);
							show_debug_message("entryListSize:   "+ string(entryListSize));
							for (var j = 0; j < entryListSize; j++) {
								var currentEntry = entryList[| j];
								var currentEntrySubMap = global.nodeMap[? currentEntry];
								var currentToken = currentEntrySubMap[? "token"];
								ds_list_add(tokenList, currentToken);
							}
							
						}
						scr_createTree(tokenList);	
					}
					// Destory the Dropdown
					instance_destroy(obj_dropDown);
					break;
				case "Set Rez Map":
					scr_setRezMap(obj_chain.currentFocusedChainID);
					instance_destroy(obj_dropDown);
					break;
				case "option_add-to-show":
					var dropDownOptionList = ds_list_create();
					var showList = global.nodeMap[? "showList"];
					ds_list_copy(dropDownOptionList, showList);
					ds_list_insert(dropDownOptionList, 0, "option_create-show");
					with (obj_dropDown) if (level > 1) instance_destroy();
					scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeSelectShow);
					break;
				default:
					break;
			}
					
		}
	}


}
