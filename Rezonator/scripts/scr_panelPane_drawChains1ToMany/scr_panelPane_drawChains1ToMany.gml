function scr_panelPane_drawChains1ToMany() {
	/*
		scr_panelPane_drawchainContentsLoop();
	
		Last Updated: 2018-07-12
	
		Called from: obj_panelPane
	
		Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
		Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
	
		Author: Terry DuBois, Georgio Klironomos
	*/
	
	var chain1toManyColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
		}
	}


	// INcrease the size of the utterance column!!!
	var filterPaneWidth = 0;
	var chainListPaneWidth = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListPaneWidth = windowWidth;
		}
		else if (currentFunction == functionFilter) {
			filterPaneWidth = windowWidth;
		}
	}

	//Set this pane to the right of the chainListPane
	x = filterPaneWidth + chainListPaneWidth;

	// Set opacity, alignment, and font of contents list
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("0");
	var tabHeight = functionChainList_tabHeight;
	var scrollBarListHeight = 0;
	var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + tabHeight);
	
	if (!instance_exists(obj_dropDown)) {
		obj_control.mouseoverTagShortcut = "";
	}

	if (functionChainContents_colXList == -1 or is_undefined(functionChainContents_colXList)) {
		exit;
	}

	scr_surfaceStart();

	// Find current tab to draw correct contents
	switch (functionChainList_currentTab) {
		case functionChainList_tabLine:
			if (obj_control.showTranslation) {
				scr_panelPane_drawLineTranslationLoopClipped();
			}
			else if (obj_control.showUnitTags and not obj_control.showTranslation) {
				scr_panelPane_drawUnitTagsLoopClipped();	
			}
			else {
				scr_panelPane_drawLineContentsLoopClipped();
			}
			break;
		default:
			break;
	}
	
	
	if (!ds_exists(chain1toManyColFieldList, ds_type_list)) {
		scr_surfaceEnd();
		exit;
	}


	// Set text margins
	var textPlusY = 0;
	var ableToBeMouseOver = true;
	var textMarginTop = tabHeight;


	var focusedChainExists = false;
	var alignRectSize = strHeight;

	var focusedElementY = -1;

	var strHeight = string_height("0");

	// Check for focused chain and make sure grid is not empty, gather information from grids
	// Collect beginning of chain info
	focusedChainExists = true;
	var chainID = functionChainContents_chainID;
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	
	// make sure chain exists and that its submap exists
	if (!is_numeric(chainSubMap)) {
		scr_surfaceEnd();
		exit;
	}
	if (!ds_exists(chainSubMap, ds_type_map)) {
		scr_surfaceEnd();
		exit;
	}
	
	// get some cool variables from the chain
	var chainType = ds_map_find_value(chainSubMap, "type");
	var chainAligned = ds_map_find_value(chainSubMap, "alignChain");
	var chainFocusedEntry = ds_map_find_value(chainSubMap, "focused");
	
	// make sure that we have a valid chain type
	if (chainType != "rezChain" && chainType != "trackChain" && chainType != "stackChain") {
		functionChainContents_chainID = "";
		scr_surfaceEnd();
		exit;
	}
	
	// make sure that the chain type that we are trying to view matches the tab we are on
	if ((chainType == "rezChain" && functionChainList_currentTab != functionChainList_tabRezBrush)
	|| (chainType == "trackChain" && functionChainList_currentTab != functionChainList_tabTrackBrush)
	|| (chainType == "stackChain" && functionChainList_currentTab != functionChainList_tabStackBrush)) {
		functionChainContents_chainID = "";
		scr_surfaceEnd();
		exit;
	}
	
	// Get vizSetIDList list for the focused chain
	with (obj_panelPane) {
		var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
		if (is_numeric(focusedChainSubMap)) {
			if (ds_exists(focusedChainSubMap, ds_type_map)) {
				functionChainContents_IDList = ds_map_find_value(focusedChainSubMap, "vizSetIDList");
			}
		}
		if (functionChainContents_IDList != undefined) {
			// Select top of the content list
			if (functionChainContents_hop > -1) {
				if (ds_list_find_index(functionChainContents_IDList, functionChainContents_hop) > -1) {
					//currentTopViewRow = ds_list_find_index(functionChainContents_IDList, functionChainContents_hop);
				}
				functionChainContents_hop = -1;
			}
		}
	}
		
		
		
	// loop over the vizSetIDList and draw the data in each of the chain entries
	if (is_numeric(functionChainContents_IDList)) {
		if (ds_exists(functionChainContents_IDList, ds_type_list)) {
			
			var entryIDListSize = ds_list_size(functionChainContents_IDList);
			scrollBarListHeight = entryIDListSize
	
			for (var j = 0; j < entryIDListSize; j++) {
						
				// Get map of current entry
				var currentEntry = ds_list_find_value(functionChainContents_IDList, j);
				var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
				
				// make sure the current entry's map exists
				if (!is_numeric(currentEntrySubMap)) continue;
				if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
				
				// get the wordID (or unitID is this is a stackChain)
				var currentWordID = ds_map_find_value(currentEntrySubMap, (chainType == "stackChain") ? "unit" : "word");
				
				if (currentWordID == undefined) continue;
				
				var currentEntryAligned = false;
				var currentWordInfoCol;
				currentWordInfoCol[0] = "";
		
				// Set size of rectangle around word
				var rectX1 = x;
				var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
				var rectX2 = x + windowWidth - global.scrollBarWidth;
				var rectY2 = rectY1 + strHeight;
				var mouseover = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeader;
				
				var highlightEntryRect = false;

				// Draw red rectangles if stretch word
				if (chainType == "rezChain" or chainType == "trackChain") {
					if (currentWordID != undefined) {
						currentEntryAligned = ds_map_find_value(currentEntrySubMap, "alignEntry");
						if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, currentWordID - 1)) {
							draw_set_alpha(0.25);
							draw_set_color(c_red);
							draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, false);
							currentEntryAligned = false;
						}
					}
				}
			
				// Sets the link focused in the panelPane to the link focused in the main screen
				if (chainFocusedEntry == currentEntry) {
					highlightEntryRect = true;
			
					// Focus in the main screen
					if (chainType == "rezChain" or chainType == "trackChain") {
						ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, currentWordID - 1, true);
					}
				}
				else if (mouseover and ableToBeMouseOver) {
					ableToBeMouseOver = false;
					highlightEntryRect = true;
			
					// if the user clicks on the currentEntry in the chainContents, let's focus the chain and its currentEntry
					if (device_mouse_check_button_released(0, mb_left) and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
						obj_chain.currentFocusedChainID = chainID;
						ds_map_replace(chainSubMap, "focused", currentEntry);
					}
				}
				draw_set_alpha(1);
	
				// Check for double click
				if (mouseover) {
					if (device_mouse_check_button_released(0, mb_left)) {
						if (doubleClickTimer > -1) {
				
							var rowInLineGrid = -1;
				
							// Set double clicked word to center display row, if possible
							if (functionChainList_currentTab == functionChainList_tabStackBrush
							or functionChainList_currentTab == functionChainList_tabClique) {
								var currentUnitID = currentWordID;
								rowInLineGrid = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
							}
							else {
								var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
								rowInLineGrid = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
							}
					
							if (rowInLineGrid >= 0 and rowInLineGrid < ds_grid_height(obj_control.currentActiveLineGrid)) {
								var linePixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
								obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
							}
						}
						else {
							doubleClickTimer = 0;
						}
					}	
				}
				
				var currentTagMap = ds_map_find_value(currentEntrySubMap, "tagMap");
		
				scr_panelPane_drawChains1ToManyInnerLoop(chain1toManyColFieldList, currentEntry, currentWordID, currentTagMap, textPlusY, rectY1, rectY2, highlightEntryRect, mouseoverHeader);
				
			
				if (functionChainList_currentTab == functionChainList_tabRezBrush) {
					
					// TEMPORARILY TAKING OUT: the align individual entry button
					/*
					var alignRectX1 = x + windowWidth - global.scrollBarWidth - strHeight - alignRectSize;
					var alignRectY1 = y + textMarginTop + textPlusY - (alignRectSize / 2) + scrollPlusY + 1;
					var alignRectX2 = x + windowWidth - global.scrollBarWidth - strHeight;
					var alignRectY2 = y + textMarginTop + textPlusY + (alignRectSize / 2) + scrollPlusY - 1;
		
				 	if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, alignRectX1, alignRectY1, alignRectX2, alignRectY2)) {
						scr_createTooltip(alignRectX1, mean(alignRectY1, alignRectY2), "Align link", obj_tooltip.arrowFaceRight);
						draw_set_color(c_purple);
						draw_set_alpha(0.5);
						draw_rectangle(alignRectX1 - clipX, alignRectY1 - clipY, alignRectX2 - clipX, alignRectY2 - clipY, false);
				
						if (device_mouse_check_button_released(0, mb_left)
						and chainAligned and not ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, currentWordID - 1)) {
							currentEntryAligned = !currentEntryAligned;
							ds_map_replace(currentEntrySubMap, "alignEntry", currentEntryAligned);
						}
					}
					
					draw_sprite_ext(spr_align, !currentEntryAligned, mean(alignRectX1, alignRectX2) - clipX, mean(alignRectY1, alignRectY2) - clipY, 1, 1, 0, c_white, 1);
					*/
				}
			
				textPlusY += strHeight;
			}
		}
	}
	
	
	

	var scrollBarListSize = 0;
	if (is_numeric(functionChainContents_IDList)) {
		if (ds_exists(functionChainContents_IDList, ds_type_list)) {
			scrollBarListSize = ds_list_size(functionChainContents_IDList);
		}
	}

	var scrollBarBackColor = global.colorThemeSelected1;
	if (scrollBarListSize > 1000) {
		scrollBarBackColor = global.colorThemeSelected2;
	}

	scr_scrollBar(scrollBarListSize, focusedElementY, strHeight, tabHeight,
		scrollBarBackColor, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);

	// draw background for headers
	draw_set_alpha(1);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + tabHeight - clipY, false);


	// draw headers for chainContents columns
	var chainContents1toManyFieldListSize = ds_list_size(chain1toManyColFieldList);
	var colAmount = 3 + chainContents1toManyFieldListSize;
	for (var i = 0; i < colAmount; i++) {
		var colRectX1 = x + (i * (windowWidth / colAmount));
		var colRectY1 = y;
		var colRectX2 = colRectX1 + (windowWidth / colAmount);
		if (colAmount == 3 && i == 2) {
			var colRectX2 = colRectX1 + (windowWidth);	
		}
		var colRectY2 = colRectY1 + windowHeight;
		var mouseoverColHeader = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, colRectX1, colRectY1, colRectX2, colRectY1 + tabHeight);
	
		// get header string for static columns
		var colName = "";
		switch (i) {
			case 0:
				colName = "unitSeq";
				break;
			case 1:
				if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					colName = "speaker"; // stacks
				}
				else {
					colName = "wordOrder"; // rez & track
				}
				break;
			case 2:
				if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					colName = "utterance"; // stacks
				}
				else {
					colName = "text"; // rez & track
				}
				break;
			default:
				colName = "N/A";
				break;
		}
		
		
		// make headers not overlap with each other
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
		
		// headers for dynamic columns
		if (i >= 3) {
			var currentField = ds_list_find_value(chain1toManyColFieldList, i - 3);
			if (is_string(currentField)) {
				colName = currentField;
			}
			
			// dropdown button to switch dynamic fields
			var dropDownButtonX1 = colRectX1 + ((colRectX2 - colRectX1) * 0.8);
			var dropDownButtonY1 = colRectY1 + (tabHeight * 0.25);
			var dropDownButtonX2 = colRectX1 + ((colRectX2 - colRectX1) * 0.95);
			var dropDownButtonY2 = colRectY1 + (tabHeight * 0.75);
			var mouseoverDropDownButton = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2);
			draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, c_white, 1);
			if (mouseoverDropDownButton && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox)) {
				draw_set_color(global.colorThemeBorders);
				draw_set_alpha(1);
				draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				if (mouse_check_button_released(mb_left)) {
					obj_control.chain1ToManyColFieldToChange = i - 3;
					scr_createDropDown(colRectX1, colRectY1 + tabHeight, scr_getChainEntryFieldList(chainType), global.optionListTypeChain1ToManyField);
				}
			}
			
			// right-click on header
			if (mouseoverColHeader && mouse_check_button_released(mb_right) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox)) {
				obj_control.chain1ToManyColFieldToChange = i - 3;
				var headerRightClickList = ds_list_create();
				ds_list_add(headerRightClickList, "Create Field");
				scr_createDropDown(colRectX1, colRectY1 + tabHeight, headerRightClickList, global.optionListTypeChain1ToManyHeaderRightClick);
			}
		}
		
		// draw header name
		draw_set_color(global.colorThemeText);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		scr_adaptFont(colName, "S");
		draw_text(colRectX1 + 4 - clipX, y - clipY, colName);
		
		// draw vertical line between columns
		if (i > 0) {
			draw_set_color(global.colorThemeBorders);
			draw_set_alpha(0.5);
			draw_line(colRectX1 - clipX, colRectY1 - clipY, colRectX1 - clipX, colRectY2 - clipY);
			draw_set_alpha(1);
		}
	}

	// draw horizontal line between headers and contents
	draw_line(x - clipX, y + tabHeight - clipY, x + windowWidth - clipX, y + tabHeight - clipY);

	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainContents
	if (clickedIn) {
	
		// Scroll up with mouse/key
		if ((mouse_wheel_up() || keyboard_check(vk_up)) and (obj_panelPane.holdUp < 2 || obj_panelPane.holdUp > 30)) {
			scrollPlusYDest += strHeight;
		}
	
		// Scroll down with mouse/key
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			scrollPlusYDest -= strHeight;
		}
	
		// CTRL+UP and CTRL+DOWN
		if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
			scrollPlusYDest = 100;
		}
		if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
			scrollPlusYDest = -999999999999;
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			scrollPlusYDest += (windowHeight);
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			scrollPlusYDest -= (windowHeight);
		}
	}


	scr_surfaceEnd();

}