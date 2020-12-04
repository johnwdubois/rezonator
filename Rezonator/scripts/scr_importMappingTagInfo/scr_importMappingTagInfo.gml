function scr_importMappingTagInfo() {
	
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());

	var colAmount = global.tagInfoGridWidth - 2; // we subtract 2 so we don't show the level column or the error column
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);

	scr_windowCameraAdjust();
	
	var wordFieldCount = 0;
	var wordDelimiterEncountered = false;


	// Tag Info window
	var tagInfoWindowRectX1 = 40;
	var tagInfoWindowRectY1 = (camHeight / 2) - 100;
	var tagInfoWindowRectX2 = (camWidth) - 50;
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
	draw_set_font(global.fontMain);
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
			var level = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j);
			var currentError = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colError, j) and (level == global.levelToken or level == global.levelWord);
			var currentSpecialField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, j);
			
			if (i == 0 && level == global.levelWord) {
				wordFieldCount++;
			}
			if (currentSpecialField == "Word Delimiter") {
				wordDelimiterEncountered = true;
			}
		
			var cellRectX1 = colX;
			var cellRectY1 = plusY + scrollPlusY;
			var cellRectX2 = cellRectX1 + (windowWidth / colAmount);
			var cellRectY2 = cellRectY1 + rowHeight;

		
			if (point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth - global.scrollBarWidth, y + windowHeight)
			&& !instance_exists(obj_dropDown)) {
				if (!scrollBarHolding) {
					obj_importMapping.mouseoverRow = j;
					mouseoverAnyRow = true;
				}
			}
			if (obj_importMapping.mouseoverRow == j) {
				draw_set_color(global.colorThemeSelected1);
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
			else if (i == global.tagInfoGrid_colLevelSchema || i == global.tagInfoGrid_colLevelPredict) {
				
				// change displayed string of level
				if (currentCell == global.levelToken) {
					currentCell = "token";
				}
				else if (currentCell == global.levelUnit) {
					currentCell = "unit";
				}
				else if (currentCell == global.levelWord) {
					currentCell = "word";
				}
				else if (currentCell == global.levelDiscourse) {
					currentCell = "discourse";
				}
				else {
					currentCell = "";
				}
				
				// if this is the selected choice between Schema/Predicted, show the dropdown for adjusting the level
				if (i == obj_importMapping.levelEstimateColumnSelected) {
					// draw dropdown option for level column
					var dropDownButtonX1 = floor(colX + colWidth - 4 - buttonRectSize);
					var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
					var dropDownButtonX2 = dropDownButtonX1 + buttonRectSize;
					var dropDownButtonY2 = dropDownButtonY1 + buttonRectSize;
					var mouseoverDropDown = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2);
				
					if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
						scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, "Change Level", obj_tooltip.arrowFaceUp);
				
						draw_set_color(global.colorThemeBG);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, false);
				
						draw_set_color(global.colorThemeBorders);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
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
		
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, c_white, 1);
				}
			}
			else if (i == global.tagInfoGrid_colSpecialFields) {
			
				if (currentCell == "0") {
					currentCell = "";
				}
				
				// draw dropdown for special fields column
				var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j);
				if (currentLevel == global.levelToken || currentLevel == global.levelUnit || currentLevel == global.levelWord) {
			
					var dropDownButtonX1 = floor(colX + colWidth - 4 - global.scrollBarWidth - buttonRectSize);
					var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
					var dropDownButtonX2 = floor(dropDownButtonX1 + buttonRectSize);
					var dropDownButtonY2 = floor(dropDownButtonY1 + buttonRectSize);
					var mouseoverDropDown = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2);
				
					if (!instance_exists(obj_dropDown) && mouseoverDropDown) {
						scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, "Change Special Field", obj_tooltip.arrowFaceUp);
							
						draw_set_color(global.colorThemeBG);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, false);
						draw_set_color(global.colorThemeBorders);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				
						if (mouse_check_button_pressed(mb_left)) {
							obj_importMapping.inDropDown = true;
						}
						if (mouse_check_button_released(mb_left)) {
							obj_importMapping.colToChange = i;
							obj_importMapping.rowToChange = j;
					
							var dropDownOptionList = ds_list_create();
						
							if (ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j) == global.levelUnit) {
								ds_list_add(dropDownOptionList, "Speaker", "Unit Start", "Unit End", "Unit Delimiter", "Turn Delimiter", "Translation");
							}
							if (ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j) == global.levelToken) {
								ds_list_add(dropDownOptionList, "Display Token", "Transcript");
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
			
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, -1, 0, c_white, 1);
				}
			
			}

		
		
			draw_set_color(global.colorThemeText);
			draw_set_font(global.fontMain);
			draw_text(floor(colX + 5 - clipX), floor(plusY + (rowHeight / 2) + scrollPlusY - clipY), string(currentCell));

			plusY += rowHeight;
		}
	}


	if (obj_importMapping.rezInfoGridSelectedRow < 0) {
		obj_importMapping.rezInfoGridSelectedRow = -1;
	}






	// draw header for column
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, false);
	for (var i = 0; i < colAmount; i++) {
		var colWidth = windowWidth / colAmount;
		var colX = tagInfoWindowRectX1 + (colWidth * i);
		var headerStr = "";
		var showLevelRadioButton = false;
		
		if (i == global.tagInfoGrid_colMarker) {
			headerStr = "Marker";
		}
		else if (i == global.tagInfoGrid_colExample) {
			headerStr = "Example";
		}
		else if (i == global.tagInfoGrid_colLevel) {
			headerStr = "Level";
		}
		else if (i == global.tagInfoGrid_colLevelSchema) {
			headerStr = "Level (Schema)";
			showLevelRadioButton = true;
		}
		else if (i == global.tagInfoGrid_colLevelPredict) {
			headerStr = "Level (Predicted)";
			showLevelRadioButton = true;
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
			headerStr = "Special Fields";
		}
		
		// draw header text
		draw_set_font(global.fontMainBold);
		draw_set_color(global.colorThemeText);
		draw_text(floor(colX + 5 - clipX), floor(tagInfoWindowRectY1 + (rowHeight / 2) - clipY), headerStr);
	
		// draw column lines
		draw_set_color(global.colorThemeBorders);
		draw_line(colX - clipX, tagInfoWindowRectY1 - clipY, colX - clipX, tagInfoWindowRectY2 - clipY);
		
		// draw radio button for selecting level estimate
		if (showLevelRadioButton) {
			var levelRadioButtonRad = rowHeight * 0.35;
			var levelRadioButtonX = colX + colWidth - (levelRadioButtonRad * 1.5);
			var levelRadioButtonY = tagInfoWindowRectY1 + (rowHeight / 2);
			draw_set_color(global.colorThemeBorders);
			draw_circle(levelRadioButtonX - clipX, levelRadioButtonY - clipY, levelRadioButtonRad, true);
			
			// click on radio button to select it
			if (point_in_circle(mouse_x, mouse_y, levelRadioButtonX, levelRadioButtonY, levelRadioButtonRad)) {
				
				// mouseover radio button
				draw_set_color(global.colorThemeBorders);
				draw_set_alpha(0.5);
				draw_circle(levelRadioButtonX - clipX, levelRadioButtonY - clipY, levelRadioButtonRad * 0.8, false);
				draw_set_alpha(1);
				
				// click radio button
				if (mouse_check_button_released(mb_left)) {
					obj_importMapping.levelEstimateColumnSelected = i;
					with (obj_importMapping) {
						alarm[4] = 1;
					}
				}
			}
			
			// draw filled in radio button if this column is selected
			if (obj_importMapping.levelEstimateColumnSelected == i) {
				var filledLevelRadioButtonRad = levelRadioButtonRad * 0.85;
				draw_set_color(global.colorThemeBorders);
				draw_circle(levelRadioButtonX - clipX, levelRadioButtonY - clipY, filledLevelRadioButtonRad, false);
			}
		}
	}
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, true);
	
	
	// update levels from correct level column
	ds_grid_set_grid_region(global.tagInfoGrid, global.tagInfoGrid, obj_importMapping.levelEstimateColumnSelected, 0, obj_importMapping.levelEstimateColumnSelected, ds_grid_height(global.tagInfoGrid), global.tagInfoGrid_colLevel, 0);



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
	
	
	// throw an error if there are >1 word level fields, but user has not selected Word Delimiter
	obj_importMapping.canContinueWordDelimiter = (wordFieldCount <= 1 || wordDelimiterEncountered);
	if (wordFieldCount <= 1) {
		obj_importMapping.canContinueWord1to1 = true;
	}



	// if mouse is outside the window, or not on a row, then don't highlight a row
	if ((!point_in_rectangle(mouse_x, mouse_y, tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2 - global.scrollBarWidth, tagInfoWindowRectY2) && !instance_exists(obj_dropDown))
	|| scrollBarHolding || !mouseoverAnyRow) {
		obj_importMapping.mouseoverRow = -1;
	}




	// draw Tag Info window border
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2, tagInfoWindowRectY2, true);


}
