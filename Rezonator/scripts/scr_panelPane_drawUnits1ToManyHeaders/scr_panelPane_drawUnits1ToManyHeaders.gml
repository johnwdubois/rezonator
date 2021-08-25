// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawUnits1ToManyHeaders(){
	
	var headerList = obj_control.navTokenFieldList;
	var headerListSize = ds_list_size(headerList);
	var headerHeight = functionTabs_tabHeight;
	var textMarginLeft = 8;
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var colWidth = windowWidth / ds_list_size(headerList);
	var plusX = x;
	for (var i = 0; i < headerListSize; i++) {
		
		// get header coordinates
		var headerRectX1 = plusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// get column name/current field
		var currentField = headerList[| i];
	
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
		draw_text(headerTextX, headerTextY, currentField);
	
		// draw displayToken button
		var displayTokenButtonSize = (headerHeight / 4);
		var displayTokenButtonX = headerRectX1 + (displayTokenButtonSize) + (textMarginLeft);
		if (!lineStateLTR) {
			displayTokenButtonX = headerRectX2 - (displayTokenButtonSize) - (textMarginLeft);
		}
		var displayTokenButtonY = mean(headerRectY1, headerRectY2);
		var mouseoverDisplayToken = point_in_circle(mouse_x, mouse_y, displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize) && !instance_exists(obj_dropDown);
		var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !mouseoverDisplayToken && !instance_exists(obj_dropDown);

		// user interaction for header click
		if (mouseoverHeader) {
			scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, "Change field", obj_tooltip.arrowFaceUp);
			
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
			draw_line_width(underlineX1, underlineY, underlineX2, underlineY, 2);
			
			if (mouse_check_button_released(mb_left)) {
				with (obj_panelPane) {
					chosenCol = i;
				}
				obj_control.tokenFieldToChange = currentField;
				obj_control.selectFieldChunk = false;

				var dropDownOptionList = ds_list_create();
				ds_list_add(dropDownOptionList, "Add to tag set", "Remove from tag set", "Show in main screen", "Select field", "Create new field");
				scr_createDropDown(headerRectX1, headerRectY2, dropDownOptionList, global.optionListTypeFieldUnits1ToMany);
			}
		}
		
		// change display token
		if (mouseoverDisplayToken) {
				
			scr_createTooltip(displayTokenButtonX, displayTokenButtonY + displayTokenButtonSize, "Display token", obj_tooltip.arrowFaceUp);
			draw_set_color(global.colorThemeSelected1);
			draw_circle(displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize * 0.75, false);
			
			if (mouse_check_button_released(mb_left)) {
				global.displayTokenField = currentField;
				scr_updateDisplayTokenList(currentField);
			}
		}

		draw_set_color(global.colorThemeBorders);
		draw_circle(displayTokenButtonX, displayTokenButtonY, displayTokenButtonSize, true);

		if (global.displayTokenField == currentField) {
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