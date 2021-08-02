// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawTreeList(){
	

	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;

	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	// get the tree list & make sure it exists
	var treeList = global.nodeMap[? "treeList"];
	if (!scr_isNumericAndExists(treeList, ds_type_list)) {
		show_debug_message("scr_panelPane_drawTreeList ... treeList does not exist");
		exit;
	}
	
	var treeListSize = ds_list_size(treeList);
	scr_surfaceStart();
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	
	// loop over trees
	for (var i = 0; i < treeListSize; i++) {
		
		// get data for currentClique
		var currentTree = treeList[| i];
		var currentTreeSubMap = global.treeMap[? currentTree];
		if (!scr_isNumericAndExists(currentTreeSubMap, ds_type_map)) {
			continue;
		}
		
		var currentTreeName = currentTreeSubMap[? "name"];
		var currentTreeSelected = (functionTree_treeSelected == currentTree);
		
		// Get dimensions of rectangle around tree name
		var treeRectX1 = x;
		var treeRectY1 = y + headerHeight + scrollPlusY + textPlusY - (strHeight / 2);
		var treeRectX2 = x + windowWidth;
		var treeRectY2 = treeRectY1 + strHeight;
		var mouseoverTreeRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, treeRectX1, treeRectY1, treeRectX2, treeRectY2) && !mouseoverScrollBar && !scrollBarHolding && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeaderRegion;
		var highlight = mouseoverTreeRect;
		var textY = floor(mean(treeRectY1, treeRectY2));
		
		// click on tree name
		if (mouseoverTreeRect) {
			if (mouse_check_button_released(mb_left) && !instance_exists(obj_dropDown)) {
				with (obj_panelPane) functionTree_treeSelected = currentTree;
				obj_chain.currentFocusedEntryID = "";
				with (obj_panelPane) {
					if (currentFunction == functionChainContents) scrollPlusX = 0;
				}
			}
		}
		
		// draw rect
		var rectColor = (currentTreeSelected) ? global.colorThemeSelected2 : merge_color(global.colorThemeBG, global.colorThemeSelected1, highlight ? 0.8 : 0.4);
		var textColor = (currentTreeSelected) ? global.colorThemeBG : global.colorThemeText;
		draw_set_color(rectColor);
		draw_rectangle(treeRectX1 - clipX, treeRectY1 - clipY, treeRectX2 - clipX, treeRectY2 - clipY, false);
		
		// # column
		draw_set_color(textColor);
		draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
		// name column
		draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, string(currentTreeName));
		
		// increment plusY
		textPlusY += strHeight;
	}
	
	
	scr_scrollBar(treeListSize, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
			
	scr_scrollMouseControls(strHeight);
	scr_surfaceEnd();
	
	
	// draw column headers
	var headerPlusX = 0;
	for (var i = 0; i < 2; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = windowWidth - numColX;
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
		
		
		headerPlusX += colWidth;
	}
	

}