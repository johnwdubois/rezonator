function scr_chainListOptions(optionSelected) {

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			

		
			obj_control.selectedChainID = obj_chain.currentFocusedChainID;
			if (!ds_map_exists(global.nodeMap, obj_control.selectedChainID) || obj_control.selectedChainID == "") {
				show_debug_message("scr_chainListOptions() exiting...");
				exit;
			}


			//"Rename", "Recolor", "Delete"
			switch (optionSelected) {
				case "Rename":

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
				case "Recolor":
					//might be a special case

					var dropDownOptionList = ds_list_create();
					ds_list_add(dropDownOptionList, "Red", "Blue", "Green", "Gold", "Custom");
						
					if (ds_list_size(dropDownOptionList) > 0) {
						scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + obj_dropDown.optionSpacing, dropDownOptionList, global.optionListTypeChainRecolor);
					}
	
					break;
				case "Delete":

						
					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						obj_dialogueBox.clearChain = true;
						obj_dialogueBox.questionWindowActive = true;
					}
		
					instance_destroy(obj_dropDown);

					break;
				case "Caption":
		
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
				case "Clip":
					
					// Create a clip file based on that Stack
					scr_clipFromStack(obj_control.selectedChainID);
					
					// Destory the Dropdown
					instance_destroy(obj_dropDown);
					break;
				default:
					break;
			}
					
		}
	}


}
