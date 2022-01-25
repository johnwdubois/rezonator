function scr_navWindowTaggingSelection(fieldList, idList){

	if (obj_control.navWindowTaggingField != "" && obj_control.navWindowTaggingID != "") {
		
		if (mouse_check_button_pressed(mb_left) && !obj_control.mouseoverTagCell) {
			scr_clearNavWindowTagging();
		}
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		scr_drawRectWidth(obj_control.navWindowTaggingCellX1 - clipX, obj_control.navWindowTaggingCellY1 - clipY, obj_control.navWindowTaggingCellX2 - clipX, obj_control.navWindowTaggingCellY2 - clipY, 2, false);
		
		var idListSize = ds_list_size(idList);
		
		if (keyboard_check_pressed(vk_left)) {
			var fieldIndex = ds_list_find_index(fieldList, obj_control.navWindowTaggingField);
			fieldIndex = max(fieldIndex - 1, 0);
			obj_control.navWindowTaggingField = fieldList[| fieldIndex];
			obj_control.navWindowTaggingUpdateScroll = true;
		}
		else if (keyboard_check_pressed(vk_right)) {
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
				obj_control.navWindowTaggingID = prevID;
				obj_control.navWindowTaggingUpdateScroll = true;
			}
		}
		else if (keyboard_check_pressed(vk_down)) {
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
				obj_control.navWindowTaggingID = nextID;
				obj_control.navWindowTaggingUpdateScroll = true;
			}
		}
	}

}