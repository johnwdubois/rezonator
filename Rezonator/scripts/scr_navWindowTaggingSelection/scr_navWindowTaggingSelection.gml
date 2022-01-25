function scr_navWindowTaggingSelection(fieldList, idList){
	
	var inputBoxExists = instance_exists(obj_inputBox);

	if (obj_control.navWindowTaggingField != "" && obj_control.navWindowTaggingID != "") {
		
		if (mouse_check_button_pressed(mb_left) && !obj_control.mouseoverTagCell) {
			scr_clearNavWindowTagging();
		}
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		scr_drawRectWidth(obj_control.navWindowTaggingCellX1 - clipX, obj_control.navWindowTaggingCellY1 - clipY, obj_control.navWindowTaggingCellX2 - clipX, obj_control.navWindowTaggingCellY2 - clipY, 2, false);
		
		var idListSize = ds_list_size(idList);
		
		// copy & paste
		if (global.ctrlHold && !inputBoxExists) {
			if (keyboard_check_pressed(ord("C"))) {
				var currentTagValue = scr_navWindowGetTagValue();
				if (currentTagValue != "") clipboard_set_text(currentTagValue);
				show_debug_message("scr_navWindowTaggingSelection, copied to clipboard: " + string(clipboard_get_text()));
			}
			else if (keyboard_check_pressed(ord("V"))) {
				var idSubMap = global.nodeMap[? obj_control.navWindowTaggingID];
				if (scr_isNumericAndExists(idSubMap, ds_type_map)) {
					var idTagMap = idSubMap[? "tagMap"];
					if (scr_isNumericAndExists(idTagMap, ds_type_map)) {
						idTagMap[? obj_control.navWindowTaggingField] = clipboard_get_text();
					}
				}
				show_debug_message("scr_navWindowTaggingSelection, pasted from clipboard: " + string(clipboard_get_text()));
			}
			keyboard_lastchar = "";
		}
		
		
		
		// create input box if user presses enter or types a letter on keyboard
		if (!inputBoxExists && !obj_control.navWindowTaggingDisableSpawn && !global.ctrlHold && !instance_exists(obj_dropDown)) {
			if (keyboard_check_pressed(vk_enter)) {
				obj_control.navWindowTaggingEnterPress = true;
				var currentTagValue = scr_navWindowGetTagValue();
				scr_spawnTagInputBox(obj_control.navWindowTaggingID, obj_control.navWindowTaggingField, currentTagValue, self.id);
				obj_control.navWindowTaggingFocusHeavy = true;
			}
			else if (scr_isCharLetter(keyboard_lastchar)) {
				scr_spawnTagInputBox(obj_control.navWindowTaggingID, obj_control.navWindowTaggingField, keyboard_lastchar, self.id);
				obj_control.navWindowTaggingFocusHeavy = false;
				keyboard_lastchar = "";
			}
		}
		
		// arrow key movement around nav window
		var selectNextRow = false;
		if (!obj_control.navWindowTaggingFocusHeavy && !instance_exists(obj_dropDown)) {
			if (keyboard_check_pressed(vk_left)) {
				with (obj_inputBox) instance_destroy();
				var fieldIndex = ds_list_find_index(fieldList, obj_control.navWindowTaggingField);
				fieldIndex = max(fieldIndex - 1, 0);
				obj_control.navWindowTaggingField = fieldList[| fieldIndex];
				obj_control.navWindowTaggingUpdateScroll = true;
			}
			else if (keyboard_check_pressed(vk_right)) {
				with (obj_inputBox) instance_destroy();
				var fieldIndex = ds_list_find_index(fieldList, obj_control.navWindowTaggingField);
				fieldIndex = min(fieldIndex + 1, ds_list_size(fieldList) - 1);
				obj_control.navWindowTaggingField = fieldList[| fieldIndex];
				obj_control.navWindowTaggingUpdateScroll = true;
			}
			else if (keyboard_check_pressed(vk_up)) {
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
					with (obj_inputBox) instance_destroy();
					obj_control.navWindowTaggingID = prevID;
					obj_control.navWindowTaggingUpdateScroll = true;
				}
			}
			else if (keyboard_check_pressed(vk_down)) {
				selectNextRow = true;
			}
		}
		
		
		
		if (obj_control.navWindowTaggingNextRow) {
			obj_control.navWindowTaggingNextRow = false;
			selectNextRow = true;
		}
	
		if (selectNextRow) {
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
	}
	

}