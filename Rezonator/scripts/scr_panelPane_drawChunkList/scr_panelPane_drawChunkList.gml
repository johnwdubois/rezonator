// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChunkList(){

	var drawScrollbar = chainViewOneToMany;
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var unitColX = numColX + numColWidth;
	var unitColWidth = windowWidth * 0.15;
	var nameColX = unitColX + unitColWidth;
	var nameColWidth = windowWidth * 0.25;
	var textColX = nameColX + nameColWidth;
	var textColWidth = windowWidth * 0.4;
	var nestColX = textColX + textColWidth;
	
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var focusedElementY = -1;
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	if (!mouseoverWindow) {
		with (obj_panelPane) functionChainList_chunkMouseover = "";
	}
	
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
		
		// don't bother drawing this stuff if it won't be on screen
		if (y + headerHeight + scrollPlusY + textPlusY < y - strHeight
		or y + headerHeight + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			continue;
		}
		
	
		// get data for currentShow
		var currentChunk = chunkList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		if (!scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) continue;
		
		// get chunk variables
		var currentChunkName = currentChunkSubMap[? "name"];
		var currentChunkFirstToken = scr_getFirstWordOfChunk(currentChunk);
		var currentChunkFirstTokenSubMap = global.nodeMap[? currentChunkFirstToken];
		var currentChunkUnit = "";
		var currentChunkUnitSeq = "";
		if (scr_isNumericAndExists(currentChunkFirstTokenSubMap, ds_type_map)) {
			currentChunkUnit = currentChunkFirstTokenSubMap[? "unit"];
			var currentChunkUnitSubMap = global.nodeMap[? currentChunkUnit];
			if (scr_isNumericAndExists(currentChunkUnitSubMap, ds_type_map)) {
				currentChunkUnitSeq = string(currentChunkUnitSubMap[? "unitSeq"]);
			}
		}
		var currentChunkNest = currentChunkSubMap[? "nest"];
		
		
		// Get dimensions of rectangle around row
		var rowRectX1 = x;
		var rowRectY1 = y + headerHeight + scrollPlusY + textPlusY - (strHeight / 2);
		var rowRectX2 = x + windowWidth;
		var rowRectY2 = rowRectY1 + strHeight;
		var mouseoverRowRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rowRectX1, rowRectY1, rowRectX2, rowRectY2) && !mouseoverScrollBar && !scrollBarHolding && !mouseoverHeaderRegion && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		var textY = floor(mean(rowRectY1, rowRectY2));
		
		if(mouseoverRowRect){
			obj_control.hoverTextCopy = currentChunkNest;
		}
		var mouseOverNameRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, nameColX, rowRectY1, nameColX + nameColWidth, rowRectY2) && !mouseoverScrollBar && !scrollBarHolding && !mouseoverHeaderRegion && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		if(mouseOverNameRect){
			obj_control.hoverTextCopy = currentChunkName;
		}
		var mouseOverTextRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, textColX, rowRectY1, textColX + textColWidth, rowRectY2) && !mouseoverScrollBar && !scrollBarHolding && !mouseoverHeaderRegion && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		if(mouseOverTextRect){
			obj_control.hoverTextCopy = scr_getChunkText(currentChunk);
		}
		var mouseOverUnitRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, unitColX, rowRectY1, unitColX + unitColWidth, rowRectY2) && !mouseoverScrollBar && !scrollBarHolding && !mouseoverHeaderRegion && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		if(mouseOverUnitRect){
			obj_control.hoverTextCopy = currentChunkUnitSeq;
		}
		var mouseOverIndexRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, numColX, rowRectY1, numColX + numColWidth, rowRectY2) && !mouseoverScrollBar && !scrollBarHolding && !mouseoverHeaderRegion && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		if(mouseOverIndexRect){
			obj_control.hoverTextCopy = string(i + 1);
		}
	

		
		if (functionChainList_chunkSelected == currentChunk) {
			with (obj_panelPane) functionChainList_focusedUnit = currentChunk;
			with (obj_panelPane) functionChainList_focusedChunkIndex = i;
			focusedElementY = textY;
		}
		
		// mouseover & click
		if (mouseoverRowRect) {
			with (obj_panelPane) functionChainList_chunkMouseover = currentChunk;
			if (device_mouse_check_button_pressed(0, mb_left)) {
				with (obj_panelPane) functionChainList_chunkSelected = currentChunk;
				scr_jumpToUnitDoubleClick(currentChunkUnit);
				obj_chain.currentFocusedChunkID = currentChunk;
			}
		}
		
		// draw rect
		var rectColor = merge_color(global.colorThemeBG, global.colorThemeSelected1, (mouseoverRowRect || functionChainList_chunkMouseover == currentChunk) ? 0.8 : 0.4);
		if (functionChainList_chunkSelected == currentChunk) rectColor = global.colorThemeSelected2;
		var textColor = (functionChainList_chunkSelected == currentChunk) ? global.colorThemeBG : global.colorThemeText;
		draw_set_color(rectColor);
		draw_rectangle(rowRectX1 - clipX, rowRectY1 - clipY, rowRectX2 - clipX, rowRectY2 - clipY, false);

		// # column
		draw_set_color(textColor);
		draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
		// unit column
		draw_text(floor(unitColX + textBuffer) - clipX, textY - clipY, string(currentChunkUnitSeq));
		
		// name column
		draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, string(currentChunkName));
		
		// text column
		draw_text(floor(textColX + textBuffer) - clipX, textY - clipY, scr_getChunkText(currentChunk));
		
		// nest column
		draw_text(floor(nestColX + textBuffer) - clipX, textY - clipY, string(currentChunkNest));

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
	
	scr_panelPane_chunkScroll(focusedElementY, strHeight);
	scr_surfaceEnd();
	
	
	// draw column headers
	var headerPlusX = 0;
	for (var i = 0; i < 5; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = unitColWidth;
			colText = "Unit";
		}
		else if (i == 2) {
			colWidth = nameColWidth;
			colText = "Name";
		}
		else if (i == 3) {
			colWidth = textColWidth;
			colText = "Word";
		}
		else if (i == 4) {
			colWidth = windowWidth - nestColX;
			colText = "Nest";
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