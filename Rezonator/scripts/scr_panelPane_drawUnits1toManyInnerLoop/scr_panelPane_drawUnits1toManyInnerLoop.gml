// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawUnits1toManyInnerLoop(currentWordID, drawDropDowns, strHeight, textPlusY, rectY1, rectY2, highlight){
	
	var xBuffer = 6;
	var tabHeight = functionTabs_tabHeight;
	var activeCols = 0;
	
	var infoListSize = 3;
	if (functionChainList_currentTab == functionChainList_tabLine) {
		infoListSize = tokenContentsHeaderListSize;
	}
	
	// draw BG highlight for the entire windowWidth (if we have less than 6 columns)
	if (highlight && infoListSize < 6) {
		draw_set_color(merge_color(global.colorThemeBG, global.colorThemeText, 0.15));
		draw_set_alpha(1);
		draw_rectangle(x - clipX, rectY1 - clipY, x + windowWidth - clipX, rectY2 - clipY, false);
	}
	
	// Set collected info into respective columns
	for (var getInfoLoop = 0; getInfoLoop < infoListSize; getInfoLoop++) {
					
		// if this is the transcript column, and there's no transcript, skip it!
		if (getInfoLoop == 3 and !obj_control.transcriptAvailable) {
			continue;
		}
					
		var unitOrWordTagTokenView = false;
					
		currentWordInfoCol[getInfoLoop] = "";
					
		if (getInfoLoop == 0) {
			currentWordInfoCol[getInfoLoop] = currentWordID;
		}
		else if (getInfoLoop == 1) {
			if (functionChainList_currentTab == functionChainList_tabStackBrush
			or functionChainList_currentTab == functionChainList_tabClique) {
				currentWordInfoCol[getInfoLoop] = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentWordID - 1);
			}
			else {
				currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1));
			}
		}
		else if (getInfoLoop >= 2) {
			
			var importCol = -1;
			if (getInfoLoop == 2) {
				importCol = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 2);			
			}
			else{
				importCol = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 3);
			}
			
			if (importCol == undefined) {
				currentWordInfoCol[getInfoLoop] = "";
			}
			else {
				currentWordInfoCol[getInfoLoop] = string(ds_grid_get(global.tokenImportGrid, importCol, currentWordID - 1));
			}
	
			var colName = ds_list_find_value(global.tokenImportColNameList, importCol);
			if (ds_list_find_index(global.unitImportColNameList, colName) != -1 && ds_list_find_index(global.wordImportColNameList, colName) != -1) {
				unitOrWordTagTokenView = true;
			}
		}
		
		// get size of dropdown buttons
		var dropDownButtonWidth = sprite_get_width(spr_dropDown);
		var dropDownButtonHeight = (tabHeight / 2);
					
		// text coordinates
		var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
		var textX = 0;
		var textX_LTR = 0;
		var colWidth = 0;
		if (getInfoLoop == 0 or getInfoLoop == 1) {
			// first 2 columns (token ID & place)
			colWidth = windowWidth / 12;
			textX_LTR = x + (activeCols * colWidth) + xBuffer;
			if (lineStateLTR) {
				textX = textX_LTR;
			}
			else {
				textX = x + (activeCols * colWidth) + colWidth - xBuffer - dropDownButtonWidth;
			}
		}
		else {
			// columns 3+
			colWidth = windowWidth / 6;
			textX_LTR = x + (activeCols * colWidth) + xBuffer - (windowWidth / 6);
			if (lineStateLTR) {
				textX = textX_LTR;
			}
			else {
				textX = x + (activeCols * colWidth) - (windowWidth / 6) + colWidth - xBuffer - dropDownButtonWidth;
			}
		}
		var textY = y + tabHeight + textPlusY;
		
		// leave room for scrollbar if we're in RTL and on the last column
		if (!lineStateLTR && getInfoLoop == infoListSize - 1) {
			textX -= global.scrollBarWidth;
		}
		
		// BG rect coordinates
		var cellRectX1 = textX_LTR - xBuffer;
		var cellRectY1 = rectY1;
		var cellRectX2 = cellRectX1 + colWidth;
		var cellRectY2 = rectY2;
		draw_set_color(highlight ? merge_color(global.colorThemeBG, global.colorThemeText, 0.15) : global.colorThemeBG);
		draw_set_alpha(1);
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		
		// draw text	
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_set_halign(lineStateLTR ? fa_left : fa_right);
		draw_set_valign(fa_middle);
		currentWordInfoCol[getInfoLoop] = scr_adaptFont(currentWordInfoCol[getInfoLoop], "S");
		draw_text(textX - clipX + 2, textY - clipY + scrollPlusY, currentWordInfoCol[getInfoLoop]);
					
		var scrollBarBuffer = 0;				
		if (getInfoLoop >= 7) {
			scrollBarBuffer = global.scrollBarWidth;
		}
		
		// dropDown button coordinates
		var dropDownRectX1 = cellRectX2 - dropDownButtonWidth;
		if (getInfoLoop == infoListSize - 1) {
			dropDownRectX1 -= global.scrollBarWidth;
		}
		var dropDownRectY1 = mean(cellRectY1, cellRectY2) - (dropDownButtonHeight / 2);
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonWidth;
		var dropDownRectY2 = dropDownRectY1 + dropDownButtonHeight;
					
		if (getInfoLoop >= 2) {
			//draw tag selection
			var colIndex = -1;
			if (getInfoLoop >= 3) {
				colIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 3);
			}
			else {
				colIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 2);
			}
			var mapKey = ds_list_find_value(global.tokenImportColNameList, colIndex);
			var isTildaField = (string_char_at(string(mapKey), 1) == "~");
			

			if (drawDropDowns && !unitOrWordTagTokenView && ds_map_exists(global.tokenImportTagMap, mapKey) && !isTildaField) {
								
				var tagMapList = ds_map_find_value(global.tokenImportTagMap, mapKey);
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
				var mouseoverDropDown = point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2);
				
				if (mouseoverDropDown) {
									
					scr_createTooltip(mean(dropDownRectX1, dropDownRectX2), dropDownRectY2, "Change tag", obj_tooltip.arrowFaceUp);
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(dropDownRectX1- clipX, dropDownRectY1 - clipY , dropDownRectX2 - clipX, dropDownRectY2 - clipY, true);

					if (mouse_check_button_released(mb_left)) {
						with (obj_panelPane) {
							selectedColToken = getInfoLoop;
						}
								
						var dropDownOptionList = ds_list_create();
						if (getInfoLoop >= 3) {
							if (!is_undefined(dropDownOptionList) && !is_undefined(tagMapList)) {
								ds_list_copy(dropDownOptionList, tagMapList);
								obj_control.tokenImportColToChange = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 3);
								obj_control.tokenImportRowToChange = currentWordID - 1;
							}
						}
						else {
							if (!is_undefined(dropDownOptionList) && !is_undefined(tagMapList)) {
								ds_list_copy(dropDownOptionList, tagMapList);
								obj_control.tokenImportColToChange = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 2);
								obj_control.tokenImportRowToChange = currentWordID - 1;
							}
						}
							
						// create dropdown
						if (ds_list_size(dropDownOptionList) > 0) {
							var dropDownX = textX - xBuffer;
							var dropDownY = textY + scrollPlusY + (strHeight / 2);
							var dropDownInst = instance_create_depth(dropDownX, dropDownY , -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = global.optionListTypeTokenTagMap;
						}
					}
				}
			}
		}
		activeCols++;
	}
}