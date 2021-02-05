// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawLineContentsInnerLoop(currentWordID, drawDropDowns, strHeight, textPlusY){

	var xBuffer = 6;
	var tabHeight = functionChainList_tabHeight;
	var activeCols = 0;
	
	var infoListSize = 3;
	if (functionChainList_currentTab == functionChainList_tabLine) {
		infoListSize = tokenContentsHeaderListSize;
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
					
		
		var textX = 0;
		if (getInfoLoop == 0 or getInfoLoop == 1) {
			textX = x + (activeCols * (windowWidth / 12)) + xBuffer;
		}
		else {
			textX = x + (activeCols * (windowWidth / 6)) + xBuffer - (windowWidth / 6);
		}
		var textY = y + tabHeight + textPlusY;
			
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_set_valign(fa_middle);
		scr_adaptFont(currentWordInfoCol[getInfoLoop], "S");
		draw_text(textX - clipX + 2, textY - clipY + scrollPlusY, currentWordInfoCol[getInfoLoop]);
					
		var scrollBarBuffer = 0;				
		if (getInfoLoop >= 7) {
			scrollBarBuffer = global.scrollBarWidth;
		}

		var dropDownButtonSize = (tabHeight / 2);
		var dropDownButtonWidthSize = sprite_get_width(spr_dropDown);
		var dropDownRectX1 = textX + (windowWidth / 6) - 16 - scrollBarBuffer - dropDownButtonWidthSize;
		var dropDownRectY1 = textY - (strHeight / 2) + 5 + scrollPlusY;
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonWidthSize;
		var dropDownRectY2 = dropDownRectY1 + dropDownButtonSize;

					
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
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, c_white, 1);
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