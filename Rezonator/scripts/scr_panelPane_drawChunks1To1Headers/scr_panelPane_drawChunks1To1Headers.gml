function scr_panelPane_drawChunks1To1Headers(fieldList) {
	
	if (!global.html5) scr_surfaceStart();
	
	var headerHeight = functionTabs_tabHeight;
	var textMarginLeft = 8;
	var fieldListSize = ds_list_size(fieldList);
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var colWidth = windowWidth / obj_panelPane.chunk1to1ColAmount;

	// Create the column headers
	for (var i = 0; i < fieldListSize; i++) {
		
		// header coordinates
		var headerRectX1 = x + (i * colWidth) + scrollHorPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		
		
		// get field name
		var currentField = string(fieldList[| i]);
		
		// BG & outline rects
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1 - clipX, headerRectY1 - clipY, headerRectX2 - clipX, headerRectY1 + headerHeight - clipY, false);
		
		
		draw_set_color(global.colorThemeBorders);
		if (i > 0 ) {
			draw_line(headerRectX1 - clipX, headerRectY1 - clipY, headerRectX1 - clipX, headerRectY2 - clipY);
		}
		// draw line to separate column headers from data

		draw_line(x - clipX, headerRectY2 - clipY, x + windowWidth - clipX, headerRectY2 - clipY);
		
		// draw header name
		draw_set_valign(fa_middle);
		scr_adaptFont(currentField, "M");
		
		// get header text coordinates
		draw_set_halign(fa_left);
		var headerTextX = floor(headerRectX1 + (textMarginLeft));
		if (!lineStateLTR) {
			draw_set_halign(fa_right);
			headerTextX = floor(headerRectX2 - (textMarginLeft * 2));
		}
		var headerTextY = floor(y + (headerHeight / 2));
		
		
		if (mouseoverColHeader) {
			scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, scr_get_translation("msg_change_field"), obj_tooltip.arrowFaceUp);
			
			// draw underline
			var underlineX1 = headerTextX;
			var underlineX2 = 0;
			if (lineStateLTR) {
				underlineX2 = headerTextX + string_width(currentField);
			}
			else {
				underlineX2 = headerTextX - string_width(currentField);
			}
			var underlineY = headerTextY + (headerHeight * 0.25);
			draw_set_color(global.colorThemeBorders);
			draw_line_width(underlineX1 - clipX, underlineY - clipY, underlineX2 - clipX, underlineY - clipY, 2);
			
			if (mouse_check_button_released(mb_left)) {
				
				with (obj_panelPane) {
					chosenCol = i;
				}
				obj_control.chunk1to1ChunkToChange = "";
				obj_control.chunk1to1FieldToChange = currentField;
				obj_control.selectFieldChunk = true;
				
				var dropDownOptionList = ds_list_create();
				ds_list_add(dropDownOptionList, "option_select-field");
				if (ds_list_size(obj_control.navChunkFieldList) > 1) ds_list_add(dropDownOptionList, "Hide column")
				if (ds_list_size(obj_control.navChunkFieldList) < ds_list_size(obj_control.chunkFieldList)) ds_list_add(dropDownOptionList, "Insert column");
				ds_list_add(dropDownOptionList, "option_create-new-field", "option_add-to-tag-set", "option-remove-tag-set");
				
				scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeFieldUnits1ToMany);
				scr_clearNavWindowTagging(false);
			}
		}
		
		
		// draw header text
		draw_set_color(global.colorThemeText);
		draw_text(headerTextX - clipX, headerTextY - clipY, currentField);
		
		// draw lines for dividing columns
		if (lineStateLTR) {	
			if (i > 0) {
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1 - clipX, y - clipY, headerRectX1 - clipX, y + windowHeight - clipY, 1);
			}
		}
		else {
			if (i > 0 && i < fieldListSize) {
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1 + 1 - clipX, y - clipY, headerRectX1 + 1 - clipX, y + windowHeight - clipY, 1);
			}
		}
	
	}
	
	if (!global.html5) scr_surfaceEnd();

}