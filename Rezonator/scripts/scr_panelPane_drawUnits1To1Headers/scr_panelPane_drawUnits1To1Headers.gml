function scr_panelPane_drawUnits1To1Headers(){
	
	if (!global.html5) scr_surfaceStart();
	
	var headerList = obj_control.navUnitFieldList;
	var headerListSize = ds_list_size(headerList);
	var headerHeight = functionTabs_tabHeight;
	var colWidth = windowWidth/obj_panelPane.unit1to1ColAmount;
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var textMarginLeft = 8;
	var plusX = x;
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	var mouseoverCancel = !point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight) || instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox);
	
	for (var i = 0; i < headerListSize; i++) {
		
		var currentField = headerList[| i];
		
		// get header coordinates
		var headerRectX1 = plusX + scrollHorPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		var headerTextX = headerRectX1 + (textMarginLeft*2) + dropDownButtonSize;
		if (!lineStateLTR) {
			headerTextX = headerRectX2 - (textMarginLeft) - dropDownButtonSize - (textMarginLeft * 2);
		}
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		
		// draw headers
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1 - clipX, headerRectY1 - clipY, headerRectX2 - clipX, headerRectY2 - clipY, false);
		
		// draw vertical lines dividing columns
		if(lineStateLTR){	
			if(i > 0){
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1 - clipX, headerRectY1 - clipY, headerRectX1 - clipX, y + windowHeight - clipY, 1);
			}
		}
		else{
			if(i < headerListSize){
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1 + 1 - clipX, headerRectY1 - clipY, headerRectX1 + 1 - clipX, y + windowHeight - clipY, 1);
			}
		}


		
		// draw displayUnit button
		var displayUnitButtonSize = (headerHeight / 4);
		var displayUnitButtonX = headerRectX1 + (displayUnitButtonSize) + (textMarginLeft);
		if (!lineStateLTR) {
			displayUnitButtonX = headerRectX2 - (displayUnitButtonSize) - (textMarginLeft);
		}
		var displayUnitButtonY = mean(headerRectY1, headerRectY2);
		var mouseoverDisplayUnit = point_in_circle(mouse_x, mouse_y, displayUnitButtonX, displayUnitButtonY, displayUnitButtonSize) && !mouseoverCancel;
		var mouseoverHeader = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !mouseoverDisplayUnit && !mouseoverCancel;
	
		
		// mouseover & click on header
		if (mouseoverHeader) {
			
			// draw underline
			var underlineX1 = headerTextX;
			if(lineStateLTR){
				var underlineX2 = headerTextX + string_width(currentField);
			}
			else{
				var underlineX2 = headerTextX - string_width(currentField);
			}
			var underlineY = headerTextY + (headerHeight * 0.25);
			draw_set_color(global.colorThemeBorders);
			draw_line_width(underlineX1 - clipX, underlineY - clipY, underlineX2 - clipX, underlineY - clipY, 2);
			scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, scr_get_translation("msg_change_field"), obj_tooltip.arrowFaceUp);
			
			if (mouse_check_button_released(mb_left)) {
				obj_control.unitToChange = "";
				obj_control.unitFieldToChange = currentField;
				with (obj_panelPane) {
					chosenCol = i;
				}
				
				var dropDownOptionList = ds_list_create();
				//localize
				ds_list_add(dropDownOptionList, "option_select-field", "Show in main screen", "Show in translation tab");
				//localize
				if (ds_list_size(obj_control.navUnitFieldList) > 1) ds_list_add(dropDownOptionList, "Hide column")
				if (ds_list_size(obj_control.navUnitFieldList) < ds_list_size(obj_control.unitFieldList)) ds_list_add(dropDownOptionList, "Insert column");
				ds_list_add(dropDownOptionList, "option_create-new-field", "option_add-to-tag-set", "option-remove-tag-set");
				scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeFieldUnits1To1);
				scr_clearNavWindowTagging(false);
			}
		}

		

	
		// change display unit (speaker)
		if (mouseoverDisplayUnit && !instance_exists(obj_dropDown)) {
				
			scr_createTooltip(displayUnitButtonX, displayUnitButtonY + displayUnitButtonSize, scr_get_translation("msg_display_unit"), obj_tooltip.arrowFaceUp);
			draw_set_color(global.colorThemeSelected1);
			draw_circle(displayUnitButtonX - clipX, displayUnitButtonY - clipY, displayUnitButtonSize * 0.75, false);
			
			if (mouse_check_button_released(mb_left)) {
				global.participantField = currentField;		
			}
		}
	
	
		// draw circle for display unit selection
		draw_set_color(global.colorThemeBorders);
		draw_circle(displayUnitButtonX - clipX, displayUnitButtonY - clipY, displayUnitButtonSize, true);
		if (global.participantField == currentField) {
			draw_set_color(merge_color(global.colorThemeBorders, global.colorThemeBG, 0.1));
			draw_circle(displayUnitButtonX - clipX, displayUnitButtonY - clipY, displayUnitButtonSize * 0.75, false);
			draw_set_color(global.colorThemeBorders);
		}

			    

		// draw header text
		scr_adaptFont(string(currentField), "M");
		draw_set_color(global.colorThemeText);
	

		draw_text(headerTextX - clipX, headerTextY - clipY, currentField);
	
		plusX += colWidth;
	}
	
	
	// draw horizontal line to separate column headers from data
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + headerHeight - clipY, true);
	
	if (!global.html5) scr_surfaceEnd();

}