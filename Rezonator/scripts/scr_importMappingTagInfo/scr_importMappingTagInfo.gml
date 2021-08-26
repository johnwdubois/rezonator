function scr_importMappingTagInfo() {
	
	
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());

	var colAmount = ds_list_size(importFieldsColRatioList);
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);

	scr_windowCameraAdjust();
	
	var wordFieldCount = 0;
	var wordDelimiterEncountered = false;


	// Tag Info window
	tagInfoWindowRectX1 = 40;
	tagInfoWindowRectY1 = (camHeight / 2) - 100;
	tagInfoWindowRectX2 = (camWidth * 0.5) - 40;
	tagInfoWindowRectY2 = camHeight - 150;

	windowWidth = max(tagInfoWindowRectX2 - tagInfoWindowRectX1, 48);
	windowHeight = max(tagInfoWindowRectY2 - tagInfoWindowRectY1, 48);
	clipWidth = windowWidth;
	clipHeight = windowHeight;

	rowHeight = string_height("A") * 1.6;
	var colWidth = windowWidth / colAmount;
	var clickableRectBuffer = floor(rowHeight * 0.11);
	
	windowX = x;
	windowY = y;
	clipX = x;
	clipY = y;

	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}

	scr_windowCameraAdjust();

	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);




	x = tagInfoWindowRectX1;
	y = tagInfoWindowRectY1;
	
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, tagInfoWindowRectX2, y + rowHeight);



	var buttonRectSize = rowHeight - 10;
	var mouseoverAnyRow = false;
	var fieldXBuffer = string_width("   ");
	
	var plusX = 40;
	
	var underlineX1 = 0;
	var underlineX2 = 0;
	var underlineY = 0;



	// Draw Tag Info window contents

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	for (var i = 0; i < colAmount; i++) {
		
		var colWidth = windowWidth * (importFieldsColRatioList[| i] / 100);
		var colX = plusX;
		var plusY = tagInfoWindowRectY1 + rowHeight;
		
		
		var cellRectX1 = colX;
		var cellRectX2 = colX + colWidth;
		
		draw_set_color(global.colorThemeBG);
		draw_rectangle(cellRectX1 - clipX, tagInfoWindowRectY1 - clipY, cellRectX2 - clipX, tagInfoWindowRectY2 - clipY, false);
		
		
		
		for (var j = 0; j < tagInfoGridHeight; j++) {
			
			// check if this is the blockSeq or blockID, if so
			// don't show the row for this field
			var currentMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, j);
			if (currentMarker == "~blockID" || currentMarker == "~blockSeq") {
				continue;
			}
			var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j);
			var currentError = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colError, j) and (currentLevel == global.levelToken or currentLevel == global.levelWord or currentLevel == global.levelUnit);
			var currentSpecialField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, j);
			var currentKey = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colKey, j);
			
			var currentCellSelected = (obj_importMapping.colToChange == i && obj_importMapping.rowToChange == j && instance_exists(obj_dropDown));
			
			
			if (i == 0 && currentLevel == global.levelWord) {
				wordFieldCount++;
			}
			if (currentKey == "option_word-delimiter") {
				wordDelimiterEncountered = true;
			}
		
			
			var cellRectY1 = plusY + scrollPlusY;
			var cellRectY2 = cellRectY1 + rowHeight;
			
			// get coordinates for clickable cell
			var cellRectClickableX1 = cellRectX1 + clickableRectBuffer;
			var cellRectClickableY1 = cellRectY1 + clickableRectBuffer;
			var cellRectClickableX2 = cellRectX2 - clickableRectBuffer;
			var cellRectClickableY2 = cellRectY2 - clickableRectBuffer;
			var mouseoverDropDown = (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectClickableX1, cellRectClickableY1, cellRectClickableX2, cellRectClickableY2) && !instance_exists(obj_dropDown)) || currentCellSelected;
			if (mouseoverHeaderRegion) mouseoverDropDown = false;
			var drawDropDown = false;
			
			
			// get color for clickable rect
			var cellRectClickableColor = make_color_rgb(229, 191, 191);
			if (currentLevel == global.levelToken) cellRectClickableColor = make_color_rgb(161, 210, 166);
			else if (currentLevel == global.levelWord) cellRectClickableColor = make_color_rgb(205, 210, 161);
			else if (currentLevel == global.levelUnit) cellRectClickableColor = make_color_rgb(155, 214, 217);
			else if (currentLevel == global.levelDiscourse) cellRectClickableColor = make_color_rgb(223, 205, 243);
			
			
			// check for mouseover
			if (point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth - global.scrollBarWidth, y + windowHeight)
			&& !instance_exists(obj_dropDown)) {
				if (!scrollBarHolding) {
					obj_importMapping.mouseoverRow = j;
					mouseoverAnyRow = true;
				}
			}
			

			
	
		
		
			var currentCell = ds_grid_get(global.tagInfoGrid, i, j);
		
			if (i == global.tagInfoGrid_colMarkerPercent) {
				if (currentCell >= 99 && currentCell < 100) {
					currentCell = 99;
				}
				currentCell = string(max(round(currentCell), 1)) + "%";
			}
			else if (i == global.tagInfoGrid_colSingleTokenMarker) {
				currentCell = (currentCell) ? "Yes" : "";
			}
			else if (i == global.tagInfoGrid_colLevel) {
				
				drawDropDown = true;
				
				// draw the clickable rect for currentLevel column
				var cellColor = cellRectClickableColor;
				if (drawDropDown) cellColor = mouseoverDropDown ? merge_color(cellRectClickableColor, c_white, 0.25) : cellRectClickableColor;
				draw_set_color(cellColor);
				draw_roundrect(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, false);
				
				// draw border if this cell is clicked in
				if (currentCellSelected) {
					draw_set_color(global.colorThemeBorders);
					scr_drawRectWidth(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, 2, true);
				}
				
					
				// draw dropdown option for currentLevel column
				var dropDownButtonX1 = floor(colX + colWidth - 4 - buttonRectSize);
				var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
				var dropDownButtonX2 = dropDownButtonX1 + buttonRectSize;
				var dropDownButtonY2 = dropDownButtonY1 + buttonRectSize;
			
					
				
				if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
					scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, scr_get_translation("option_change-level"), obj_tooltip.arrowFaceUp);

					mouseOverLevel = true;
					if (mouse_check_button_pressed(mb_left)) {
						obj_importMapping.inDropDown = true;
					}
					if (mouse_check_button_released(mb_left)) {
						obj_importMapping.colToChange = i;
						obj_importMapping.rowToChange = j;
					
						var dropDownOptionList = ds_list_create();
						if (global.importType == global.importType_IGT) {
							ds_list_add(dropDownOptionList, "option_token", "Word", "Unit", "option_doc", "EXCEPTION");
						}
						else {
							ds_list_add(dropDownOptionList, "option_token", "Unit", "option_doc", "EXCEPTION");
						}
						if (ds_list_size(dropDownOptionList) > 0) {
							scr_createDropDown(colX, floor(plusY + rowHeight  + scrollPlusY), dropDownOptionList, global.optionListTypeMappingTag);
						}
					}
				}
				else {
					mouseOverLevel = false;
				}
		
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, global.colorThemeText, 1);



			}
			else if (i == global.tagInfoGrid_colKey) {
				
				// determine if dropdown should be drawn for this key cell
				drawDropDown = true;
				if (currentLevel == global.levelUnit) {
					drawDropDown = false;
					if (global.importType == global.importType_CSV or global.importType == global.importType_CoNLLU or global.importType == global.importType_TabDelimited) {
						drawDropDown = true;
					}
				}
				else if (currentLevel == global.levelWord) {
					drawDropDown = false;
					if (global.importType == global.importType_IGT) {
						drawDropDown = true;
					}
				}
				else if (currentLevel == global.levelToken) {
					drawDropDown = true;
				}
				
				
				// draw the clickable rect for currentLevel column
				var cellColor = cellRectClickableColor;
				if (drawDropDown) cellColor = mouseoverDropDown ? merge_color(cellRectClickableColor, c_white, 0.25) : cellRectClickableColor;
				draw_set_color(cellColor);
				draw_roundrect(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, false);
				
				// draw border if this cell is clicked in
				if (currentCellSelected) {
					draw_set_color(global.colorThemeBorders);
					scr_drawRectWidth(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, 2, true);
				}
				
				// remove 0s from column
				if (currentCell == "0" || currentCell == 0) {
					currentCell = "";
				}
				


				
				if (drawDropDown) {
					
					// if this field has a currentLevel with a delimiter, we draw a dropdown
					if ((currentLevel == global.levelToken || currentLevel == global.levelUnit || currentLevel == global.levelWord)) {
						var dropDownButtonX1 = floor(colX + colWidth - 4 - global.scrollBarWidth - buttonRectSize);
						var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
						var dropDownButtonX2 = floor(dropDownButtonX1 + buttonRectSize);
						var dropDownButtonY2 = floor(dropDownButtonY1 + buttonRectSize);
					
						draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, -1, 0, global.colorThemeText, 1);
					}
					
					if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
						scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, scr_get_translation("option_change-key"), obj_tooltip.arrowFaceUp);
				
						if (mouse_check_button_pressed(mb_left)) {
							obj_importMapping.inDropDown = true;
						}
						if (mouse_check_button_released(mb_left)) {
							obj_importMapping.colToChange = i;
							obj_importMapping.rowToChange = j;
					
							var dropDownOptionList = ds_list_create();
						
							if (currentLevel == global.levelUnit) {
								if(global.importType == global.importType_TabDelimited){
									ds_list_add(dropDownOptionList, "Unit Start", "Unit End");
								}
								else{
									ds_list_add(dropDownOptionList, "Unit Delimiter");
								}
							}
							else if (currentLevel == global.levelToken) {
								ds_list_add(dropDownOptionList, "option_display-token");
							}
							else if (currentLevel == global.levelWord) {
								ds_list_add(dropDownOptionList, "option_word-delimiter");
							}
							if (ds_list_size(dropDownOptionList) > 0) {
								scr_createDropDown(colX, floor(plusY + rowHeight  + scrollPlusY), dropDownOptionList, global.optionListTypeSpecialFields);
							}
						}
					}
				}

			}
			else if (i == global.tagInfoGrid_colSpecialFields) {
				
				drawDropDown = (currentLevel == global.levelToken || currentLevel == global.levelUnit);
				
				// draw the clickable rect for currentLevel column
				var cellColor = cellRectClickableColor;
				if (drawDropDown) cellColor = mouseoverDropDown ? merge_color(cellRectClickableColor, c_white, 0.25) : cellRectClickableColor;
				draw_set_color(cellColor);
				draw_roundrect(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, false);
				
				// draw border if this cell is clicked in
				if (currentCellSelected) {
					draw_set_color(global.colorThemeBorders);
					scr_drawRectWidth(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, 2, true);
				}
				
			
				if (currentCell == "0") {
					currentCell = "";
				}
				
				// draw dropdown for special fields column
				if (drawDropDown) {
			
					var dropDownButtonX1 = floor(colX + colWidth - 4 - global.scrollBarWidth - buttonRectSize);
					var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
					var dropDownButtonX2 = floor(dropDownButtonX1 + buttonRectSize);
					var dropDownButtonY2 = floor(dropDownButtonY1 + buttonRectSize);
				
					if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
						scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, scr_get_translation("option_change-special-field"), obj_tooltip.arrowFaceUp);
							
				
						if (mouse_check_button_pressed(mb_left)) {
							obj_importMapping.inDropDown = true;
						}
						if (mouse_check_button_released(mb_left)) {
							obj_importMapping.colToChange = i;
							obj_importMapping.rowToChange = j;
					
							var dropDownOptionList = ds_list_create();
						
							if (currentLevel == global.levelUnit) {
								ds_list_add(dropDownOptionList, "Speaker", "Turn Delimiter", "option_translation");
								if (global.importType != global.importType_TabDelimited) {
									ds_list_add(dropDownOptionList, "Unit Start", "Unit End");
								}
							}
							if (currentLevel == global.levelToken) {
								ds_list_add(dropDownOptionList, "Transcript");
							}
							if (currentLevel == global.levelWord) {
								ds_list_add(dropDownOptionList, "option_word-delimiter");
							}
							if (ds_list_size(dropDownOptionList) > 0) {
								scr_createDropDown(colX, floor(plusY + rowHeight  + scrollPlusY), dropDownOptionList, global.optionListTypeSpecialFields);
							}
						}
					}
			
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, -1, 0, global.colorThemeText, 1);
				}
			}
			
			
			
			var currentCellStr = string(currentCell);
			var textX = (i == 0) ? floor(colX + fieldXBuffer) : floor(mean(cellRectX1, cellRectX2));
			var textY = floor(plusY + (rowHeight / 2) + scrollPlusY);
			draw_set_halign((i == 0) ? fa_left : fa_center);
			
			// draw line dividing each row
			if (i == colAmount - 1 && j < tagInfoGridHeight - 1) {
				draw_set_color(global.colorThemeSelected1);
				draw_line(x + fieldXBuffer - clipX, floor(textY + (rowHeight * 0.5)) - clipY, tagInfoWindowRectX2 - fieldXBuffer - clipX, floor(textY + (rowHeight * 0.5)) - clipY);
			}
			
			// mouseover & click on row
			if (obj_importMapping.mouseoverRow == j) {
				if (i == 0) {
					underlineX1 = textX;
					underlineX2 = textX + string_width(currentCellStr);
					underlineY = cellRectY2;
					if (mouse_check_button_released(mb_left)) {
						fieldSelected = currentMarker;
						show_debug_message("fieldSelected: " + string(fieldSelected));
					}
				}
				else if (i == colAmount - 1) {
					draw_set_color(global.colorThemeBorders);
					draw_line_width(underlineX1 - clipX, underlineY  - clipY, underlineX2 - clipX, underlineY - clipY, 3);
				}
			}
			
			
			
			// selected pink line
			if (i == 0) {
				if (fieldSelected == currentMarker) {
					draw_set_color(global.colorThemeRezPink);
					draw_line_width(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX1 - clipX, cellRectY2 - clipY, 10);
				}
			}

			// draw text for this cell
			if (i != global.tagInfoGrid_colError) {
				draw_set_color(global.colorThemeText);
				draw_text(textX - clipX, floor(textY - clipY), scr_get_translation(currentCellStr));
			}
			else {
				if (currentError) {
					draw_set_color(c_red);
					draw_circle(textX - clipX, floor(plusY + (rowHeight / 2) + scrollPlusY - clipY),string_height("!")/2.2, false);
					draw_set_color(global.colorThemeBG);
					draw_text(textX - clipX, textY - clipY, "!");
				}
			}
			
			
		
			plusY += rowHeight;
		}
		
		plusX += colWidth;
	}







	// draw header for column
	plusX = 40;
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, false);
	for (var i = 0; i < colAmount; i++) {
		
		var colWidth = windowWidth * (importFieldsColRatioList[| i] / 100);
		var colX1 = plusX;
		var colX2 = colX1 + colWidth;
		var headerStr = "";
		
		
		if (i == global.tagInfoGrid_colMarker) {
			headerStr = "Mark";
		}
		else if (i == global.tagInfoGrid_colLevel) {
			headerStr = "Level";
		}
		else if (i == global.tagInfoGrid_colLevelSchema) {
			headerStr = "Level (Schema)";
		}
		else if (i == global.tagInfoGrid_colLevelPredict) {
			headerStr = "Level (Predicted)";
		}
		else if (i == global.tagInfoGrid_colMarkerPercent) {
			headerStr = "Marker %";
		}
		else if (i == global.tagInfoGrid_colSingleTokenMarker) {
			headerStr = "Single Token";
		}
		else if (i == global.tagInfoGrid_colTokenCount) {
			headerStr = "Token Count";
		}
		else if (i == global.tagInfoGrid_colSpecialFields) {
			headerStr = "Special";
		}
		else if (i == global.tagInfoGrid_colKey) {
			headerStr = "Key";
		}
		
		// draw header text
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_center);
		scr_adaptFont(headerStr, "L");
		draw_text(floor(mean(colX1, colX2)) - clipX, floor(tagInfoWindowRectY1 + (rowHeight / 2) - clipY), headerStr);
	
	
	
		plusX += colWidth;
	}
	
	draw_set_color(global.colorThemeSelected2);
	draw_line_width(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, 2);
	
	

	// mousewheel input
	if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (mouse_wheel_up()) {
			scrollPlusYDest += 8;
		}
		if (mouse_wheel_down()) {
			scrollPlusYDest -= 8;
		}
	}

	scr_scrollBar(ds_grid_height(global.tagInfoGrid), -1, rowHeight, rowHeight,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, (tagInfoWindowRectX2 - tagInfoWindowRectX1), (tagInfoWindowRectY2 - tagInfoWindowRectY1));
	
	scrollPlusY = min(scrollPlusY, 0);



	scr_surfaceEnd();
	
	
	// throw an error if there are >1 word currentLevel fields, but user has not selected Word Delimiter
	obj_importMapping.canContinueWordDelimiter = (wordFieldCount <= 1 || wordDelimiterEncountered);
	if (wordFieldCount <= 1) {
		obj_importMapping.canContinueWord1to1 = true;
	}



	// if mouse is outside the window, or not on a row, then don't highlight a row
	if ((!point_in_rectangle(mouse_x, mouse_y, tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2 - global.scrollBarWidth, tagInfoWindowRectY2) && !instance_exists(obj_dropDown))
	|| scrollBarHolding || !mouseoverAnyRow) {
		obj_importMapping.mouseoverRow = -1;
	}




	

}
