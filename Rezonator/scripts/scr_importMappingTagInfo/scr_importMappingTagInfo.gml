function scr_importMappingTagInfo() {
	

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());

	var colAmount = global.tagInfoGrid_colSpecialFields + 1; // we subtract 2 so we don't show the currentLevel column or the error column
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);

	scr_windowCameraAdjust();
	
	var wordFieldCount = 0;
	var wordDelimiterEncountered = false;


	// Tag Info window
	var tagInfoWindowRectX1 = 40;
	var tagInfoWindowRectY1 = (camHeight / 2) - 100;
	var tagInfoWindowRectX2 = (camWidth * 0.5) - 40;
	var tagInfoWindowRectY2 = camHeight - 150;

	windowWidth = max(tagInfoWindowRectX2 - tagInfoWindowRectX1, 48);
	windowHeight = max(tagInfoWindowRectY2 - tagInfoWindowRectY1, 48);
	clipWidth = windowWidth;
	clipHeight = windowHeight;

	var rowHeight = string_height("A") * 1.3;
	var colWidth = windowWidth / colAmount;
	
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



	var buttonRectSize = rowHeight - 10;
	var mouseoverAnyRow = false;



	// Draw Tag Info window contents

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	for (var i = 0; i < colAmount; i++) {
		var colX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * i);
		var plusY = tagInfoWindowRectY1 + rowHeight;
	
		var realNextColX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * (i + 1));
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colX - clipX, tagInfoWindowRectY1 - clipY, realNextColX - clipX, tagInfoWindowRectY2 - clipY, false);
		
		for (var j = 0; j < tagInfoGridHeight; j++) {
			
			// check if this is the blockSeq or blockID, if so
			// don't show the row for this field
			var currentMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, j);
			if (currentMarker == "~blockID" || currentMarker == "~blockSeq") {
				continue;
			}
			var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j);
			var currentError = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colError, j) and (currentLevel == global.levelToken or currentLevel == global.levelWord);
			var currentSpecialField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, j);
			var currentKey = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colKey, j);
			
			if (i == 0 && currentLevel == global.levelWord) {
				wordFieldCount++;
			}
			if (currentKey == "Word Delimiter") {
				wordDelimiterEncountered = true;
			}
		
			var cellRectX1 = colX;
			var cellRectY1 = plusY + scrollPlusY;
			var cellRectX2 = cellRectX1 + (windowWidth / colAmount);
			var cellRectY2 = cellRectY1 + rowHeight;
			

			var cellRectClickableX1 = cellRectX1 + 4;
			var cellRectClickableY1 = cellRectY1 + 4;
			var cellRectClickableX2 = cellRectX2 - 4;
			var cellRectClickableY2 = cellRectY2 - 4;
			var mouseoverDropDown = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectClickableX1, cellRectClickableY1, cellRectClickableX2, cellRectClickableY2);
			
			
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
			if (obj_importMapping.mouseoverRow == j) {
				draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
				draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
			}
			
			if (currentError) {
				draw_set_color(c_red);
				draw_set_alpha(.5);
				draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
				draw_set_alpha(1);
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
				
				
				// draw the clickable rect for currentLevel column
				draw_set_color(mouseoverDropDown ? merge_color(cellRectClickableColor, c_white, 0.25) : cellRectClickableColor);
				draw_roundrect(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, false);
				
					
				// draw dropdown option for currentLevel column
				var dropDownButtonX1 = floor(colX + colWidth - 4 - buttonRectSize);
				var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
				var dropDownButtonX2 = dropDownButtonX1 + buttonRectSize;
				var dropDownButtonY2 = dropDownButtonY1 + buttonRectSize;
			
					
				
				if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
					scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, "Change currentLevel", obj_tooltip.arrowFaceUp);

					mouseOverLevel = true;
					if (mouse_check_button_pressed(mb_left)) {
						obj_importMapping.inDropDown = true;
					}
					if (mouse_check_button_released(mb_left)) {
						obj_importMapping.colToChange = i;
						obj_importMapping.rowToChange = j;
					
						var dropDownOptionList = ds_list_create();
						if (global.importType == global.importType_IGT) {
							ds_list_add(dropDownOptionList, "Token", "Word", "Unit", "Discourse", "EXCEPTION");
						}
						else {
							ds_list_add(dropDownOptionList, "Token", "Unit", "Discourse", "EXCEPTION");
						}
						if (ds_list_size(dropDownOptionList) > 0) {
							var dropDownInst = instance_create_depth(colX, floor(plusY + rowHeight  + scrollPlusY), -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = global.optionListTypeMappingTag;
						}
					}
				}
				else {
					mouseOverLevel = false;
				}
		
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, global.colorThemeText, 1);



			}
			else if (i == global.tagInfoGrid_colKey) {
				
				// draw the clickable rect for currentLevel column
				draw_set_color(mouseoverDropDown ? merge_color(cellRectClickableColor, c_white, 0.25) : cellRectClickableColor);
				draw_roundrect(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, false);
				
				// remove 0s from column
				if (currentCell == "0" || currentCell == 0) {
					currentCell = "";
				}
				

				
				var drawDropDown = true;
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
				if(drawDropDown){
					
					// if this field has a currentLevel with a delimiter, we draw a dropdown
					if ((currentLevel == global.levelToken || currentLevel == global.levelUnit || currentLevel == global.levelWord)) {
						var dropDownButtonX1 = floor(colX + colWidth - 4 - global.scrollBarWidth - buttonRectSize);
						var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
						var dropDownButtonX2 = floor(dropDownButtonX1 + buttonRectSize);
						var dropDownButtonY2 = floor(dropDownButtonY1 + buttonRectSize);
					
						draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, -1, 0, global.colorThemeText, 1);
					}
					
					if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
						scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, "Change Key", obj_tooltip.arrowFaceUp);
				
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
								ds_list_add(dropDownOptionList, "Display Token");
							}
							else if (currentLevel == global.levelWord) {
								ds_list_add(dropDownOptionList, "Word Delimiter");
							}
							if (ds_list_size(dropDownOptionList) > 0) {
								var dropDownInst = instance_create_depth(colX, floor(plusY + rowHeight  + scrollPlusY) , -999, obj_dropDown);
								dropDownInst.optionList = dropDownOptionList;
								dropDownInst.optionListType = global.optionListTypeSpecialFields;
							}
						}
					}
				}

			}
			else if (i == global.tagInfoGrid_colSpecialFields) {
				
				// draw the clickable rect for currentLevel column
				draw_set_color(mouseoverDropDown ? merge_color(cellRectClickableColor, c_white, 0.25) : cellRectClickableColor);
				draw_roundrect(cellRectClickableX1 - clipX, cellRectClickableY1 - clipY, cellRectClickableX2 - clipX, cellRectClickableY2 - clipY, false);
				
			
				if (currentCell == "0") {
					currentCell = "";
				}
				
				// draw dropdown for special fields column
				if (currentLevel == global.levelToken || currentLevel == global.levelUnit) {
			
					var dropDownButtonX1 = floor(colX + colWidth - 4 - global.scrollBarWidth - buttonRectSize);
					var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
					var dropDownButtonX2 = floor(dropDownButtonX1 + buttonRectSize);
					var dropDownButtonY2 = floor(dropDownButtonY1 + buttonRectSize);
				
					if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
						scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, "Change Special Field", obj_tooltip.arrowFaceUp);
							
				
						if (mouse_check_button_pressed(mb_left)) {
							obj_importMapping.inDropDown = true;
						}
						if (mouse_check_button_released(mb_left)) {
							obj_importMapping.colToChange = i;
							obj_importMapping.rowToChange = j;
					
							var dropDownOptionList = ds_list_create();
						
							if (ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j) == global.levelUnit) {
								ds_list_add(dropDownOptionList, "Speaker", "Turn Delimiter", "Translation");
								if(global.importType != global.importType_Transcription){
									ds_list_add(dropDownOptionList, "Unit Start", "Unit End");
								}
							}
							if (ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j) == global.levelToken) {
								ds_list_add(dropDownOptionList, "Transcript");
							}
							if (ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j) == global.levelWord) {
								ds_list_add(dropDownOptionList, "Word Delimiter");
							}
							if (ds_list_size(dropDownOptionList) > 0) {
								var dropDownInst = instance_create_depth(colX, floor(plusY + rowHeight  + scrollPlusY) , -999, obj_dropDown);
								dropDownInst.optionList = dropDownOptionList;
								dropDownInst.optionListType = global.optionListTypeSpecialFields;
							}
						}
					}
			
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, -1, 0, global.colorThemeText, 1);
				}
			
			}

		
		
			draw_set_color(global.colorThemeText);
			scr_adaptFont(string(currentCell), "M");
			draw_text(floor(colX + 5 - clipX), floor(plusY + (rowHeight / 2) + scrollPlusY - clipY), string(currentCell));

			plusY += rowHeight;
		}
	}







	// draw header for column
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, false);
	for (var i = 0; i < colAmount; i++) {
		var colWidth = windowWidth / colAmount;
		var colX = tagInfoWindowRectX1 + (colWidth * i);
		var headerStr = "";
		
		if (i == global.tagInfoGrid_colMarker) {
			headerStr = "Marker";
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
		scr_adaptFont(headerStr, "L");
		draw_text(floor(colX + 5 - clipX), floor(tagInfoWindowRectY1 + (rowHeight / 2) - clipY), headerStr);
	
		
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
