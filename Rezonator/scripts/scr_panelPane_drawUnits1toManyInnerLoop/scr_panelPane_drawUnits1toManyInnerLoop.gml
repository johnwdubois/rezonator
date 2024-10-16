 function scr_panelPane_drawUnits1toManyInnerLoop(tokenID, drawDropDowns, strHeight, textPlusY, cellRectY1, cellRectY2, highlight) {

	var tokenSubMap = global.nodeMap[? tokenID];
	var tagMap = tokenSubMap[? "tagMap"];
	if (!scr_isNumericAndExists(tagMap, ds_type_map)) exit;
	
	var xBuffer = 6;
	var tabHeight = functionTabs_tabHeight;
	var fieldList = obj_control.navTokenFieldList;
	var fieldListSize = ds_list_size(fieldList);
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var spaceWidth = string_width(" ");
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y + functionTabs_tabHeight, x + windowWidth, y + windowHeight);
	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_sizeWindow) || mouseoverHorScrollBar || scrollBarHorHolding || mouseoverScrollBar || scrollBarHolding;
	if (!mouseoverWindow) mouseoverCancel = true;
	
	
	// draw BG highlight for the entire windowWidth (if we have less than 6 columns)
	if (highlight && fieldListSize < 6) {
		draw_set_color(merge_color(global.colorThemeBG, global.colorThemeText, 0.15));
		draw_set_alpha(1);
		draw_rectangle(x - clipX, cellRectY1 - clipY, x + windowWidth - clipX, cellRectY2 - clipY, false);
	}
	
	var i = 0
	// get size of dropdown buttons
	var dropDownButtonWidth = sprite_get_width(spr_dropDown);
	var dropDownButtonHeight = (tabHeight / 2);

	// Set collected info into respective columns
	var plusX = x;
	repeat(fieldListSize) {
		
		var currentField = fieldList[| i];
		var currentStr = "";

		// draw tag selection
		var isTildaField = (string_char_at(string(currentField), 1) == "~");

		// get BG rect coordinates
		var colWidth = windowWidth/obj_panelPane.unit1toMColAmount;
		var cellRectX1 = plusX + scrollHorPlusX;
		var cellRectX2 = cellRectX1 + colWidth;
		var mouseoverCell = point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) && !mouseoverCancel;
		
		// draw BG rect for this cell
		draw_set_color(highlight ? merge_color(global.colorThemeBG, global.colorThemeText, 0.15) : global.colorThemeBG);
		draw_set_alpha(1);
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		
		// text coordinates
		if (lineStateLTR) {
			var textX = floor(cellRectX1 + spaceWidth);
		}
		else {
			var textX = floor(cellRectX2 - spaceWidth);
			if (drawDropDowns && mouseoverCell && !isTildaField) {
				textX = textX - dropDownButtonWidth;
			}
		}
		var textY = floor(mean(cellRectY1, cellRectY2));
		
		// leave room for scrollbar if we're in RTL and on the last column
		if (!lineStateLTR && i == fieldListSize-1) {
			textX -= global.scrollBarWidth;
		}
		var readOnlyField = false;
		var tokenTagMap = global.nodeMap[? "tokenTagMap"];
		var currentFieldSubMap = tokenTagMap[? currentField];
		if (scr_isNumericAndExists(currentFieldSubMap, ds_type_map)) {
			if (!ds_map_exists(currentFieldSubMap, "tagSet")) readOnlyField = true;
			if (currentFieldSubMap[? "readOnly"]) readOnlyField = true;
		}
		
		// draw text	
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_set_halign(lineStateLTR ? fa_left : fa_right);
		draw_set_valign(fa_middle);
		currentStr = tagMap[? currentField];
		currentStr = scr_adaptFont(currentStr, "S");
		draw_set_alpha(readOnlyField ? 0.7 : 1);
		draw_text(textX - clipX, textY - clipY, currentStr);
		draw_set_alpha(1);
		// dropDown button coordinates
		var dropDownRectX1 = cellRectX2 - dropDownButtonWidth;
		if (i == fieldListSize - 1) dropDownRectX1 -= global.scrollBarWidth;
		var dropDownRectY1 = mean(cellRectY1, cellRectY2) - (dropDownButtonHeight / 2);
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonWidth;
		var dropDownRectY2 = dropDownRectY1 + dropDownButtonHeight;
		var mouseoverDropDown = (point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2) && !mouseoverCancel && !instance_exists(obj_inputBox) && mouseoverWindow);
		
		// draw dropdown sprite if mouseover on this cell
		if (mouseoverCell && !isTildaField && !readOnlyField) {
			draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
		}
		
		scr_cellEdit(tokenID, currentField, mouseoverCell, mouseoverDropDown, cellRectX1, cellRectY1, cellRectX2, cellRectY2, currentStr, "token");


		if (drawDropDowns && !isTildaField && !readOnlyField) {
				
			if (mouseoverDropDown) {
									
				scr_createTooltip(mean(dropDownRectX1, dropDownRectX2), dropDownRectY2, scr_get_translation("option-tag"), TOOLTIP_DIR_UP);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(dropDownRectX1- clipX, dropDownRectY1 - clipY , dropDownRectX2 - clipX, dropDownRectY2 - clipY, true);

				if (mouse_check_button_released(mb_left)) {
					
					obj_control.navWindowTaggingID = tokenID;
					obj_control.navWindowTaggingField = currentField;
					
					// get submap for this field
					var fieldSubMap = tokenTagMap[? currentField];
					
					// get the tagSet for this field
					var tagSet = fieldSubMap[? "tagSet"];
					if (scr_isNumericAndExists(tagSet, ds_type_list)) {
					
						// create dropdown
						var dropDownOptionList = ds_list_create();
						ds_list_copy(dropDownOptionList, tagSet);
						ds_list_add(dropDownOptionList, "menu_clear");

						obj_control.tokenToChange = tokenID;
						obj_control.tokenFieldToChange = currentField;
						var dropDownX = textX - xBuffer;
						var dropDownY = textY + (strHeight / 2);							
						scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, global.optionListTypeTokenTagMap);

					}
				}
			}
		}
		
		plusX += colWidth;
		i++
	}
}