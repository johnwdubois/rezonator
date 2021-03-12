// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawShowList(){
	
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.7;
	var startColX = nameColX + nameColWidth;
	
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var textAdjustY = 0;
	var drawScrollbar = true;
	var mouseoverScrollBar = (drawScrollbar) ? point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight) : false;
	
	// get the instance ID for the showContents pane so we can easily reference it
	var chainContentsPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			chainContentsPanelPaneInst = self.id;
		}
	}
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : chainContentsPanelPaneInst.scrollPlusY;
	
	
	// get the show list & make sure it exists
	var showList = ds_map_find_value(global.nodeMap, "showList");
	if (!is_numeric(showList)) {
		show_debug_message("non numer")
		exit;
	}
	if (!ds_exists(showList, ds_type_list)) exit;
	var showListSize = ds_list_size(showList);
	
	scr_surfaceStart();
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	
	// loop over shows
	for (var i = 0; i < showListSize; i++) {
		
		// get data for currentShow
		var currentShow = ds_list_find_value(showList, i);
		var currentShowSubMap = ds_map_find_value(global.nodeMap, currentShow);
		if (!is_numeric(currentShowSubMap)) continue;
		if (!ds_exists(currentShowSubMap, ds_type_map)) continue;
		var currentShowName = ds_map_find_value(currentShowSubMap, "name");
		
		// Get dimensions of rectangle around show name
		var showRectX1 = x;
		var showRectY1 = y + headerHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
		var showRectX2 = x + windowWidth;
		var showRectY2 = showRectY1 + strHeight;
		var mouseoverShowRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, showRectX1, showRectY1, showRectX2, showRectY2) && !mouseoverScrollBar;
		var highlight = (mouseoverShowRect || functionChainContents_showID == currentShow);
		var textY = floor(mean(showRectY1, showRectY2));
		
		// click on show name
		if (mouseoverShowRect && mouse_check_button_released(mb_left)) {
			with (obj_panelPane) functionChainContents_showID = currentShow;
		}
		
		// draw rect
		draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, highlight ? 0.8 : 0.4));
		draw_rectangle(showRectX1 - clipX, showRectY1 - clipY, showRectX2 - clipX, showRectY2 - clipY, false);
		
		// # column
		draw_set_color(global.colorThemeText);
		draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
		// name column
		draw_set_color(global.colorThemeText);
		draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, string(currentShowName));
		
		// start column
		if (mouseoverShowRect || functionChainContents_showID == currentShow) {
			draw_sprite_ext(spr_ascend, 0, mean(startColX, x + windowWidth) - clipX, mean(showRectY1, showRectY2) - clipY, 1, 1, 270, global.colorThemeText, 1);
		}

		
		// increment plusY
		textPlusY += strHeight;
		
	}
	
	
	// draw "create show" option at end of list
	var createShowRectX1 = x;
	var createShowRectY1 = y + headerHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
	var createShowRectX2 = x + windowWidth;
	var createShowRectY2 = createShowRectY1 + strHeight;
	var mouseoverCreateShowRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, createShowRectX1, createShowRectY1, createShowRectX2, createShowRectY2) && !mouseoverScrollBar && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
	draw_set_color(merge_color(c_green, global.colorThemeSelected1, mouseoverCreateShowRect ? 0.4 : 0.6));
	draw_rectangle(createShowRectX1 - clipX, createShowRectY1 - clipY, createShowRectX2 - clipX, createShowRectY2 - clipY, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_text(floor(mean(x, nameColX)) - clipX, floor(mean(createShowRectY1, createShowRectY2)) - clipY, "+");
	draw_set_halign(fa_left);
	draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(createShowRectY1, createShowRectY2)) - clipY, "Create Show");
	
	// click on "create show"
	if (mouseoverCreateShowRect && mouse_check_button_released(mb_left)) {
		scr_createShow();
	}
	
	
	
	
	
	// only show a scrollbar if we're in 1toMany
	if (drawScrollbar) {
		scr_scrollBar(showListSize + 1, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}

	
		
	scr_surfaceEnd();
	
	
	
	
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
			colText = "Start";
		}
		
		// get header coordinates
		var headerRectX1 = x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// draw header rects
		draw_set_color(global.colorThemeSelected2);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, true);
		
		// draw header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeBG);
		draw_text(headerTextX, headerTextY, colText);
		
		// dividing lines
		if (i > 0) {
			draw_set_color(global.colorThemeBG);
			draw_line(headerRectX1, headerRectY2, headerRectX1, y + windowHeight);
		}
		
		
		headerPlusX += colWidth;
	}
	

}