function scr_panelPane_drawChains1To1() {
	
	
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
	
	var headerHeight = functionTabs_tabHeight;
	
	var focusedElementY = -1;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;
	
	var mouseoverScrollBar = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + headerHeight, x + windowWidth, y + windowHeight);
	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var dropDownButtonWidth = sprite_get_width(spr_dropDown);
	
	// get list of dynamic 1-1 columns for this tab, as well as the list of chains for this tab
	var listOfChains = -1;
	var listOfChainsKey = "";
	var chainType = "";
	var chain1to1ColFieldList = -1;
	with (chainListPanelPaneInst) {
		if (functionChainList_currentTab == functionChainList_tabRezBrush) {
			listOfChainsKey = "resonanceList";
			chainType = "resonance";
			chain1to1ColFieldList = obj_control.chain1to1ColFieldListRez;
		}
		else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
			listOfChainsKey = "trailList";
			chainType = "trail";
			chain1to1ColFieldList = obj_control.chain1to1ColFieldListTrack;
		}
		else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
			listOfChainsKey = "stackList";
			chainType = "stack";
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
	
	
	if (!global.html5) scr_surfaceStart();
	
	
	var strHeight = leftPaneStrHeight;

	// Set text margin area
	var textMarginLeft = 8;

	var textPlusY = 0;
	var colWidth = windowWidth / obj_panelPane.chain1to1ColAmount;

	var drawDropDowns = false;
	if (!instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, y + headerHeight, x + windowWidth, y + windowHeight)) {
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
		var currentFieldSubMap = global.chainFieldMap[? currentField];
		var fieldHasTagSet = false;
		if (scr_isNumericAndExists(currentFieldSubMap, ds_type_map)) {
			fieldHasTagSet = ds_map_exists(currentFieldSubMap, "tagSet");
			if (currentFieldSubMap[? "readOnly"]) fieldHasTagSet = false;
		}
		
		
		for (var i = 0; i < listOfChainsSize; i++) {
			
			// don't bother drawing this stuff if it won't be on screen
			if (y + headerHeight + scrollPlusY + textPlusY < y - strHeight
			or y + headerHeight + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			    textPlusY += strHeight;
			    continue;
			}

			// get chainID & tagMap for the chain (and make sure it all exists)
			var chainID = listOfChains[| i];
			var chainSubMap = global.nodeMap[? chainID];
			if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) continue;
			var tagMap = chainSubMap[? "tagMap"];
			if (!scr_isNumericAndExists(tagMap, ds_type_map)) continue;
			
			// get coordinates for cell rectangle
			var cellRectX1 = x + (j * colWidth) + scrollHorPlusX;
			var cellRectY1 = y + headerHeight + textPlusY + scrollPlusY - (strHeight / 2);
			var cellRectX2 = cellRectX1 + colWidth;
			var cellRectY2 = cellRectY1 + strHeight;
			var mouseoverCell = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, max(cellRectY1, y + headerHeight), cellRectX2, cellRectY2) && !mouseoverScrollBar && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown);
			var focusedCell = (obj_chain.currentFocusedChainID == chainID);
			var highlightCell = (focusedCell || chainTagsHighlightRow == i);
			
			if (focusedCell) {
				focusedRowRectY1 = cellRectY1;
				focusedRowRectY2 = cellRectY2;
				focusedElementY = y + headerHeight + scrollPlusY + textPlusY;
			}
			
			var chainColor = ds_map_find_value(chainSubMap, "chainColor");
			draw_set_alpha(1);
			var cellColor = merge_color(chainColor, global.colorThemeBG, (highlightCell) ? 0.65 : 0.75);
			draw_set_color(cellColor);
			draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
			
			// Check mouse clicks to focus a line in the list
			if (mouseoverCell) {
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
				tagStr = tagMap[? currentField];
			}
			
			// draw text for chain tag
			scr_adaptFont(string(tagStr), "S");
			draw_set_halign(lineStateLTR ? fa_left : fa_right);
			draw_set_valign(fa_middle);
			draw_set_alpha(1);
			draw_set_color(global.colorThemeText);
			
			if (lineStateLTR) {
				var textX = floor(cellRectX1 + (textMarginLeft));
			}
			else {
				var textX = floor(cellRectX2 - (textMarginLeft));
				if (drawDropDowns && mouseoverCell) {
					textX = textX - dropDownButtonWidth;
				}
			}
			
			// leave room for scrollbar if we're in RTL and on the last column
			if (!lineStateLTR && i == chain1to1ColFieldListSize-1) {
				textX -= global.scrollBarWidth;
			}
			
			if (mouseoverCell) {
				obj_control.hoverTextCopy = tagStr;
			}
			
			draw_set_alpha(fieldHasTagSet ? 1 : 0.7);
			draw_text(textX - clipX, y + headerHeight + scrollPlusY + textPlusY - clipY, string(tagStr));
			draw_set_alpha(1);
			
			textPlusY += strHeight;
								
			scr_chainTagDropDown(global.chainFieldMap, currentField, chainID, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, (j == chain1to1ColFieldListSize - 1),string(tagStr));
		}
	}
	scr_navWindowTaggingSelection(chain1to1ColFieldList, listOfChains,"chain");
	
	// draw focus outline
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		//draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		//draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}
	
	
	scr_scrollBarHorizontal(chain1to1ColFieldListSize, colWidth, global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scr_scrollBar(listOfChainsSize, focusedElementY, strHeight, headerHeight,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	
	if (!global.html5) scr_surfaceEnd();
	
	scr_panelPane_drawChains1To1Headers(chain1to1ColFieldList, chainType);
	
	
	
	
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	var instToScroll = self.id;
	if (clickedIn) {	
		if ((mouse_wheel_up() or (keyboard_check(vk_up) && obj_control.navWindowTaggingID == "")) and (holdUp < 2 or holdUp > 30)) {
			if (functionChainList_focusedChainIndex > 0 and functionChainList_focusedChainIndex < listOfChainsSize) {
				with (obj_panelPane) functionChainList_focusedChainIndex--;
				var newFocusedChainID = ds_list_find_value(listOfChains, functionChainList_focusedChainIndex);
				obj_chain.currentFocusedChainID = newFocusedChainID;
				
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
		
		if ((mouse_wheel_down() || (keyboard_check(vk_down) && obj_control.navWindowTaggingID == "")) and (holdDown < 2 || holdDown > 30)) {	
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