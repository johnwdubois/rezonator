function scr_panelPane_drawChainListLoopClipped() {
	
	/*
		Purpose: draw the chains for whatever tab you are on, if a user clicks on a chain then focus it and
				set chainContents panelPane to look at that chain
	*/

	
	x = 0;
	windowWidth = camera_get_view_width(camera_get_active()) / 2;
	
	var drawScrollbar = (chainViewOneToMany || functionChainList_currentTab == functionChainList_tabLine);
	var scrollbarWidth = 0;//(drawScrollbar) ? global.scrollBarWidth : 0;
	
	var checkBoxScale = 1* max(global.fontSize,3)/5;
	var optionsIconScale = 1;
	var optionsIconRad = sprite_get_width(spr_toggleDraw) * optionsIconScale * 0.7;
	
	
	// get the instance ID for the chainContents pane so we can easily reference it
	var chainContentsPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			chainContentsPanelPaneInst = self.id;
		}
	}
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : chainContentsPanelPaneInst.scrollPlusY;
	var ableToMouseoverOption = true;
	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_flyout);


	// get list of chains for this tab
	var listOfChains = -1;
	var listOfChainsKey = "";
	var tabChainType = "";
	var filterList = scr_getFilterList();
	var selectedList = -1;
	var hiddenList = -1;
	if (functionChainList_currentTab == functionChainList_tabRezBrush) {
		listOfChainsKey = "rezChainList";
		tabChainType = "rezChain";
		selectedList = obj_control.selectedRezChainList;
		hiddenList = obj_control.hiddenRezChainList;
	}
	else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
		listOfChainsKey = "trackChainList";
		tabChainType = "trackChain";
		selectedList = obj_control.selectedTrackChainList;
		hiddenList = obj_control.hiddenTrackChainList;
	}
	else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
		listOfChainsKey = "stackChainList";
		tabChainType = "stackChain";
		selectedList = obj_control.selectedStackChainList;
		hiddenList = obj_control.hiddenStackChainList;
	}
	
	// do lineList loop if user is on Read/Unit tab
	if (functionChainList_currentTab == functionChainList_tabLine) {
		scr_panelPane_drawLineListLoopClipped();
		exit;
	}
	else if (functionChainList_currentTab == functionChainList_tabShow) {
		scr_panelPane_drawShowList();
		exit;
	}
	
	listOfChains = ds_map_find_value(global.nodeMap, listOfChainsKey);
	
	var strHeight = string_height("0") * 1.5;
	

	// Set text margin area
	var filterRectMargin = 8;
	var filterRectSize = (strHeight / 2) + 5;
	var checkboxColX = x;
	var checkboxColWidth = filterRectMargin + (filterRectSize * 2);
	var checkboxSize = checkboxColWidth * 0.35;
	var optionsColX = checkboxColX + checkboxColWidth;
	var optionsColWidth = windowWidth * 0.14;
	var numColX = optionsColX + optionsColWidth;
	var numColWidth = windowWidth * 0.07;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth / 4;
	var textColX = nameColX + nameColWidth;
	
	
	var filterChainX = (functionChainList_currentTab == functionChainList_tabRezBrush) ? optionsColX + (optionsColWidth * 0.25) : optionsColX + (optionsColWidth * 0.33);
	var visibleChainX = (functionChainList_currentTab == functionChainList_tabRezBrush) ? optionsColX + (optionsColWidth * 0.5) : optionsColX + (optionsColWidth * 0.66);
	var alignChainX = optionsColX + (optionsColWidth * 0.75);
	

	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var textBuffer = 8;
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	var mouseoverScrollBar = false;
	if (drawScrollbar) {
		mouseoverScrollBar = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + headerHeight, x + windowWidth, y + windowHeight);
	}

	var focusedElementY = -1;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;

	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);

	scr_surfaceStart();
	
	var listOfChainsSize = ds_list_size(listOfChains);
	for (var i = 0; i < listOfChainsSize; i++) {
	
		if (y + headerHeight + relativeScrollPlusY + textPlusY < y - strHeight
		or y + headerHeight + relativeScrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			continue;
		}
		else if (y + headerHeight + relativeScrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			break;
		}
		else if (i >= 0 && i < listOfChainsSize) {
			
			// get submap of current chain
			var currentChainID = ds_list_find_value(listOfChains, i);
			var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChainID);
			
			// make sure that the chain's submap exists
			if (!is_numeric(currentChainSubMap)) continue;
			if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
			
			// get info of current chain
			var currentChainType = ds_map_find_value(currentChainSubMap, "type");
			var currentChainName = ds_map_find_value(currentChainSubMap, "name");
			var currentChainColor = ds_map_find_value(currentChainSubMap, "chainColor");
			var currentChainSelected = ds_map_find_value(currentChainSubMap, "selected");
			var currentChainFiltered = ds_map_find_value(currentChainSubMap, "filter");
			var currentChainAlign = ds_map_find_value(currentChainSubMap, "alignChain");
			var currentChainVisible = ds_map_find_value(currentChainSubMap, "visible");
			var currentChainCaption = "";
			var setIDList = ds_map_find_value(currentChainSubMap, "setIDList");
			var vizSetIDList = ds_map_find_value(currentChainSubMap, "vizSetIDList");
			
			if (!is_numeric(currentChainSelected)) currentChainSelected = false;
			
			if (is_numeric(setIDList) || is_numeric(vizSetIDList)) {
				if (ds_exists(setIDList, ds_type_list) || ds_exists(vizSetIDList, ds_type_list)) {
					var setIDListSize = ds_list_size(setIDList);
					
					// chain captions!
					// first, we will check if the stack has a caption specified in its submap
					currentChainCaption = ds_map_find_value(currentChainSubMap, "caption");
						
					// if it does not have a caption specified, we will show its contents in the chainList window
					if (string_length(string(currentChainCaption)) < 1 || !is_string(currentChainCaption)) {
						currentChainCaption = "";
						for (var j = 0; j < setIDListSize; j++) {
							var currentEntry = ds_list_find_value(vizSetIDList, j);
							var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
							
							if (currentChainType == "stackChain") {
								var currentUnitID = ds_map_find_value(currentEntrySubMap, "unit");
								currentChainCaption += scr_getUnitText(currentUnitID) + " ";
							}
							else {
								currentChainCaption = "";
							}
						}
					}
	
					// Get dimensions of rectangle around chain name
					var chainNameRectX1 = x;
					var chainNameRectY1 = y + headerHeight + textPlusY + relativeScrollPlusY - (strHeight / 2);
					var chainNameRectX2 = x + windowWidth - scrollbarWidth;
					var chainNameRectY2 = chainNameRectY1 + strHeight;
					var mouseoverChainNameRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2) && !mouseoverHeaderRegion && !mouseoverScrollBar;
					
					// get dimensions of checkbox rect
					var checkboxRectX1 = checkboxColX + (checkboxColWidth / 2) - (checkboxSize / 2);
					var checkboxRectY1 = mean(chainNameRectY1, chainNameRectY2) - (checkboxSize / 2);
					var checkboxRectX2 = checkboxRectX1 + checkboxSize;
					var checkboxRectY2 = checkboxRectY1 + checkboxSize;
					var mouseoverCheckbox = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, checkboxRectX1, checkboxRectY1, checkboxRectX2, checkboxRectY2) && !mouseoverHeaderRegion && !mouseoverScrollBar;
					
					// Check mouse clicks to focus a chain in the list
					if (mouseoverChainNameRect) {
						if (obj_control.showDevVars) {
							draw_set_color(c_red);
							draw_circle(mouse_x, mouse_y, 5, true);
						}
						
						if (device_mouse_check_button_released(0, mb_left) and !mouseoverCancel) {
		
							if (obj_chain.currentFocusedChainID != currentChainID) {
								// Focuses on selected chain
								switch (functionChainList_currentTab) {
									case functionChainList_tabRezBrush:
										obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
										break;
									case functionChainList_tabTrackBrush:
										obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
										break;
									case functionChainList_tabStackBrush:
										obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
										break;
									default:
										break;
								}
				
								obj_chain.currentFocusedChainID = currentChainID;
				
								// Set chain to focus in the main screen
								if (obj_chain.mouseLineWordID >= 0 and obj_chain.mouseLineWordID < ds_grid_height(obj_control.wordDrawGrid)) {
									scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, false);
								}
			
								// Set scroll range in the chain list
								with (obj_panelPane) {
									functionChainContents_scrollRangeMin[functionChainList_currentTab] = 0;
									functionChainContents_scrollRangeMax[functionChainList_currentTab] = functionChainContents_maxScrollRange;
								}
								if (doubleClickTimer > -1) {	
									var rowInLineGrid = -1;
									var currentUnitIDList = -1;
									var currentUnitID = -1;
									var currentEntry = ds_list_find_value(setIDList, 0);
									var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
						
									if (functionChainList_currentTab == functionChainList_tabRezBrush || functionChainList_currentTab == functionChainList_tabTrackBrush) {
										var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
										currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
									}
									else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
										currentUnitID = ds_map_find_value(currentEntrySubMap, "unit");
									}
					
									rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
					
									// Set first unit of the double clicked chain to center display row, if possible
									if (rowInLineGrid >= 0 and rowInLineGrid < ds_grid_height(obj_control.lineGrid)) {
										// Replacement of centerDisplayRow
										var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
										obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
									}
								}
								else {
									doubleClickTimer = 0;
								}
							}
						}
					}

					// right-click on chain in chainList
					if (mouseoverChainNameRect && mouse_check_button_pressed(mb_right) && !mouseoverCancel) {

						obj_chain.currentFocusedChainID = currentChainID;
						obj_control.selectedChainID = obj_chain.currentFocusedChainID 

						var dropDownOptionList = ds_list_create();
						if (functionChainList_currentTab == functionChainList_tabStackBrush) {
							ds_list_add(dropDownOptionList, "Rename", "Recolor", "Delete", "Caption", "Clip");
						}
						else {
							ds_list_add(dropDownOptionList, "Rename", "Recolor", "Delete");
						}
						if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
							scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeChainList);
						}
					}
	
					// Color codes the chain lists for User
					draw_set_color(merge_color(currentChainColor, global.colorThemeBG, (obj_chain.currentFocusedChainID == currentChainID) ? 0.65: 0.75)); //soften the color
					draw_rectangle(chainNameRectX1 - clipX, chainNameRectY1 - clipY, chainNameRectX2 - clipX, chainNameRectY2 - clipY, false);
	
					// Outline the rectangle in black
					if (obj_chain.currentFocusedChainID == currentChainID) {
						focusedRowRectY1 = chainNameRectY1;
						focusedRowRectY2 = chainNameRectY2;
						focusedElementY = y + headerHeight + relativeScrollPlusY + textPlusY;
					}
					
					// draw checkbox
					if (mouseoverCheckbox) {
						scr_createTooltip(mean(checkboxRectX1, checkboxRectX2), checkboxRectY2, "Select", obj_tooltip.arrowFaceUp);
					}
					if (currentChainSelected) {
						draw_set_color(merge_color(currentChainColor, global.colorThemeBG, 0.9));
						draw_roundrect(checkboxRectX1 - clipX, checkboxRectY1 - clipY, checkboxRectX2 - clipX, checkboxRectY2 - clipY, false);
					}
					else if (mouseoverCheckbox) {
						draw_set_color(merge_color(currentChainColor, global.colorThemeBG, 0.9));
						draw_roundrect(checkboxRectX1 - (strHeight * 0.15) - clipX, checkboxRectY1 - (strHeight * 0.15) - clipY, checkboxRectX2 + (strHeight * 0.15) - clipX, checkboxRectY2 + (strHeight * 0.15) - clipY, false);
					}
					draw_set_color(global.colorThemeBorders);
					scr_drawRectWidth(checkboxRectX1 - clipX, checkboxRectY1 - clipY, checkboxRectX2 - clipX, checkboxRectY2 - clipY, 2);
					if (currentChainSelected) draw_sprite_ext(spr_checkmark, 0, mean(checkboxRectX1, checkboxRectX2) - clipX, mean(checkboxRectY1, checkboxRectY2) - clipY, checkBoxScale , checkBoxScale , 0, c_white, 1);
					
					// click on checkbox
					if (mouseoverCheckbox && mouse_check_button_released(mb_left) && !mouseoverCancel) {
						currentChainSelected = !currentChainSelected;
						scr_setMap(currentChainSubMap, "selected", currentChainSelected);
						if (currentChainSelected && ds_list_find_index(selectedList, currentChainID) == -1) {
							ds_list_add(selectedList, currentChainID);
						}
						else if (!currentChainSelected) {
							scr_deleteFromList(selectedList, currentChainID);
						}
					}
					
					// setup filter/align/visible buttons
					var optionsChainY = floor(mean(chainNameRectY1, chainNameRectY2));
					var mouseoverFilterChain = scr_pointInCircleClippedWindow(mouse_x, mouse_y, filterChainX, optionsChainY, optionsIconRad) && !mouseoverCancel && ableToMouseoverOption && !mouseoverHeaderRegion;
					var mouseoverVisibleChain = scr_pointInCircleClippedWindow(mouse_x, mouse_y, visibleChainX, optionsChainY, optionsIconRad) && !mouseoverCancel && !mouseoverFilterChain && ableToMouseoverOption && !mouseoverHeaderRegion;
					var mouseoverAlignChain = scr_pointInCircleClippedWindow(mouse_x, mouse_y, alignChainX, optionsChainY, optionsIconRad) && !mouseoverCancel && !mouseoverFilterChain && !mouseoverVisibleChain && functionChainList_currentTab == functionChainList_tabRezBrush && ableToMouseoverOption && !mouseoverHeaderRegion;
					draw_set_color(merge_color(global.colorThemeSelected1, currentChainColor, 0.3));
					
					// mouseover & click on filter
					if (mouseoverFilterChain) {
						ableToMouseoverOption = false;
						draw_circle(filterChainX - clipX, optionsChainY - clipY, optionsIconRad, false);
						if (mouse_check_button_released(mb_left)) {
							currentChainFiltered = !currentChainFiltered;
							scr_setMap(currentChainSubMap, "filter", currentChainFiltered);
							if (currentChainFiltered && ds_list_find_index(filterList, currentChainID) == -1) ds_list_add(filterList, currentChainID);
							else if (!currentChainFiltered) scr_deleteFromList(filterList, currentChainID);
							
							// update the filter if we need to
							if (obj_control.filterGridActive) {
								if (ds_list_size(filterList) > 0) scr_renderFilter();
								else scr_disableFilter();
							}
						}
						scr_createTooltip(filterChainX, optionsChainY + optionsIconRad, "Filter", obj_tooltip.arrowFaceUp);
					}
					// mouseover & click on visible
					if (mouseoverVisibleChain) {
						ableToMouseoverOption = false;
						draw_circle(visibleChainX - clipX, optionsChainY - clipY, optionsIconRad, false);
						if (mouse_check_button_released(mb_left)) {
							currentChainVisible = !currentChainVisible;
							scr_setMap(currentChainSubMap, "visible", currentChainVisible);
							if (!currentChainVisible && ds_list_find_index(hiddenList, currentChainID) == -1) ds_list_add(hiddenList, currentChainID);
							else if (currentChainVisible) scr_deleteFromList(hiddenList, currentChainID);
						}
						scr_createTooltip(visibleChainX, optionsChainY + optionsIconRad, "Visible", obj_tooltip.arrowFaceUp);
					}
					// mouseover & click on align
					if (mouseoverAlignChain) {
						ableToMouseoverOption = false;
						draw_circle(alignChainX - clipX, optionsChainY - clipY, optionsIconRad, false);
						if (mouse_check_button_released(mb_left)) {
							currentChainAlign = !currentChainAlign;
							scr_setMap(currentChainSubMap, "alignChain", currentChainAlign);
						}
						scr_createTooltip(alignChainX, optionsChainY + optionsIconRad, "Align", obj_tooltip.arrowFaceUp);
					}
					
					// draw filter/align/visible buttons
					draw_sprite_ext(spr_filterIcons, !currentChainFiltered, filterChainX - clipX, optionsChainY - clipY, 1, 1, 0, global.colorThemeText, 1);
					draw_sprite_ext(spr_toggleDraw, currentChainVisible, visibleChainX - clipX, optionsChainY - clipY, 1, 1, 0, global.colorThemeText, 1);
					if (functionChainList_currentTab == functionChainList_tabRezBrush) draw_sprite_ext(spr_align, !currentChainAlign, alignChainX - clipX, optionsChainY - clipY, 1, 1, 0, global.colorThemeText, 1);
					
					
					
					
					// set up stuff for drawing text
					draw_set_color(global.colorThemeText);
					draw_set_alpha(1);
					draw_set_halign(fa_left);
					draw_set_valign(fa_middle);
					scr_adaptFont(currentChainName, "M");
					
					// draw text: number column
					draw_text(floor(numColX + textBuffer) - clipX, floor(y + headerHeight + relativeScrollPlusY + textPlusY) - clipY, string(i + 1));
	
					// draw text: name column
					draw_text(floor(nameColX + textBuffer) - clipX, floor(y + headerHeight + relativeScrollPlusY + textPlusY) - clipY, currentChainName);
					
					// draw text: text/caption column
					if (currentChainCaption != "") {
						draw_set_alpha(0.7);
						scr_adaptFont(string(currentChainCaption), "S");
						draw_text(floor(textColX + textBuffer) - clipX, floor(y + headerHeight + relativeScrollPlusY + textPlusY) - clipY, string(currentChainCaption));
						draw_set_alpha(1);
					}
					
					
	



					// Get height of chain name
					textPlusY += strHeight;
				}
			}
		}
	}
	

	with (obj_panelPane) {
		functionChainList_focusedChainIndex = ds_list_find_index(listOfChains, obj_chain.currentFocusedChainID);
	}
	
	// get color of focused chain
	if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
		if (is_numeric(focusedChainSubMap)) {
			if (ds_exists(focusedChainSubMap, ds_type_map)) {
				var focusedChainColor = ds_map_find_value(focusedChainSubMap, "chainColor")
				with (obj_panelPane) {
					functionChainContents_BGColor = focusedChainColor;
				}
			}
		}
	}
	
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	var instToScroll = (drawScrollbar) ? self.id : chainContentsPanelPaneInst;
	if (clickedIn) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			
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
		
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			
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
	

	// draw focus outline
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}
	
	// only draw scrollbar if we are in 1toMany view
	if (drawScrollbar) {
		scr_scrollBar(listOfChainsSize, focusedElementY, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}
	
	
	

	scr_surfaceEnd();
	
	
	
	// draw column headers
	for (var i = 0; i < 5; i++) {
		
		// get column data
		var headerRectX1 = 0;
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			headerRectX1 = checkboxColX;
			colWidth = checkboxColWidth;
			colText = "";
		}
		else if (i == 1) {
			headerRectX1 = optionsColX;
			colWidth = optionsColWidth;
			colText = "";
		}
		else if (i == 2) {
			headerRectX1 = numColX;
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 3) {
			headerRectX1 = nameColX;
			colWidth = nameColWidth;
			colText = "Name";
		}
		else if (i == 4) {
			headerRectX1 = textColX;
			colWidth = windowWidth - headerRectX1;
			colText = "Text";
		}
		
		// get header coordinates
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// draw header rects
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, true);
		
		// draw checkbox header
		if (i == 0) {
			var allChainsSelected = (ds_list_size(listOfChains) == ds_list_size(selectedList) && ds_list_size(listOfChains) > 0);
			var headerCheckboxX1 = mean(headerRectX1, headerRectX2) - (checkboxSize / 2);
			var headerCheckboxY1 = mean(headerRectY1, headerRectY2) - (checkboxSize / 2);
			var headerCheckboxX2 = headerCheckboxX1 + checkboxSize;
			var headerCheckboxY2 = headerCheckboxY1 + checkboxSize;
			var mouseoverHeaderCheckbox = point_in_rectangle(mouse_x, mouse_y, headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2) && ds_list_size(listOfChains) > 0;
			if (mouseoverHeaderCheckbox) {
				draw_set_color(merge_color(global.colorThemeSelected2, global.colorThemeBG, 0.4));
				draw_roundrect(headerCheckboxX1 - (strHeight * 0.15), headerCheckboxY1 - (strHeight * 0.15), headerCheckboxX2 + (strHeight * 0.15), headerCheckboxY2 + (strHeight * 0.15), false);
				
				var tooltipText = (allChainsSelected) ? "Deselect all" : "Select all";
				scr_createTooltip(mean(headerCheckboxX1, headerCheckboxX2), headerCheckboxY2, tooltipText, obj_tooltip.arrowFaceUp);
				
				// click on checkbox header
				if (mouse_check_button_released(mb_left)) {
					scr_setValueForAllChains(tabChainType, "selected", (allChainsSelected) ? false : true);
					allChainsSelected = (ds_list_size(listOfChains) == ds_list_size(selectedList));
				}
			}
			
			// draw checkmark for checkbox header
			if (allChainsSelected) {
				draw_set_color(merge_color(global.colorThemeSelected2, global.colorThemeBG, 0.6));
				draw_rectangle(headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2, false);
				draw_sprite_ext(spr_checkmark, 0, mean(headerCheckboxX1, headerCheckboxX2), mean(headerCheckboxY1, headerCheckboxY2), checkBoxScale , checkBoxScale , 0, c_white, 1);
			}
			
			draw_set_color(global.colorThemeBorders);
			scr_drawRectWidth(headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2, 2);
		}
		
		// filter all / visible all / align all chain options
		if (i == 1) {
			
			// filter all
			var allChainsFiltered = (ds_list_size(listOfChains) == ds_list_size(filterList) && ds_list_size(listOfChains) > 0);
			var filterAllX = filterChainX;
			var filterAllY = mean(headerRectY1, headerRectY2);
			var mouseoverFilterAll = scr_pointInCircleClippedWindow(mouse_x, mouse_y, filterAllX, filterAllY, optionsIconRad) && !mouseoverCancel;
			if (mouseoverFilterAll) {
				draw_set_color(global.colorThemeSelected1);
				draw_circle(filterAllX, filterAllY, optionsIconRad, false);
				scr_createTooltip(filterAllX, filterAllY + optionsIconRad, "Filter all", obj_tooltip.arrowFaceUp);
				
				if (mouse_check_button_pressed(mb_left)) {
					scr_setValueForAllChains(tabChainType, "filter", (allChainsFiltered) ? false : true);
					// update the filter if we need to
					if (obj_control.filterGridActive) {
						if (ds_list_size(filterList) > 0) scr_renderFilter();
						else scr_disableFilter();
					}
				}
			}
			draw_sprite_ext(spr_filterIcons, !allChainsFiltered, filterAllX, filterAllY, 1, 1, 0, global.colorThemeText, 1);
			
			
			// visible all
			var allChainsHidden = (ds_list_size(listOfChains) == ds_list_size(hiddenList) && ds_list_size(listOfChains) > 0);
			var hideAllX = visibleChainX;
			var hideAllY = mean(headerRectY1, headerRectY2);
			var mouseoverHideAll = scr_pointInCircleClippedWindow(mouse_x, mouse_y, hideAllX, hideAllY, optionsIconRad) && !mouseoverCancel;
			if (mouseoverHideAll) {
				draw_set_color(global.colorThemeSelected1);
				draw_circle(hideAllX, hideAllY, optionsIconRad, false);
				scr_createTooltip(hideAllX, hideAllY + optionsIconRad, "Hide all", obj_tooltip.arrowFaceUp);
				
				if (mouse_check_button_pressed(mb_left)) {
					scr_setValueForAllChains(tabChainType, "visible", (allChainsHidden) ? true : false);
				}
			}
			draw_sprite_ext(spr_toggleDraw, !allChainsHidden, hideAllX, hideAllY, 1, 1, 0, global.colorThemeText, 1);
					
		}
		
		
		
		// draw header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(colText, "M");
		draw_text(headerTextX, headerTextY, colText);
		
		// dividing lines
		if (i > 0) {
			draw_set_color(global.colorThemeBorders);
			draw_line(headerRectX1, y, headerRectX1, y + headerHeight);
			draw_set_color(global.colorThemeBG);
			draw_line(headerRectX1, y + headerHeight, headerRectX1, y + windowHeight);
		}
	}

	// border for headers
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + windowWidth - 2, y + headerHeight, true);

}
