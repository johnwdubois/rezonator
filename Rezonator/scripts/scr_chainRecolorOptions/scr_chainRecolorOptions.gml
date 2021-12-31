function scr_chainRecolorOptions(optionSelected) {

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			
			// get chain and its submap, make sure they exist
			obj_control.selectedChainID = obj_chain.currentFocusedChainID;
			var chainType = "";
			var chainSubMap = global.nodeMap[? obj_control.selectedChainID];		
			if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) {
				show_debug_message("scr_chainRecolorOptions, chain does not exist");
				instance_destroy();
				exit;
				
			}
			
			
			if (optionSelected == "option_red" || optionSelected == "option_blue" || optionSelected == "option_green" || optionSelected == "option_gold") {
				var colorToSet = 0;
				if (optionSelected == "option_red") colorToSet = 255;
				else if (optionSelected == "option_blue") colorToSet = 16711680;
				else if (optionSelected == "option_green") colorToSet = 65280;
				else if (optionSelected == "option_gold") colorToSet = 4235000;
				chainSubMap[? "chainColor"] = colorToSet;
				instance_destroy();
			}
			else if (optionSelected == "option_custom") {
				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.recolor = true;
				}

				obj_control.dialogueBoxActive = true;
				instance_destroy();
				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				}
				obj_dialogueBox.inputWindowActive = true;
			}
			else if (optionSelected == "menu_random") {
				var colorToSet = scr_randomChainColor();
				chainSubMap[? "chainColor"] = colorToSet;
			}
			
			
		}
	}
}
