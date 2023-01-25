function scr_navWindowTaggingSelection(fieldList, idList, type) {
	
	var canPressArrowKeyAlarm = 12;
	
	var inputBoxExists = instance_exists(obj_inputBox);
	if (obj_control.navWindowTaggingField != "" && obj_control.navWindowTaggingID != "") {
		if (mouse_check_button_pressed(mb_left) && !obj_control.mouseoverTagCell && !obj_control.mouseoverInputBox && !obj_control.mouseoverDropDown) {
			show_debug_message("scr_navWindowTaggingSelection delete inputboxes");
			scr_clearNavWindowTagging(true);
		}
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		scr_drawRectWidth(obj_control.navWindowTaggingCellX1 - clipX, obj_control.navWindowTaggingCellY1 - clipY, obj_control.navWindowTaggingCellX2 - clipX, obj_control.navWindowTaggingCellY2 - clipY, 2, false);
		
		var idListSize = ds_list_size(idList);
		
		// get submap for this field
		var fieldSubMap = "";
		var tagMap = -1;
		if (type == "token" || type == "chunk") {
			tagMap = global.nodeMap[? "tokenTagMap"];
		}
		else if (type == "unit") {
			tagMap = global.nodeMap[? "unitTagMap"];
		}
		else if (type == "entry") {
			tagMap = global.nodeMap[? "entryTagMap"];
		}
		else if (type == "chain") {
			tagMap = global.nodeMap[? "chainTagMap"];
		}
		fieldSubMap = tagMap[? obj_control.navWindowTaggingField];
		var fieldHasTagSet = scr_checkForTagSet(fieldSubMap);
		
		var readOnly = false;
		if (scr_isNumericAndExists(fieldSubMap, ds_type_map)) {
			readOnly = fieldSubMap[? "readOnly"];
		}
		
		if (global.ctrlHold && !inputBoxExists) {
			// copy
			if (keyboard_check_pressed(ord("C"))) {
				var currentTagValue = scr_navWindowGetTagValue();
				if (currentTagValue != "") clipboard_set_text(currentTagValue);
				show_debug_message("scr_navWindowTaggingSelection, copied to clipboard: " + string(clipboard_get_text()));
			}
			
			if (fieldHasTagSet && !readOnly) {
				// paste
				if (keyboard_check_pressed(ord("V"))) {
					
					// check if this field is locked, if it is check if the pasted value is in the tag set
					var pasteValue = clipboard_get_text()
					var preventPaste = false;
					if (scr_checkLockedField(obj_control.navWindowTaggingField)) {
						var tagSet = fieldSubMap[? "tagSet"];
						preventPaste = ds_list_find_index(tagSet, pasteValue) == -1;
					}
					
					// paste!
					if (!preventPaste) {
						var idSubMap = global.nodeMap[? obj_control.navWindowTaggingID];
						if (scr_isNumericAndExists(idSubMap, ds_type_map)) {
							var idTagMap = idSubMap[? "tagMap"];
							if (scr_isNumericAndExists(idTagMap, ds_type_map)) {
								idTagMap[? obj_control.navWindowTaggingField] = pasteValue;
							}
						}
						show_debug_message("scr_navWindowTaggingSelection, pasted from clipboard: " + string(clipboard_get_text()));
					}
				}
				keyboard_lastchar = "";
			}
		}

		
		// backspace & delete
		if (fieldHasTagSet && !readOnly) {
			if ((keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_delete)) && !inputBoxExists) {
				var idSubMap = global.nodeMap[? obj_control.navWindowTaggingID];
				if (scr_isNumericAndExists(idSubMap, ds_type_map)) {
					var idTagMap = idSubMap[? "tagMap"];
					if (scr_isNumericAndExists(idTagMap, ds_type_map)) {
						idTagMap[? obj_control.navWindowTaggingField] = "";
					}
				}
				show_debug_message("scr_navWindowTaggingSelection, backspace/delete");
			}
		}
		
		
		var lastCharIsLetter = scr_isCharLetter(keyboard_lastchar);
		if (readOnly && lastCharIsLetter) {
			keyboard_lastchar = "";
			lastCharIsLetter = false;
		}
		
		// create input box if user presses enter or types a letter on keyboard
		if (!inputBoxExists && !obj_control.navWindowTaggingDisableSpawn && !global.ctrlHold && !instance_exists(obj_dropDown) && fieldHasTagSet && !readOnly) {
			
			var enterKeyPressed = keyboard_check_pressed(vk_enter);
			
			
			if (enterKeyPressed || lastCharIsLetter) {
				
				// fill dropDown options with tagSet
				var dropDownOptionList = ds_list_create();
				if (scr_isNumericAndExists(fieldSubMap, ds_type_map)) {
					var tagSet = fieldSubMap[? "tagSet"];

					if (scr_isNumericAndExists(tagSet, ds_type_list)) {
						ds_list_copy(dropDownOptionList, tagSet);
					}
				}
							
			}
			
			var currentDropDownType = 0;
			if (type == "token") {
				currentDropDownType = global.optionListTypeTokenTagMap;
			}
			else if (type == "unit") {
				currentDropDownType = global.optionListTypeUnitTagMap;
			}
			else if (type == "entry") {
				currentDropDownType = global.optionListTypeEntryTagMap;
			}
			else if (type == "chain") {
				currentDropDownType = global.optionListTypeChainTagMap;
			}
			else if (type == "chunk") {
				currentDropDownType = global.optionListTypeChunk1To1Tag;
			}
			
			

			if (enterKeyPressed) {
				obj_control.navWindowTaggingEnterPress = true;
				var currentTagValue = scr_navWindowGetTagValue();
				scr_spawnTagInputBox(obj_control.navWindowTaggingID, obj_control.navWindowTaggingField, type, currentTagValue, self.id, dropDownOptionList, currentDropDownType);
				obj_control.navWindowTaggingFocusHeavy = true;
			}
			else if (lastCharIsLetter && obj_control.navWindowTaggingKeyboardInput) {
				scr_spawnTagInputBox(obj_control.navWindowTaggingID, obj_control.navWindowTaggingField, type, keyboard_lastchar, self.id, dropDownOptionList, currentDropDownType);
				obj_control.navWindowTaggingFocusHeavy = false;
				obj_control.navWindowTaggingKeyboardLastChar = keyboard_lastchar;
				keyboard_lastchar = "";
			}
			
		}
		
		// arrow key movement around nav window
		var selectNextRow = false;
		if (!obj_control.navWindowTaggingFocusHeavy) {
			var cancelHorizontalMove = false;
			if (instance_exists(obj_dropDown)) {
				if (obj_dropDown.optionCurrent >= 0) cancelHorizontalMove = true;
			}
			
			if (!cancelHorizontalMove) {
				if (keyboard_check(vk_left) && obj_control.navWindowTaggingCanPressLeft) {
					obj_control.navWindowTaggingCanPressLeft = false;
					with (obj_alarm3) alarm[2] = canPressArrowKeyAlarm;
					with (obj_inputBox) instance_destroy();
					var fieldIndex = ds_list_find_index(fieldList, obj_control.navWindowTaggingField);
					fieldIndex = max(fieldIndex - 1, 0);
					obj_control.navWindowTaggingField = fieldList[| fieldIndex];
					obj_control.navWindowTaggingUpdateScroll = true;
				}
				else if (keyboard_check(vk_right) && obj_control.navWindowTaggingCanPressRight) {
					
					obj_control.navWindowTaggingCanPressRight = false;
					with (obj_alarm3) alarm[3] = canPressArrowKeyAlarm;
					with (obj_inputBox) instance_destroy();
					var fieldIndex = ds_list_find_index(fieldList, obj_control.navWindowTaggingField);
					fieldIndex = min(fieldIndex + 1, ds_list_size(fieldList) - 1);
					obj_control.navWindowTaggingField = fieldList[| fieldIndex];
					obj_control.navWindowTaggingUpdateScroll = true;
				}
			}
			

		}
		if (keyboard_check_pressed(vk_tab)) {
			with (obj_inputBox) instance_destroy();
			var fieldIndex = ds_list_find_index(fieldList, obj_control.navWindowTaggingField);
			fieldIndex = min(fieldIndex + 1, ds_list_size(fieldList) - 1);
			obj_control.navWindowTaggingField = fieldList[| fieldIndex];
			obj_control.navWindowTaggingUpdateScroll = true;
		}
		
		var canArrowUpDown = false;
		if (!instance_exists(obj_dropDown)) canArrowUpDown = true;
		else {
			if (ds_list_size(obj_dropDown.optionList) == 0) canArrowUpDown = true;
		}
		
		
		// arrow key up & down
		var handleTokenEntries = (type == "token" && obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabLine);
		if (canArrowUpDown) {
			if (keyboard_check(vk_up) && obj_control.navWindowTaggingCanPressUp) {
				if (type == "token" && handleTokenEntries) {
					var prevID = "";
					var idFound = false;
					for (var i = idListSize - 1; i >= 0; i--) {
						var currentID = idList[| i];
						var currentIDSubMap = global.nodeMap[? currentID];
						var currentToken = currentIDSubMap[? "token"];
						if (!idFound && currentToken == obj_control.navWindowTaggingID) idFound = true;
						else if (idFound && prevID == "") prevID = currentToken;
					}
					if (prevID != "") {
						obj_control.navWindowTaggingCanPressUp = false;
						with (obj_alarm3) alarm[0] = canPressArrowKeyAlarm;
						with (obj_inputBox) instance_destroy();
						obj_control.navWindowTaggingID = prevID;
						obj_control.navWindowTaggingUpdateScroll = true;
					}
				}
				else if (type == "unit" or type == "chain" or type == "chunk" or type == "token") {
					var IDListIndex = ds_list_find_index(idList, obj_control.navWindowTaggingID);
					if (IDListIndex > 0) {
						with (obj_alarm3) alarm[0] = canPressArrowKeyAlarm;
						with (obj_inputBox) instance_destroy();
						obj_control.navWindowTaggingID = idList[| IDListIndex - 1];
						obj_control.navWindowTaggingUpdateScroll = true;
					}
					obj_control.navWindowTaggingCanPressUp = false;
				}
				else if (type == "entry") {
					var entrySubMap = global.nodeMap[? obj_control.navWindowTaggingID];
					var chainID = entrySubMap[? "chain"];
					var chainSubMap = global.nodeMap[? chainID];
					var entryIDList = (obj_control.chain1toManyCustomSortColIndex == -1) ? chainSubMap[? "vizSetIDList"] : chainSubMap[? "customSetIDList"];
					var IDListIndex = ds_list_find_index(entryIDList, obj_control.navWindowTaggingID);
					if (IDListIndex > 0) {
						with (obj_alarm3) alarm[0] = canPressArrowKeyAlarm;
						with (obj_inputBox) instance_destroy();
						obj_control.navWindowTaggingID = entryIDList[| IDListIndex - 1];
						obj_control.navWindowTaggingUpdateScroll = true;
					}
					obj_control.navWindowTaggingCanPressUp = false;
				}
			}
			else if (keyboard_check(vk_down) && obj_control.navWindowTaggingCanPressDown) {
				obj_control.navWindowTaggingCanPressDown = false;
				with (obj_alarm3) alarm[1] = canPressArrowKeyAlarm;
				selectNextRow = true;
			}
		}

		
		
		
		if (obj_control.navWindowTaggingNextRow) {
			obj_control.navWindowTaggingNextRow = false;
			if (!instance_exists(obj_dialogueBox) && obj_control.mouseoverDropDownOption != "option_add-to-tag-set") {
				selectNextRow = true;
			}
		}
	
		if (selectNextRow) {
			if (type == "token" && handleTokenEntries) {
				var nextID = "";
				var idFound = false;
				for (var i = 0; i < idListSize; i++) {
					var currentID = idList[| i];
					var currentIDSubMap = global.nodeMap[? currentID];
					var currentToken = currentIDSubMap[? "token"];
					if (!idFound && currentToken == obj_control.navWindowTaggingID) idFound = true;
					else if (idFound && nextID == "") nextID = currentToken;
				}
				if (nextID != "") {
					with (obj_inputBox) instance_destroy();
					obj_control.navWindowTaggingID = nextID;
					obj_control.navWindowTaggingUpdateScroll = true;
				}
			}
			else if (type == "unit" or type == "chain" or type == "chunk" or type == "token") {
				var IDListIndex = ds_list_find_index(idList, obj_control.navWindowTaggingID);
				if (IDListIndex < ds_list_size(idList) - 1) {
					with (obj_inputBox) instance_destroy();
					obj_control.navWindowTaggingID = idList[| IDListIndex + 1];
					obj_control.navWindowTaggingUpdateScroll = true;
				}
			}
			else if (type == "entry") {
				var entrySubMap = global.nodeMap[?obj_control.navWindowTaggingID];
				var chainID = entrySubMap[? "chain"];
				var chainSubMap = global.nodeMap[?chainID];
				var entryIDList = (obj_control.chain1toManyCustomSortColIndex == -1) ? chainSubMap[? "vizSetIDList"] : chainSubMap[? "customSetIDList"];
				var IDListIndex = ds_list_find_index(entryIDList, obj_control.navWindowTaggingID);
				if (IDListIndex < ds_list_size(entryIDList) - 1) {
					with (obj_inputBox) instance_destroy();
					obj_control.navWindowTaggingID = entryIDList[| IDListIndex + 1];
					obj_control.navWindowTaggingUpdateScroll = true;
				}
			}
		}
	}
	

}