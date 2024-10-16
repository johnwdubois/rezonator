function scr_chainListOptions(optionSelected) {
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			

		
			obj_control.selectedChainID = obj_chain.currentFocusedChainID;
			if (!ds_map_exists(global.nodeMap, obj_control.selectedChainID) || obj_control.selectedChainID == "") {
				show_debug_message("scr_chainListOptions() exiting...");
				exit;
			}
			var selectedChainSubMap = global.nodeMap[? obj_control.selectedChainID];


			//"help_label_rename", "Recolor", "help_label_delete_plain"
			switch (optionSelected) {
				case "help_label_rename":

					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.rename = true;
						global.inputBoxDefStr = string(selectedChainSubMap[? "name"]);
						show_debug_message("global.inputBoxDefStr: " + string(global.inputBoxDefStr));
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
					ds_list_add(dropDownOptionList, "menu_random" , "option_red", "option_blue", "option_green", "option_gold", "option_custom");
						
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
					
					scr_createTreeFromStack(obj_control.selectedChainID);
					// Destory the Dropdown
					instance_destroy(obj_dropDown);
					break;
				case "Set Rez Map":

					obj_control.setRezMap = true;
					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
					obj_dialogueBox.inputWindowActive = true;
				
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
