function scr_chainRecolorOptions(optionSelected) {

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			
			// get chain and its submap, make sure they exist
			obj_control.selectedChainID = obj_chain.currentFocusedChainID;
			var chainType = "";
			var chainSubMap = global.nodeMap[? obj_control.selectedChainID];		
			if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) {
				show_debug_message("scr_chainRecolorOptions, chain does not exist");
				with (obj_dropDown) {
					instance_destroy();
				}
				exit;
				
			}
			
			
			if (optionSelected == "option_red" || optionSelected == "option_blue" || optionSelected == "option_green" || optionSelected == "option_gold") {
				var colorToSet = 0;
				if (optionSelected == "option_red") colorToSet = 255;
				else if (optionSelected == "option_blue") colorToSet = 16711680;
				else if (optionSelected == "option_green") colorToSet = 65280;
				else if (optionSelected == "option_gold") colorToSet = 4235000;
				chainSubMap[? "chainColor"] = colorToSet;
				with (obj_dropDown) {
					instance_destroy();
				}
			}
			else if (optionSelected == "option_custom") {
				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.recolor = true;
				}

				obj_control.dialogueBoxActive = true;
				with (obj_dropDown) {
					instance_destroy();
				}
				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				}
				obj_dialogueBox.inputWindowActive = true;
			}
			else if (optionSelected == "menu_random") {
				var colorToSet = scr_randomChainColor();
				chainSubMap[? "chainColor"] = colorToSet;
			}
			else if (optionSelected == "Match Participant color") {
				
				// get the focused entry in this chain
				var _focusedEntryID = chainSubMap[? "focused"];
				var _focusedEntrySubMap = global.nodeMap[? _focusedEntryID];
				try {
					
					var _unitID = "";
					
					var _focusedEntryType = _focusedEntrySubMap[? "type"];
					if (_focusedEntryType == "rez" || _focusedEntryType == "track") {
						
						// get the token associated with this entry
						var _tokenID = _focusedEntrySubMap[? "token"];
						var _tokenSubMap = global.nodeMap[? _tokenID];
						
						// get the unit associated with this token
						_unitID = _tokenSubMap[? "unit"];
					}
					else if (_focusedEntryType == "card") {
						
						// get unit associated with this entry
						_unitID = _focusedEntrySubMap[? "unit"];
					}
					
					// get participant color for this unit
					var _unitSubMap = global.nodeMap[? _unitID];
					var _unitTagMap = _unitSubMap[? "tagMap"];
					var _unitParticipant = _unitTagMap[? global.participantField];
					var _participantColor = scr_strToColor(string(_unitParticipant));
					var _participantColorHue = color_get_hue(_participantColor);
					
					// set color in chainSubMap
					chainSubMap[? "chainColor"] = make_color_hsv(_participantColorHue, 200, 230);
					
					with (obj_dropDown) instance_destroy();
				}
				catch(e) {
					show_debug_message("scr_chainRecolorOptions ERROR: " + string(e.message));
				}
			}
		}
	}
}
