// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawTreeList(){
	var ltr = (obj_control.drawLineState == obj_control.lineState_ltr);
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.25;
	var captionColX = nameColX + nameColWidth;
	
	var deleteColWidth = clamp(windowWidth * 0.15, sprite_get_width(spr_trash), sprite_get_width(spr_trash) * 2);
	var deleteColX = x + windowWidth - deleteColWidth - global.scrollBarWidth;
	var mouseOverDel = false;
	
	var maxCaptionSize = deleteColX-captionColX;
	
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
	
	var maxTokenListSize = 15;
	
	// loop over trees
	for (var i = 0; i < treeListSize; i++) {
		
		// don't bother drawing this stuff if it won't be on screen
		if (y + headerHeight + scrollPlusY + textPlusY < y - strHeight
		or y + headerHeight + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			continue;
		}
		
		// get data for currentClique
		var currentTree = treeList[| i];
		var currentTreeSubMap = global.treeMap[? currentTree];
		if (!scr_isNumericAndExists(currentTreeSubMap, ds_type_map)) {
			textPlusY += strHeight;
			continue;
		}
		
		// get tree name and its token list, and make sure that exists
		var currentTreeName = currentTreeSubMap[? "name"];
		var currentTreeSelected = (functionTree_treeSelected == currentTree);
		var tokenList = currentTreeSubMap[? "tokenList"];
		if (!scr_isNumericAndExists(tokenList, ds_type_list)) {
			textPlusY += strHeight;
			continue;
		}
		if (ds_list_size(tokenList) < 1) {
			textPlusY += strHeight;
			continue;
		}
		
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
		
		// text column
		var fullTreeStr = ""
		var tokenListSize = ds_list_size(tokenList);
		var j = (ltr) ? 0 : tokenListSize-1;
		var textRepeatCount = min(tokenListSize, maxTokenListSize);
		repeat(textRepeatCount){
			var currentTokenSubMap = global.nodeMap[? tokenList[| j]];
			if(!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)){j = (ltr) ? j+1: j-1;continue;}
			var tokenTagMap = currentTokenSubMap[? "tagMap"];
			fullTreeStr += (string(tokenTagMap[? global.displayTokenField]) + " ");
			j = (ltr) ? j+1: j-1;
		}
		if (tokenListSize > maxTokenListSize) fullTreeStr += "...";
		
		// cut off section text if its too long
		var cutoffs = 0;
		while (string_width(fullTreeStr + "... ") > maxCaptionSize and cutoffs < 100) {
			fullTreeStr = string_delete(fullTreeStr, string_length(fullTreeStr), 1);
			cutoffs++;
		}
		if (cutoffs > 0) {
			fullTreeStr += "... ";
		}
		
		scr_adaptFont(string(fullTreeStr), "M");
		draw_text(floor(captionColX + textBuffer) - clipX, textY - clipY, string(fullTreeStr));
		
		// get unitID of the first token, for double-click to jump
		var unitToJumpTo = "";
		var firstToken = tokenList[| 0];
		var firstTokenSubMap = global.nodeMap[? firstToken];
		if (scr_isNumericAndExists(firstTokenSubMap, ds_type_map)) {
			unitToJumpTo = firstTokenSubMap[? "unit"];
		}
	
		// get coordinates for delete button
		var delButtonX = mean(deleteColX, deleteColX + deleteColWidth);
		var delButtonY = treeRectY1 + (strHeight * 0.5);
		mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, deleteColX, treeRectY1, deleteColX + deleteColWidth, treeRectY2) && mouseoverTreeRect;
		var trashAlpha =  1;

		if (mouseoverTreeRect || currentTreeSelected) {					
			// mouseover & click on sequence arrows
			if (mouseOverDel) {
				draw_set_color(global.colorThemeSelected1);
				draw_rectangle(deleteColX - clipX, treeRectY1 - clipY, deleteColX + deleteColWidth + global.scrollBarWidth - clipX, treeRectY2 - clipY, false);
				if (mouse_check_button_released(mb_left)) {
					
					
					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						obj_dialogueBox.removeTree = true
						obj_dialogueBox.questionWindowActive = true;
						obj_dialogueBox.stringToBeRemoved = currentTree;
					}

				}
				
				scr_createTooltip(delButtonX, treeRectY2, scr_get_translation("msg_remove"), obj_tooltip.arrowFaceUp);
			}
			else {
				if (mouse_check_button_released(mb_left)) {
					scr_jumpToUnitDoubleClick(unitToJumpTo);
				}
			}
			

								
			draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
		}
		
		
		
		
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
	for (var i = 0; i <= 2; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = nameColWidth;
			colText = scr_get_translation("name");
		}
		else if (i == 2) {
			colWidth = windowWidth - nameColX;
			colText = scr_get_translation("tag_text");
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