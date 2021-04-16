// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawUnits1ToManyHeaders(){
	
	var headerList = obj_control.navTokenFieldList;
	var headerListSize = ds_list_size(headerList);
	var headerHeight = functionTabs_tabHeight;

	var plusX = x
	for (var i = 0; i < headerListSize; i++) {
		
		// get header coordinates
		var colWidth = windowWidth / ds_list_size(headerList);
		var headerRectX1 = plusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2);
		
		// get column name
		var colName = headerList[| i];
	
		// draw BG rects & lines to separate columns
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		if (i > 0) {
			draw_set_color(global.colorThemeBorders);
			draw_line(headerRectX1, headerRectY1 + headerHeight, headerRectX1, y + windowHeight);
			draw_set_color(global.colorThemeBorders);
			draw_line(headerRectX1, headerRectY1, headerRectX1, y + headerHeight);
		}

		// draw column header names
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		scr_adaptFont(colName, "M");
		draw_text(headerRectX1 + 8, floor(y + (headerHeight / 2)), colName);
	
		// draw displayToken button
		var displayTokenButtonSize = (headerHeight / 4);
		var displayTokenButtonX = headerRectX2 - displayTokenButtonSize - 4;
		var displayTokenButtonY = mean(headerRectY1, headerRectY2);
		var mouseoverDisplayToken = point_in_circle(mouse_x, mouse_y, displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize);
	
		// draw token selection button
		var dropDownButtonSize = sprite_get_width(spr_dropDown);
		var dropDownRectX1 = displayTokenButtonX - 16 - dropDownButtonSize;
		var dropDownRectY1 = headerRectY1 + (dropDownButtonSize * 0.25);
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonSize;
		var dropDownRectY2 = headerRectY2 - (dropDownButtonSize * 0.25);
		var mouseoverDropDownButton = point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2);
		
		// right clicking on header
		if (mouseoverHeader) {
			if (mouse_check_button_released(mb_right)) {
				with (obj_dropDown) {
					instance_destroy();
				}
				with(obj_panelPane) {
					chosenCol = i;
				}
				obj_control.tokenImportColToChange = ds_list_find_index(global.tokenImportColNameList, colName);
				var dropDownOptionList = ds_list_create();
				ds_list_add(dropDownOptionList, "Set as Transcription" , "Create Field", "Add new Tag");
				scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeTokenMarker);
			}
		}

		// user interaction for token selection
		if (mouseoverDropDownButton && !instance_exists(obj_dropDown)) {
			scr_createTooltip(mean(dropDownRectX1, dropDownRectX2), dropDownRectY2, "Change field", obj_tooltip.arrowFaceUp);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2, true);
			if (mouse_check_button_released(mb_left)) {
				with (obj_panelPane) {
					chosenCol = i;
				}

				var dropDownOptionList = ds_list_create();
				ds_list_copy(dropDownOptionList, global.tokenImportColNameList);
				scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeTokenSelection);
			}
		}
	
		// change display token
		if (mouseoverDisplayToken && !instance_exists(obj_dropDown)) {
				
			scr_createTooltip(displayTokenButtonX, displayTokenButtonY + displayTokenButtonSize, "Display token", obj_tooltip.arrowFaceUp);
			draw_set_color(global.colorThemeSelected1);
			draw_circle(displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize * 0.75, false);
			
			if (mouse_check_button_released(mb_left)) {
				obj_control.displayToken = i;
				global.displayTokenField = colName;
				
				// return to this later!
				/*
				var toggleTranscriptionGrid = -1;
				var toggleTranscriptionCol = -1;
				if (i == 0) {
					toggleTranscriptionGrid = obj_control.wordGrid;
					toggleTranscriptionCol = obj_control.wordGrid_colUtteranceID;
				}
				else if (i == 1) {
					toggleTranscriptionGrid = obj_control.wordGrid;
					toggleTranscriptionCol = obj_control.wordGrid_colWordSeq;
				}

				else if (i >= 2 && i < 7) {
					toggleTranscriptionGrid = global.tokenImportGrid;
					var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList,i-2)
					toggleTranscriptionCol =  colIndex;
				}
				scr_toggleTranscriptionMulti(toggleTranscriptionGrid, toggleTranscriptionCol);
				*/
				
			}
		}

		draw_set_color(global.colorThemeBorders);
		draw_circle(displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize, true);
		draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2), mean(dropDownRectY1, dropDownRectY2), 1, 1, 0, global.colorThemeText, 1);

		if (global.displayTokenField == colName) {
			draw_set_color(merge_color(global.colorThemeBorders, global.colorThemeBG, 0.1));
			draw_circle(displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize * 0.75, false);
			draw_set_color(global.colorThemeBorders);
		}
		else {
			draw_set_color(global.colorThemeText);
		}
		
		plusX += colWidth;
	}
	draw_set_alpha(1);
	
	
	// draw line to separate column headers from data
	draw_set_color(global.colorThemeBorders);
	draw_line(x, y + headerHeight, x + windowWidth, y + headerHeight);

}