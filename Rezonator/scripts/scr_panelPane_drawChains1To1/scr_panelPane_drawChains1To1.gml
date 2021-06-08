// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChains1To1(){
	
	
	// get the instance ID for the chainList pane so we can easily reference it
	var chainListPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListPanelPaneInst = self.id;
		}
	}
	
	if (!instance_exists(obj_dropDown)) {
		obj_control.mouseoverTagShortcut = "";
	}
	
	var tabHeight = functionTabs_tabHeight;
	
	var focusedElementY = -1;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;
	
	var mouseoverScrollBar = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + tabHeight, x + windowWidth, y + windowHeight);
	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var dropDownButtonWidth = sprite_get_width(spr_dropDown);
	
	// get list of dynamic 1-1 columns for this tab, as well as the list of chains for this tab
	var listOfChains = -1;
	var listOfChainsKey = "";
	var chainType = "";
	var chain1to1ColFieldList = -1;
	with (chainListPanelPaneInst) {
		if (functionChainList_currentTab == functionChainList_tabRezBrush) {
			listOfChainsKey = "rezChainList";
			chainType = "rezChain";
			chain1to1ColFieldList = obj_control.chain1to1ColFieldListRez;
		}
		else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
			listOfChainsKey = "trackChainList";
			chainType = "trackChain";
			chain1to1ColFieldList = obj_control.chain1to1ColFieldListTrack;
		}
		else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
			listOfChainsKey = "stackChainList";
			chainType = "stackChain";
			chain1to1ColFieldList = obj_control.chain1to1ColFieldListStack;
		}
	}
	listOfChains = ds_map_find_value(global.nodeMap, listOfChainsKey);
	
	// make sure we found those lists!
	if (!is_numeric(listOfChains) || !is_numeric(chain1to1ColFieldList)) {
		exit;
	}
	if (!ds_exists(listOfChains, ds_type_list) || !ds_exists(chain1to1ColFieldList, ds_type_list)) {
		exit;
	}
	var chain1to1ColFieldListSize = ds_list_size(chain1to1ColFieldList);
	var listOfChainsSize = ds_list_size(listOfChains);
	
	
	scr_surfaceStart();
	
	
	var strHeight = string_height("0") * 1.5;

	// Set text margin area
	var textMarginLeft = 8;

	var textMarginTop = functionTabs_tabHeight;
	var textPlusY = 0;

	var drawDropDowns = false;
	if (!instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, y + tabHeight, x + windowWidth, y + windowHeight)) {
		with (obj_panelPane) {
			chainTagsHighlightRow = -1;
		}
	}
	
	
	
	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(lineStateLTR ? fa_left : fa_right);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	
	
	for (var j = 0; j < chain1to1ColFieldListSize; j++) {
		
		textPlusY = 0;
		drawDropDowns = false;
		
		// get field/key for this column
		var currentField = ds_list_find_value(chain1to1ColFieldList, j);
		
		for (var i = 0; i < listOfChainsSize; i++) {
			
			// don't bother drawing this stuff if it won't be on screen
			if (y + textMarginTop + scrollPlusY + textPlusY < y - strHeight
			or y + textMarginTop + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			    textPlusY += strHeight;
			    continue;
			}

			// get chainID & tagMap for the chain (and make sure it all exists)
			var chainID = ds_list_find_value(listOfChains, i);
			var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
			if (!is_numeric(chainSubMap)) continue;
			if (!ds_exists(chainSubMap, ds_type_map)) continue;
			var tagMap = ds_map_find_value(chainSubMap, "tagMap");
			if (!is_numeric(tagMap)) continue;
			if (!ds_exists(tagMap, ds_type_map)) continue;
			
			// get coordinates for cell rectangle
			var cellRectX1 = x + (j * (windowWidth / chain1to1ColFieldListSize));
			var cellRectY1 = y + textMarginTop + textPlusY + scrollPlusY - (strHeight / 2);
			var cellRectX2 = cellRectX1 + (windowWidth / chain1to1ColFieldListSize);
			var cellRectY2 = cellRectY1 + strHeight;
			var mouseoverCell = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, max(cellRectY1, y + tabHeight), cellRectX2, cellRectY2) && !mouseoverScrollBar;
			var focusedCell = (obj_chain.currentFocusedChainID == chainID);
			var highlightCell = (focusedCell || chainTagsHighlightRow == i);
			
			if (focusedCell) {
				focusedRowRectY1 = cellRectY1;
				focusedRowRectY2 = cellRectY2;
				focusedElementY = y + textMarginTop + scrollPlusY + textPlusY;
			}
			
			var chainColor = ds_map_find_value(chainSubMap, "chainColor");
			draw_set_alpha(1);
			var cellColor = merge_color(chainColor, global.colorThemeBG, (highlightCell) ? 0.65 : 0.75);
			draw_set_color(cellColor);
			draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
			
			// Check mouse clicks to focus a line in the list
			if (mouseoverCell && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)) {
				drawDropDowns = true;
				with (obj_panelPane) {
					chainTagsHighlightRow = i;
				}
        
			    if (device_mouse_check_button_released(0, mb_left)) {
			        obj_chain.currentFocusedChainID = chainID;
			    }
			}
			

		
			// check if this chain has a tag filled in for this field
			var tagStr = "";
			if (ds_map_exists(tagMap, currentField)) {
				tagStr = ds_map_find_value(tagMap, currentField);
			}
			
			// draw text for chain tag
			scr_adaptFont(string(tagStr), "S");
			draw_set_halign(lineStateLTR ? fa_left : fa_right);
			draw_set_valign(fa_middle);
			draw_set_alpha(1);
			draw_set_color(global.colorThemeText);
			
			if(lineStateLTR){
				var textX = floor(cellRectX1 + (textMarginLeft));
			}
			else{
				var textX = floor(cellRectX2 - (textMarginLeft));
				if(drawDropDowns && mouseoverCell){
					textX = textX - dropDownButtonWidth;
				}
			}
			
			// leave room for scrollbar if we're in RTL and on the last column
			if (!lineStateLTR && i == chain1to1ColFieldListSize-1) {
				textX -= global.scrollBarWidth;
			}
			
			draw_text(textX  - clipX, y + textMarginTop + scrollPlusY + textPlusY - clipY, string(tagStr));
			
			textPlusY += strHeight;
								
			scr_chainTagDropDown(global.chainFieldMap, currentField, chainID, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, (j == chain1to1ColFieldListSize - 1));
		}
	}
	
	
	// draw focus outline
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}
	
	
	
	scr_scrollBar(listOfChainsSize, focusedElementY, strHeight, textMarginTop,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	
	scr_surfaceEnd();
	
	scr_panelPane_drawChains1To1Headers(chain1to1ColFieldList, chainType);
	
	
	
	
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	var instToScroll = self.id;
	if (clickedIn) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {

			if (functionChainList_focusedChainIndex > 0 and functionChainList_focusedChainIndex < listOfChainsSize) {
				with (obj_panelPane) functionChainList_focusedChainIndex--;
				var newFocusedChainID = ds_list_find_value(listOfChains, functionChainList_focusedChainIndex);
				obj_chain.currentFocusedChainID = newFocusedChainID;
				
				if (focusedElementY <= y + textMarginTop + strHeight) {
					with (instToScroll) {
						scrollPlusYDest += max(abs(focusedElementY - (y + textMarginTop + strHeight)) + strHeight, strHeight);
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
			
			if (functionChainList_focusedChainIndex < listOfChainsSize - 1 and functionChainList_focusedChainIndex >= 0) {
				with (obj_panelPane) functionChainList_focusedChainIndex++;
				var newFocusedChainID = ds_list_find_value(listOfChains, functionChainList_focusedChainIndex);
				obj_chain.currentFocusedChainID = newFocusedChainID;
				
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
		if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
			with (instToScroll) {
				scrollPlusYDest = 100;
			}
		}
		if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
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