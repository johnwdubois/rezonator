// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawSearchList(){

		
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.3;
	var startColX = nameColX + nameColWidth;
	
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var textAdjustY = 0;
	var drawScrollbar = true;
	
	var anyOptionMousedOver = false;
	var mouseoverScrollBar = (drawScrollbar) ? point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight) : false;
	
	
	
	// draw column headers
	var headerPlusX = 0;
	for (var i = 0; i < 3; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = nameColWidth;
			colText = "Name";
		}
		else if (i == 2) {
			colWidth = windowWidth - startColX;
			colText = "Searched Words";
		}
		
		// get header coordinates
		var headerRectX1 = x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// draw header rects
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, true);
		
		// draw header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		draw_text(headerTextX, headerTextY, colText);
		

		
		
		headerPlusX += colWidth;
	}
	

}