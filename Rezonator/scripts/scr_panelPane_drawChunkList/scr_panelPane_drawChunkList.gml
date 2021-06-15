// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChunkList(){

	var drawScrollbar = chainViewOneToMany;
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	// get the instance ID for the chainContents pane so we can easily reference it
	var chainContentsPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			chainContentsPanelPaneInst = self.id;
		}
	}
	
	// get the chunk list & make sure it exists
	var chunkList = global.nodeMap[? "chunkList"];
	if (!scr_isNumericAndExists(chunkList, ds_type_list)) {
		show_debug_message("scr_panelPane_drawChunkList ... chunkList does not exist");
		exit;
	}
	var chunkListSize = ds_list_size(chunkList);
	
	scr_surfaceStart();
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);

	// loop over chunks
	for (var i = 0; i < chunkListSize; i++) {
		
		// get data for currentShow
		var currentChunk = chunkList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		if (!scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) continue;
		
		// get chunk variables
		var currentChunkName = currentChunkSubMap[? "name"];
		
		// Get dimensions of rectangle around row
		var rowRectX1 = x;
		var rowRectY1 = y + headerHeight + scrollPlusY + textPlusY - (strHeight / 2);
		var rowRectX2 = x + windowWidth;
		var rowRectY2 = rowRectY1 + strHeight;
		var mouseoverRowRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rowRectX1, rowRectY1, rowRectX2, rowRectY2) && !mouseoverScrollBar && !scrollBarHolding && !mouseoverHeaderRegion && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		var textY = floor(mean(rowRectY1, rowRectY2));
		
		// mouseover & click
		if (mouseoverRowRect) {
			with (obj_panelPane) functionChainList_chunkMouseover = currentChunk;
			if (device_mouse_check_button_pressed(0, mb_left)) {
				with (obj_panelPane) functionChainList_chunkSelected = currentChunk;
			}
		}
		
		// draw rect
		var rectColor = (mouseoverRowRect || functionChainList_chunkMouseover == currentChunk) ? global.colorThemeSelected1 : global.colorThemeBG;
		if (functionChainList_chunkSelected == currentChunk) rectColor = c_yellow;
		var textColor = global.colorThemeText;
		draw_set_color(rectColor);
		draw_rectangle(rowRectX1 - clipX, rowRectY1 - clipY, rowRectX2 - clipX, rowRectY2 - clipY, false);

		// # column
		draw_set_color(textColor);
		draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
		// name column
		draw_set_color(textColor);
		draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, string(currentChunkName));

		// increment plusY
		textPlusY += strHeight;
	}
	
	if (drawScrollbar) {
		scr_scrollBar(chunkListSize, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}
	else {
		scrollPlusY = chainContentsPanelPaneInst.scrollPlusY;
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
			colWidth = windowWidth - nameColX;
			colText = "Name";
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
		
		// dividing lines
		if (i > 0) {
			draw_set_color(global.colorThemeBG);
			draw_line(headerRectX1, headerRectY2, headerRectX1, y + windowHeight);
		}
		
		
		headerPlusX += colWidth;
	}
	

}