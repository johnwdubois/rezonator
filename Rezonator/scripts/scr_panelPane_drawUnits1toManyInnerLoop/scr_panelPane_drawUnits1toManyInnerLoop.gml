// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawUnits1toManyInnerLoop(tokenID, drawDropDowns, strHeight, textPlusY, cellRectY1, cellRectY2, highlight){

	var tokenSubMap = global.nodeMap[? tokenID];
	var tagMap = tokenSubMap[? "tagMap"];
	if (!scr_isNumericAndExists(tagMap, ds_type_map)) exit;
	
	var xBuffer = 6;
	var tabHeight = functionTabs_tabHeight;
	var fieldList = obj_control.navTokenFieldList;
	var fieldListSize = ds_list_size(fieldList);
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var spaceWidth = string_width(" ");
	
	// draw BG highlight for the entire windowWidth (if we have less than 6 columns)
	if (highlight && fieldListSize < 6) {
		draw_set_color(merge_color(global.colorThemeBG, global.colorThemeText, 0.15));
		draw_set_alpha(1);
		draw_rectangle(x - clipX, cellRectY1 - clipY, x + windowWidth - clipX, cellRectY2 - clipY, false);
	}
	
	// Set collected info into respective columns
	var plusX = x;
	for (var i = 0; i < fieldListSize; i++) {
		
		var currentField = fieldList[| i];
		var currentStr = "";

		// get size of dropdown buttons
		var dropDownButtonWidth = sprite_get_width(spr_dropDown);
		var dropDownButtonHeight = (tabHeight / 2);
					
		// leave room for scrollbar if we're in RTL and on the last column
		if (!lineStateLTR && i == fieldListSize - 1) {
			textX -= global.scrollBarWidth;
		}
		
		// BG rect coordinates
		var colWidth = windowWidth / fieldListSize;
		var cellRectX1 = plusX;
		var cellRectX2 = cellRectX1 + colWidth;
		draw_set_color(highlight ? merge_color(global.colorThemeBG, global.colorThemeText, 0.15) : global.colorThemeBG);
		draw_set_alpha(1);
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		
		// text coordinates
		var textX = floor(cellRectX1 + spaceWidth);
		var textY = floor(mean(cellRectY1, cellRectY2));
		
		// draw text	
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_set_halign(lineStateLTR ? fa_left : fa_right);
		draw_set_valign(fa_middle);
		currentStr = tagMap[? currentField];
		currentStr = scr_adaptFont(currentStr, "S");
		draw_text(textX - clipX, textY - clipY, currentStr);
		
		// dropDown button coordinates
		var dropDownRectX1 = cellRectX2 - dropDownButtonWidth;
		if (i == fieldListSize - 1) dropDownRectX1 -= global.scrollBarWidth;
		var dropDownRectY1 = mean(cellRectY1, cellRectY2) - (dropDownButtonHeight / 2);
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonWidth;
		var dropDownRectY2 = dropDownRectY1 + dropDownButtonHeight;
					
	
		// draw tag selection
		var colIndex = -1;
		//colIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 2);
		var mapKey = ds_list_find_value(global.tokenImportColNameList, colIndex);
		var isTildaField = (string_char_at(string(mapKey), 1) == "~");
			

		if (drawDropDowns && ds_map_exists(global.tokenImportTagMap, mapKey) && !isTildaField) {
				
			if (mouseoverDropDown) {
									
				scr_createTooltip(mean(dropDownRectX1, dropDownRectX2), dropDownRectY2, "Change tag", obj_tooltip.arrowFaceUp);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(dropDownRectX1- clipX, dropDownRectY1 - clipY , dropDownRectX2 - clipX, dropDownRectY2 - clipY, true);

				if (mouse_check_button_released(mb_left)) {
					
					// get list of token tags for this field
					var tagMapList = ds_map_find_value(global.tokenImportTagMap, mapKey);
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
					var mouseoverDropDown = point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2);
					
					
					with (obj_panelPane) {
						selectedColToken = i;
					}
					
					// create dropdown
					var dropDownOptionList = ds_list_create();
					if (scr_isNumericAndExists(tagMapList, ds_type_list)) {
						if (ds_list_size(tagMapList) > 0) {
							ds_list_copy(dropDownOptionList, tagMapList);
							obj_control.tokenImportColToChange = 0;
							obj_control.tokenImportRowToChange = 0;
							
							var dropDownX = textX - xBuffer;
							var dropDownY = textY + scrollPlusY + (strHeight / 2);							
							scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, global.optionListTypeTokenTagMap);
						}
					}
				}
			}
		}
		
		plusX += colWidth;
	}
}