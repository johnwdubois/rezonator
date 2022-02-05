function scr_panelPane_drawUnits1ToManyHeaders(){
	
	var headerList = obj_control.navTokenFieldList;
	var headerListSize = ds_list_size(headerList);
	var headerHeight = functionTabs_tabHeight;
	var textMarginLeft = 8;
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var colWidth = windowWidth / obj_panelPane.unit1toMColAmount;
	var plusX = x;
	var mouseoverCancel = !point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight) || instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox);
	
	scr_surfaceStart();
	
	
	for (var i = 0; i < headerListSize; i++) {
		
		// get header coordinates
		var headerRectX1 = plusX + scrollHorPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// get column name/current field
		var currentField = headerList[| i];
		
	
		// draw BG rects & lines to separate columns
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1- clipX, headerRectY1- clipY, headerRectX2- clipX, headerRectY2- clipY, false);
		if (i > 0) {
			draw_set_color(global.colorThemeBorders);
			draw_line(headerRectX1- clipX, headerRectY1 + headerHeight- clipY, headerRectX1- clipX, y + windowHeight - clipY);
			draw_set_color(global.colorThemeBorders);
			draw_line(headerRectX1- clipX, headerRectY1- clipY, headerRectX1- clipX, y + headerHeight - clipY);
		}
		// draw token selection button
		var dropDownButtonSize = sprite_get_width(spr_dropDown);
		// draw column header names
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		scr_adaptFont(currentField, "M");
		var headerTextX = floor(headerRectX1 + (textMarginLeft*2) + dropDownButtonSize);
		var headerTextY = floor(y + (headerHeight / 2));
		if (!lineStateLTR) {
			draw_set_halign(fa_right);
			headerTextX = headerRectX2 - (textMarginLeft) - dropDownButtonSize - (textMarginLeft * 2);
		}
		draw_text(headerTextX- clipX, headerTextY- clipY, currentField);
		draw_set_alpha(1);
		
		// draw displayToken button
		var displayTokenButtonSize = (headerHeight / 4);
		var displayTokenButtonX = headerRectX1 + (displayTokenButtonSize) + (textMarginLeft);
		if (!lineStateLTR) {
			displayTokenButtonX = headerRectX2 - (displayTokenButtonSize) - (textMarginLeft);
		}
		var displayTokenButtonY = mean(headerRectY1, headerRectY2);
		var mouseoverDisplayToken = point_in_circle(mouse_x, mouse_y, displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize) && !mouseoverCancel;
		var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !mouseoverDisplayToken && !mouseoverCancel;

		// user interaction for header click
		if (mouseoverHeader) {
			scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, scr_get_translation("msg_change_field"), obj_tooltip.arrowFaceUp);
			
			// draw underline
			var underlineX1 = headerTextX;
			var underlineX2 = 0;
			if(lineStateLTR){
				underlineX2 = headerTextX + string_width(currentField);
			}
			else{
				underlineX2 = headerTextX - string_width(currentField);
			}
			var underlineY = headerTextY + (headerHeight * 0.25);
			draw_set_color(global.colorThemeBorders);
			draw_line_width(underlineX1- clipX, underlineY- clipY, underlineX2- clipX, underlineY- clipY, 2);
			
			if (mouse_check_button_released(mb_left)) {
				with (obj_panelPane) {
					chosenCol = i;
				}
				
				obj_control.tokenToChange = "";
				obj_control.tokenFieldToChange = currentField;
				obj_control.selectFieldChunk = false;
				

				var dropDownOptionList = ds_list_create();
				ds_list_add(dropDownOptionList, "option_select-field", "Show in main screen", "option_create-new-field", "option_add-to-tag-set", "option-remove-tag-set");
				scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeFieldUnits1ToMany);
			}
		}
		
		// change display token
		if (mouseoverDisplayToken) {
				
			scr_createTooltip(displayTokenButtonX, displayTokenButtonY + displayTokenButtonSize, scr_get_translation("option_display-token"), obj_tooltip.arrowFaceUp);
			draw_set_color(global.colorThemeSelected1);
			draw_circle(displayTokenButtonX- clipX, displayTokenButtonY- clipY, displayTokenButtonSize * 0.75, false);
			
			if (mouse_check_button_released(mb_left)) {
				global.displayTokenField = currentField;
				scr_updateDisplayTokenList(currentField);
			}
		}

		draw_set_color(global.colorThemeBorders);
		draw_circle(displayTokenButtonX- clipX, displayTokenButtonY- clipY, displayTokenButtonSize, true);

		if (global.displayTokenField == currentField) {
			draw_set_color(merge_color(global.colorThemeBorders, global.colorThemeBG, 0.1));
			draw_circle(displayTokenButtonX- clipX, displayTokenButtonY- clipY, displayTokenButtonSize * 0.75, false);
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
	draw_line(x- clipX, y + headerHeight- clipY, x + windowWidth- clipX, y + headerHeight- clipY);
	
	scr_surfaceEnd();
	
}