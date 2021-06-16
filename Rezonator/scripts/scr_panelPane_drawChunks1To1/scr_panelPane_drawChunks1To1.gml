// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChunks1To1(){
	
	// draw BG
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

	// get the instance ID for the chainList pane so we can easily reference it
	var chainListPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListPanelPaneInst = self.id;
		}
	}
	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var strHeight = string_height("0") * 1.5;
	var headerHeight = functionTabs_tabHeight;
	var textMarginLeft = 8;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;
	with (obj_panelPane) functionChainList_chunkMouseover = "";
	
	// get the chunk list & make sure it exists
	var chunkList = global.nodeMap[? "chunkList"];
	if (!scr_isNumericAndExists(chunkList, ds_type_list)) {
		show_debug_message("scr_panelPane_drawChunks1To1 ... chunkList does not exist");
		exit;
	}
	var chunkListSize = ds_list_size(chunkList);
	
	// get chunk field list
	var chunkFieldList = obj_control.navChunkFieldList;
	var chunkFieldListSize = ds_list_size(chunkFieldList);
	
	scr_surfaceStart();
	

	
	// loop across fields
	for (var i = 0; i < chunkFieldListSize; i++) {
		
		var textPlusY = 0;
		var currentField = chunkFieldList[| i];
		
		// loop down chunks
		for (var j = 0; j < chunkListSize; j++) {
			
			
			// don't bother drawing this stuff if it won't be on screen
			if (y + headerHeight + scrollPlusY + textPlusY < y - strHeight
			or y + headerHeight + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
				//textPlusY += strHeight;
				//continue;
			}
			
			// get chunkID & tagMap for the chunk (and make sure it all exists)
			var currentChunk = chunkList[| j];
			var chainSubMap = global.nodeMap[? currentChunk];
			if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) continue;
			var tagMap = chainSubMap[? "tagMap"];
			if (!scr_isNumericAndExists(tagMap, ds_type_map)) continue;
			
			//show_debug_message("currentChunk: " + string(currentChunk));
			
			
			
			// get coordinates for cell rectangle
			var cellRectX1 = x + (i * (windowWidth / chunkFieldListSize));
			var cellRectY1 = y + headerHeight + textPlusY + scrollPlusY - (strHeight / 2);
			var cellRectX2 = cellRectX1 + (windowWidth / chunkFieldListSize);
			var cellRectY2 = cellRectY1 + strHeight;
			var mouseoverRow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, max(cellRectY1, y + headerHeight), x + windowWidth, cellRectY2) && !mouseoverScrollBar && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !scrollBarHolding;
			var mouseoverCell = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) && mouseoverRow;
			var focusedCell = (functionChainList_chunkSelected == currentChunk);
			
			if (mouseoverRow || functionChainList_chunkMouseover == currentChunk) {
				draw_set_color(global.colorThemeSelected1);
				draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
			}
			
			// mouseover and click on row
			if (mouseoverRow) {
				with (obj_panelPane) functionChainList_chunkMouseover = currentChunk;
				
				if (device_mouse_check_button_pressed(0, mb_left)) {
					with (obj_panelPane) functionChainList_chunkSelected = currentChunk;
				}
				
			}
			

			
			
			
			if (focusedCell) {
				focusedRowRectY1 = cellRectY1;
				focusedRowRectY2 = cellRectY2;
			}
			
			
			// check if this chain has a tag filled in for this field
			var tagStr = "";
			if (ds_map_exists(tagMap, currentField)) {
				tagStr = tagMap[? currentField];
			}
			
			// draw text for chain tag
			scr_adaptFont(string(tagStr), "S");
			draw_set_halign(lineStateLTR ? fa_left : fa_right);
			draw_set_valign(fa_middle);
			draw_set_alpha(1);
			draw_set_color(global.colorThemeText);
			
			var textX = 0;
			if(lineStateLTR){
				textX = floor(cellRectX1 + (textMarginLeft));
			}
			else{
				textX = floor(cellRectX2 - (textMarginLeft));
			}
			
			// leave room for scrollbar if we're in RTL and on the last column
			if (!lineStateLTR && i == chunkFieldListSize - 1) {
				textX -= global.scrollBarWidth;
			}
			
			var textY = floor(mean(cellRectY1, cellRectY2));
			
			draw_text(textX - clipX, textY - clipY, string(tagStr));
			
			scr_chunkTagDropDown(global.nodeMap[? "tokenTagMap"], currentField, currentChunk, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, i == chunkFieldListSize - 1);
			
			textPlusY += strHeight;
			
			
			
		}
		
	}
	
	
	// draw focus outline
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}
	
	scr_scrollBar(chunkListSize, -1, strHeight, headerHeight,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scr_surfaceEnd();
	
	scr_panelPane_drawChunks1To1Headers(chunkFieldList);

}