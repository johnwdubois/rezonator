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
	var strHeight = leftPaneStrHeight;
	var headerHeight = functionTabs_tabHeight;
	var textMarginLeft = 8;
	var focusedElementY = -1;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;
	var colWidth = windowWidth / obj_panelPane.chunk1to1ColAmount;
	
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
	var selectedChunkIndex = -1;
	



	
	// loop across fields
	for (var i = 0; i < chunkFieldListSize; i++) {
		
		var textPlusY = 0;
		var currentField = chunkFieldList[| i];
		
		// loop down chunks
		for (var j = 0; j < chunkListSize; j++) {
			
			
			// don't bother drawing this stuff if it won't be on screen
			if (y + headerHeight + scrollPlusY + textPlusY < y - strHeight
			or y + headerHeight + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
				textPlusY += strHeight;
				continue;
			}

			
			// get chunkID & tagMap for the chunk (and make sure it all exists)
			var currentChunk = chunkList[| j];
			var chainSubMap = global.nodeMap[? currentChunk];
			if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) continue;
			var tagMap = chainSubMap[? "tagMap"];
			if (!scr_isNumericAndExists(tagMap, ds_type_map)) continue;
			
			
			
			// get coordinates for cell rectangle
			var cellRectX1 = x + (i * colWidth) + scrollHorPlusX;
			var cellRectY1 = y + headerHeight + textPlusY + scrollPlusY - (strHeight / 2);
			var cellRectX2 = cellRectX1 + colWidth;
			var cellRectY2 = cellRectY1 + strHeight;
			var mouseoverRow = point_in_rectangle(mouse_x, mouse_y, 0, max(cellRectY1, y + headerHeight), x + windowWidth, min(cellRectY2, y + windowHeight)) && !mouseoverScrollBar && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !scrollBarHolding;
			var mouseoverCell = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) && mouseoverRow;
			var focusedCell = (functionChainList_chunkSelected == currentChunk);
			if (focusedCell) selectedChunkIndex = j;
			

			
			// draw BG for this cell
			if (mouseoverRow || functionChainList_chunkMouseover == currentChunk) {
				draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, 0.8));
			}
			else {
				draw_set_color(global.colorThemeBG);
			}
			draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
			
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
				focusedElementY = focusedRowRectY1;
			}
			
			
			// check if this chain has a tag filled in for this field
			var tagStr = "";
			if (ds_map_exists(tagMap, currentField)) {
				tagStr = tagMap[? currentField];
			}
			
			if(mouseoverCell){
				obj_control.hoverTextCopy = tagStr;
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
	
	scr_scrollBarHorizontal(ds_list_size(chunkFieldList), colWidth, global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scr_scrollBar(chunkListSize, focusedElementY, strHeight, headerHeight,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	

	
	scr_panelPane_drawChunks1To1Headers(chunkFieldList);
	
	
	
	
	
	
	
	
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	var instToScroll = self.id;
	if (clickedIn || chainListPanelPaneInst.clickedIn) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {

			if (selectedChunkIndex > 0 and selectedChunkIndex < chunkListSize) {
				
				selectedChunkIndex--;
				var newSelectedChunk = chunkList[| selectedChunkIndex];
				with (obj_panelPane) functionChainList_chunkSelected = newSelectedChunk;
				
				if (focusedElementY <= y + headerHeight + strHeight) {
					with (instToScroll) {
						scrollPlusYDest += max(abs(focusedElementY - (y + headerHeight + strHeight)) + strHeight, strHeight);
					}
				}
			}
			else {
				with (instToScroll) {
					scrollPlusYDest += 4;
				}
			}
		}
		
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (holdDown < 2 || holdDown > 30)) {
			
			if (selectedChunkIndex < chunkListSize - 1 and selectedChunkIndex >= 0) {

				selectedChunkIndex++;
				var newSelectedChunk = chunkList[| selectedChunkIndex];
				with (obj_panelPane) functionChainList_chunkSelected = newSelectedChunk;
				
				if (focusedElementY >= y + windowHeight - strHeight) {
					with (instToScroll) {
						scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
					}
				}
			}
			else {
				with (instToScroll) {
					scrollPlusYDest -= 4;
				}
			}
		}
	
		// CTRL+UP and CTRL+DOWN
		if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
			with (instToScroll) {
				scrollPlusYDest = 100;
			}
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
			with (instToScroll) {
				scrollPlusYDest = -999999999999;
			}
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			with (instToScroll) {
				scrollPlusYDest += (windowHeight);
			}
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			with (instToScroll) {
				scrollPlusYDest -= (windowHeight);
			}
		}
	}
	

}