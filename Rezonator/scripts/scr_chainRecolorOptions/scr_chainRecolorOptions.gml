function scr_chainRecolorOptions(optionSelected) {

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			
			// get chain and its submap, make sure they exist
			obj_control.selectedChainID = obj_chain.currentFocusedChainID;
			var chainType = "";
			var chainSubMap = global.nodeMap[? obj_control.selectedChainID];		
			if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) {
				show_debug_message("scr_chainRecolorOptions, chain does not exist");
				exit;
			}
			
			
			if (optionSelected == "Red" || optionSelected == "Blue" || optionSelected == "Green" || optionSelected == "Gold") {
				var colorToSet = 0;
				if (optionSelected == "Red") colorToSet = 255;
				else if (optionSelected == "Blue") colorToSet = 16711680;
				else if (optionSelected == "Green") colorToSet = 65280;
				else if (optionSelected == "Gold") colorToSet = 4235000;
				chainSubMap[? "chainColor"] = colorToSet;

			}
			else if (optionSelected == "Custom") {
				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.recolor = true;
				}

				obj_control.dialogueBoxActive = true;

				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				}
				obj_dialogueBox.inputWindowActive = true;
			}
			
			
		}
	}
}
