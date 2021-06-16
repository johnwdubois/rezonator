// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChunks1To1Headers(fieldList){
	
	
	var headerHeight = functionTabs_tabHeight;
	var textMarginLeft = 8;
	var fieldListSize = ds_list_size(fieldList);
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);

	// Create the column headers
	for (var i = 0; i < fieldListSize; i++) {
		
		// header coordinates
		var headerRectX1 = x + (i * (windowWidth / fieldListSize));
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + (windowWidth / fieldListSize);
		var headerRectY2 = headerRectY1 + headerHeight;
		var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		
		// get field name
		var currentField = string(fieldList[| i]);
		
		// BG & outline rects
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + headerHeight, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + headerHeight, true);
		
		// draw line to separate column headers from data
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(x, headerRectY1, x + windowWidth, headerRectY2, true);
		
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
		
		draw_set_color(global.colorThemeText);
		draw_text(headerTextX, headerTextY, currentField);
		
		// draw lines for dividing columns
		if(lineStateLTR){	
			if(i > 0){
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1, y, headerRectX1, y + windowHeight, 1);
			}
		}
		else{
			if(i > 0 && i < fieldListSize){
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1 + 1, y, headerRectX1 + 1, y + windowHeight, 1);
			}
		}
		
		
		
	
	}

}