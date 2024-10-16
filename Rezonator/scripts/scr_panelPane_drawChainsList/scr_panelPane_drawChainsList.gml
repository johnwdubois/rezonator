function scr_panelPane_drawChainsList() {
	
	/*
		Purpose: draw the chains for whatever tab you are on, if a user clicks on a chain then focus it and
				set chainContents panelPane to look at that chain
	*/
	
	var drawScrollbar = (chainViewOneToMany || functionChainList_currentTab == NAVTAB_UNIT);
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
	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_flyout) || instance_exists(obj_sizeWindow) || scrollBarHolding;


	// get list of chains for this tab
	var chainNavList = -1;
	var chainNavListKey = "";
	var tabChainType = "";
	var filterList = scr_getFilterList(false);
	var selectedList = -1;
	var hiddenList = -1;
	if (functionChainList_currentTab == NAVTAB_RESONANCE) {
		chainNavListKey = "resonanceNavList";
		tabChainType = "resonance";
		selectedList = obj_control.selectedRezChainList;
		hiddenList = obj_control.hiddenRezChainList;
	}
	else if (functionChainList_currentTab == NAVTAB_TRACK) {
		chainNavListKey = "trailNavList";
		tabChainType = "trail";
		selectedList = obj_control.selectedTrackChainList;
		hiddenList = obj_control.hiddenTrackChainList;
	}
	else if (functionChainList_currentTab == NAVTAB_STACK) {
		chainNavListKey = "stackNavList";
		tabChainType = "stack";
		selectedList = obj_control.selectedStackChainList;
		hiddenList = obj_control.hiddenStackChainList;
	}
	
	chainNavList = global.nodeMap[? chainNavListKey];
	var strHeight = string_height("0") * 1.5;
	with (obj_panelPane) leftPaneStrHeight = strHeight;
	

	// checkbox sizes
	var filterRectMargin = 8;
	var filterRectSize = (strHeight / 2) + 5;
	var checkboxColWidth = filterRectMargin + (filterRectSize * 2);
	var checkboxSize = checkboxColWidth * 0.35;
	
	// column positions and widths
	var optionsColX = x;
	var optionsColWidth = (checkboxColWidth / 1.3) * 4;
	var moreOptionsX = optionsColX + (optionsColWidth * 0.8);
	var numColX = optionsColX + optionsColWidth;
	var numColWidth = windowWidth * 0.07;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.25;
	var textColX = nameColX + nameColWidth;
	var textColWidth = windowWidth * 0.4;
	
	

	
	var filterChainX = optionsColX + (optionsColWidth * 0.4);
	var visibleChainX = optionsColX + (optionsColWidth * 0.6);
	var alignChainX = optionsColX + (optionsColWidth * 0.75); // alignChain button will be out of commission temporarily(?)
	var stackingActiveRad = checkboxSize / 2;
	var stackingActiveRadX = x + windowWidth - global.scrollBarWidth - (stackingActiveRad * 1.5);
	

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
	
	var listOfChainsSize = ds_list_size(chainNavList);
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
			var currentChainID = ds_list_find_value(chainNavList, i);
			var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChainID);
			
			// make sure that the chain's submap exists
			if (!scr_isNumericAndExists(currentChainSubMap, ds_type_map)) continue;
			
			// get data of current chain
			var currentChainType = currentChainSubMap[? "type"];
			var currentChainName = currentChainSubMap[? "name"];
			var currentChainColor = currentChainSubMap[? "chainColor"];
			var currentChainSelected = currentChainSubMap[? "selected"];
			var currentChainFiltered = currentChainSubMap[? "filter"];
			var currentChainAlign = currentChainSubMap[? "alignChain"];
			var currentChainVisible = currentChainSubMap[? "visible"];
			var currentChainCaption = "";
			var setIDList = currentChainSubMap[? "setIDList"];
			var vizSetIDList = currentChainSubMap[? "vizSetIDList"];
			
			// if this is a stack, verify that it has a stacking
			if (functionChainList_currentTab == NAVTAB_STACK) {
				var currentChainStacking = currentChainSubMap[? "stacking"];
				if (!is_string(currentChainStacking)) {
					currentChainStacking = "Default";
					currentChainSubMap[? "stacking"] = currentChainStacking;
				}
			}
			
			if (!is_numeric(currentChainSelected)) currentChainSelected = false;
			
			if (is_numeric(setIDList) && is_numeric(vizSetIDList)) {
				if (ds_exists(setIDList, ds_type_list) && ds_exists(vizSetIDList, ds_type_list)) {
					var setIDListSize = ds_list_size(setIDList);
					
					// chain captions!
					// first, we will check if the stack has a caption specified in its submap
					currentChainCaption = (currentChainType == "stack") ? ds_map_find_value(currentChainSubMap, "caption") : "";
					
					// if it does not have a caption specified, we will show its contents in the chainNavList window
					if (currentChainType == "stack") {
						if (string_length(string(currentChainCaption)) < 1 || !is_string(currentChainCaption)) {
							currentChainCaption = "";
							for (var j = 0; j < setIDListSize; j++) {
								var currentEntry = ds_list_find_value(vizSetIDList, j);
								var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);

								var currentUnitID = ds_map_find_value(currentEntrySubMap, "unit");
								var currentUnitSubMap = global.nodeMap[?currentUnitID];
								if (scr_isNumericAndExists(currentUnitSubMap,ds_type_map)) {
									currentChainCaption += scr_getUnitText(currentUnitSubMap) + " ";
								}
								if (string_width(currentChainCaption) > windowWidth) break;
							}
						}
					}
	
					// Get dimensions of rectangle around chain name
					var chainNameRectX1 = x;
					var chainNameRectY1 = y + headerHeight + textPlusY + relativeScrollPlusY - (strHeight / 2);
					var chainNameRectX2 = x + windowWidth - scrollbarWidth;
					var chainNameRectY2 = chainNameRectY1 + strHeight;
					var optionsChainY = floor(mean(chainNameRectY1, chainNameRectY2));
					var mouseoverFilterChain = scr_pointInCircleClippedWindow(mouse_x, mouse_y, filterChainX, optionsChainY, optionsIconRad) && !mouseoverCancel && ableToMouseoverOption && !mouseoverHeaderRegion;
					var mouseoverVisibleChain = scr_pointInCircleClippedWindow(mouse_x, mouse_y, visibleChainX, optionsChainY, optionsIconRad) && !mouseoverCancel && !mouseoverFilterChain && ableToMouseoverOption && !mouseoverHeaderRegion;
					var mouseoverMoreChain = scr_pointInCircleClippedWindow(mouse_x, mouse_y, moreOptionsX, optionsChainY, optionsIconRad) && !mouseoverCancel && !mouseoverFilterChain && ableToMouseoverOption && !mouseoverVisibleChain && !mouseoverHeaderRegion;
					var mouseoverChainNameRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2) && !mouseoverCancel && !mouseoverHeaderRegion && !mouseoverScrollBar && !mouseoverFilterChain && !mouseoverVisibleChain;

					
					// get dimensions of checkbox rect
					var checkboxRectX1 = optionsColX + (optionsColWidth *0.2) - (checkboxSize / 2);
					var checkboxRectY1 = mean(chainNameRectY1, chainNameRectY2) - (checkboxSize / 2);
					var checkboxRectX2 = checkboxRectX1 + checkboxSize;
					var checkboxRectY2 = checkboxRectY1 + checkboxSize;
					var mouseoverCheckbox = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, checkboxRectX1, checkboxRectY1, checkboxRectX2, checkboxRectY2) && !mouseoverHeaderRegion && !mouseoverScrollBar && !mouseoverCancel;
					
					// Check mouse clicks to focus a chain in the list
					if (mouseoverChainNameRect) {
						
						obj_control.hoverTextCopy = currentChainName;
						
						if (obj_control.showDevVars) {
							draw_set_color(c_red);
							draw_circle(mouse_x, mouse_y, 5, true);
						}
						
						// left-click on chain in chainNavList
						if (device_mouse_check_button_released(0, mb_left) and !mouseoverCancel and !mouseoverCheckbox) {
							
							if (obj_chain.currentFocusedChainID != currentChainID) {
								
								// Focuses on selected chain
								switch (functionChainList_currentTab) {
									case NAVTAB_RESONANCE:
										obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
										break;
									case NAVTAB_TRACK:
										obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
										break;
									case NAVTAB_STACK:
										obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
										break;
									default:
										break;
								}
				
								obj_chain.currentFocusedChainID = currentChainID;
								obj_control.doubleClickTimer = 0;
							}
							
							
							if (obj_control.doubleClickTimer >= 1) {
									
									
								var currentUnitIDList = -1;
								var currentUnitID = -1;
								var currentEntry = ds_list_find_value(setIDList, 0);
								var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
						
								if (functionChainList_currentTab == NAVTAB_RESONANCE || functionChainList_currentTab == NAVTAB_TRACK) {
									var currentTokenID = currentEntrySubMap[? "token"];
									var currentTokenSubMap = global.nodeMap[? currentTokenID];
									currentUnitID = currentTokenSubMap[? "unit"]
								}
								else if (functionChainList_currentTab == NAVTAB_STACK) {
									currentUnitID = currentEntrySubMap[? "unit"];
								}
					
								scr_jumpToUnitTop(currentUnitID);
							}
							else {
								obj_control.doubleClickTimer = 0;
							}
							
							show_debug_message("obj_control.doubleClickTimer: " + string(obj_control.doubleClickTimer));

							
							// hold SHIFT and click to select range of chains
							if (keyboard_check(vk_shift)) {
								if (selectListPrevIndex >= 0) {
									var loopIncrement = (selectListPrevIndex < i) ? 1 : -1;
									var selectIndex = selectListPrevIndex;									
									while (selectIndex != i) {										
										var chainToSelect = chainNavList[| selectIndex];
										var chainToSelectSubMap = global.nodeMap[? chainToSelect];
										if (scr_isNumericAndExists(chainToSelectSubMap, ds_type_map)) {
											var chainToSelectSelected = chainToSelectSubMap[? "selected"];
											scr_chainSetSelected(chainToSelect, !chainToSelectSelected);
										}
										selectIndex += loopIncrement;
									}
								}
							}
						}
					}

					// right-click on chain in chainNavList
					if (mouseoverChainNameRect && mouse_check_button_pressed(mb_right) && !mouseoverCancel) {
						
						
						obj_chain.currentFocusedChainID = currentChainID;
						obj_control.selectedChainID = obj_chain.currentFocusedChainID 
						obj_control.rightClicked = true;
						
						
						var dropDownOptionList = ds_list_create();
						if (functionChainList_currentTab == NAVTAB_STACK) {

							ds_list_add(dropDownOptionList, "help_label_rename", "option_recolor", "help_label_delete_plain", "help_label_caption", "option_clip", "option_create-tree", "option_add-to-show");
							// localize
							ds_list_add(dropDownOptionList, "Set Rez Map");
						}
						else {
							ds_list_add(dropDownOptionList, "help_label_rename", "option_recolor", "help_label_delete_plain");
						}
						if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
							scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeChainList);
						}
					}
	
					// draw rectangle for this chain
					draw_set_color(merge_color(currentChainColor, global.colorThemeBG, (obj_chain.currentFocusedChainID == currentChainID or mouseoverChainNameRect) ? 0.65: 0.8)); //soften the color
					draw_rectangle(chainNameRectX1 - clipX, chainNameRectY1 - clipY, chainNameRectX2 - clipX, chainNameRectY2 - clipY, false);
	
					// outline the rectangle in black if the chain is focused
					if (obj_chain.currentFocusedChainID == currentChainID) {
						focusedRowRectY1 = chainNameRectY1;
						focusedRowRectY2 = chainNameRectY2;
						focusedElementY = y + headerHeight + relativeScrollPlusY + textPlusY;
						with (obj_panelPane) selectListPrevIndex = i;
					}
					
					// draw checkbox
					if (mouseoverCheckbox) {
						scr_createTooltip(mean(checkboxRectX1, checkboxRectX2), checkboxRectY2, scr_get_translation("option_select"), TOOLTIP_DIR_UP);
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
					scr_drawRectWidth(checkboxRectX1 - clipX, checkboxRectY1 - clipY, checkboxRectX2 - clipX, checkboxRectY2 - clipY, 2, false);
					if (currentChainSelected) draw_sprite_ext(spr_checkmark, 0, mean(checkboxRectX1, checkboxRectX2) - clipX, mean(checkboxRectY1, checkboxRectY2) - clipY, checkBoxScale , checkBoxScale , 0, global.colorThemeText, 1);
					
					// click on checkbox
					if (mouseoverCheckbox && mouse_check_button_released(mb_left) && !mouseoverCancel) {
						currentChainSelected = !currentChainSelected;
						scr_chainSetSelected(currentChainID, currentChainSelected);
					}
					
					
					// setup filter/align/visible buttons
					var mouseoverAlignChain = false; // scr_pointInCircleClippedWindow(mouse_x, mouse_y, alignChainX, optionsChainY, optionsIconRad) && !mouseoverCancel && !mouseoverFilterChain && !mouseoverVisibleChain && functionChainList_currentTab == NAVTAB_RESONANCE && ableToMouseoverOption && !mouseoverHeaderRegion;
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
							if (obj_control.currentView == obj_control.filterView) {
								scr_renderFilter2();
								//if (ds_list_size(filterList) > 0) scr_renderFilter2();
								//else scr_disableFilter();
							}
						}
						scr_createTooltip(filterChainX, optionsChainY + optionsIconRad, scr_get_translation("menu_filter"), TOOLTIP_DIR_UP);
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
						scr_createTooltip(visibleChainX, optionsChainY + optionsIconRad, scr_get_translation("menu_hide"), TOOLTIP_DIR_UP);
					}
					// mouseover & click on align
					if (mouseoverAlignChain) {
						ableToMouseoverOption = false;
						draw_circle(alignChainX - clipX, optionsChainY - clipY, optionsIconRad, false);
						if (mouse_check_button_released(mb_left)) {
							currentChainAlign = !currentChainAlign;
							scr_setMap(currentChainSubMap, "alignChain", currentChainAlign);
						}
						scr_createTooltip(alignChainX, optionsChainY + optionsIconRad, scr_get_translation("help_label_align"), TOOLTIP_DIR_UP);
					}
					// mouseover & click on more
					if (mouseoverMoreChain) {
						ableToMouseoverOption = false;
						draw_circle(moreOptionsX - clipX, optionsChainY - clipY, optionsIconRad, false);
						if (mouse_check_button_released(mb_left)) {
							
							
							// simulate right-click
							obj_chain.currentFocusedChainID = currentChainID;
							obj_control.selectedChainID = obj_chain.currentFocusedChainID 
							obj_control.rightClicked = true;
						
						
							var dropDownOptionList = ds_list_create();
							if (functionChainList_currentTab == NAVTAB_STACK) {

								ds_list_add(dropDownOptionList, "help_label_rename", "option_recolor", "help_label_delete_plain", "help_label_caption", "option_clip", "option_create-tree", "option_add-to-show");
							
								ds_list_add(dropDownOptionList, "Set Rez Map");
							}
							else {
								ds_list_add(dropDownOptionList, "help_label_rename", "option_recolor", "help_label_delete_plain");
							}
							if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
								scr_createDropDown(moreOptionsX, optionsChainY, dropDownOptionList, global.optionListTypeChainList);
							}
							
							
							
						}
						scr_createTooltip(moreOptionsX, optionsChainY + optionsIconRad, "More", TOOLTIP_DIR_UP);
					}
					
					// draw filter/visible/more buttons
					draw_sprite_ext(spr_filterIcons, !currentChainFiltered, filterChainX - clipX, optionsChainY - clipY, 1, 1, 0, global.colorThemeText, 1);
					draw_sprite_ext(spr_toggleDraw, currentChainVisible, visibleChainX - clipX, optionsChainY - clipY, 1, 1, 0, global.colorThemeText, 1);
					draw_sprite_ext(spr_dropDown, 0, moreOptionsX - clipX, optionsChainY - clipY, 1, 1, 0, global.colorThemeText, 1);
					
					
					// set up stuff for drawing text
					draw_set_color(global.colorThemeText);
					draw_set_alpha(1);
					draw_set_halign(fa_left);
					draw_set_valign(fa_middle);
					scr_adaptFont(currentChainName, "M");
					var textY = floor(y + headerHeight + relativeScrollPlusY + textPlusY);
					
					// draw text: number column
					draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
	
					// draw text: name column
					draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, currentChainName);
					
					// draw text: text/caption column
					if (currentChainCaption != "") {
						draw_set_alpha(0.7);
						scr_adaptFont(string(currentChainCaption), "S");
						draw_text(floor(textColX + textBuffer) - clipX, textY - clipY, string(currentChainCaption));
						draw_set_alpha(1);
					}
				
					// Get height of chain name
					textPlusY += strHeight;
				}
			}
		}
	}
	

	with (obj_panelPane) {
		functionChainList_focusedChainIndex = ds_list_find_index(chainNavList, obj_chain.currentFocusedChainID);
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
	
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainNavList
	var instToScroll = (drawScrollbar) ? self.id : chainContentsPanelPaneInst;

/*var updated = false;
	if (!drawScrollbar and updated == false) {
		var currentPaneScroll =0;
			with (self.id) {
					currentPaneScroll = max(abs(focusedElementY - (y + headerHeight + strHeight)) + strHeight, strHeight);
			}
			with (instToScroll) {
						scrollPlusYDest = currentPaneScroll;
			}
		updated = true;
	}
	else {
		updated = false;
	}
	*/
	
	if (clickedIn) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			
			if (functionChainList_focusedChainIndex > 0 and functionChainList_focusedChainIndex < listOfChainsSize) {
				with (obj_panelPane) functionChainList_focusedChainIndex--;
				var newFocusedChainID = ds_list_find_value(chainNavList, functionChainList_focusedChainIndex);
				obj_chain.currentFocusedChainID = newFocusedChainID;
				
				if (focusedElementY <= y + headerHeight + strHeight) {
					with (instToScroll) {
						scrollPlusYDest += max(abs(focusedElementY - (y + headerHeight + strHeight)) + strHeight, strHeight);
					}
				}
			}
			else {
				with (instToScroll) {
					scrollPlusYDest += 16;
				}
			}
		}
		
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			
			if (functionChainList_focusedChainIndex < listOfChainsSize - 1 and functionChainList_focusedChainIndex >= 0) {
				with (obj_panelPane) functionChainList_focusedChainIndex++;
				var newFocusedChainID = ds_list_find_value(chainNavList, functionChainList_focusedChainIndex);
				obj_chain.currentFocusedChainID = newFocusedChainID;
				
				if (focusedElementY >= y + windowHeight - strHeight) {
					with (instToScroll) {
						scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
					}
				}
			}
			else {
				with (instToScroll) {
					scrollPlusYDest -= 16;
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
	

	// draw focus outline
	if (focusedRowRectY1 > -1 && focusedRowRectY2 > -1) {
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
	var headerRectY1 = y;
	var headerRectY2 = headerRectY1 + headerHeight;
	for (var i = 0; i < 4; i++) {
		
		// skip checkbox header
		//if (functionChainList_currentTab != NAVTAB_STACK && i == 0) continue;
		
		// skip text column unless this is a stack
		if (i >= 3 && functionChainList_currentTab != NAVTAB_STACK) continue;
		
		// get column width & text
		var headerRectX1 = 0;
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			headerRectX1 = optionsColX;
			colWidth = optionsColWidth;
			colText = "";
		}
		else if (i == 1) {
			headerRectX1 = numColX;
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 2) {
			headerRectX1 = nameColX;
			colWidth = nameColWidth;
			if (functionChainList_currentTab != NAVTAB_STACK) colWidth = windowWidth - headerRectX1;
			colText = "name";
		}
		else if (i == 3) {
			headerRectX1 = textColX;
			colWidth = windowWidth - headerRectX1;
			colText = "tag_text";
		}
		colText = scr_get_translation(colText);
		var headerRectX2 = headerRectX1 + colWidth;
		
		
		// draw header rects
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		
		// draw checkbox header
		if (i == 0) {
			var allChainsSelected = (ds_list_size(chainNavList) == ds_list_size(selectedList) && ds_list_size(chainNavList) > 0);
			var someChainsSelected = (ds_list_size(chainNavList) > ds_list_size(selectedList) && ds_list_size(selectedList) > 0 && ds_list_size(chainNavList) > 0);
			var headerCheckboxX1 = optionsColX + (optionsColWidth* 0.2) - (checkboxSize / 2);
			var headerCheckboxY1 = mean(headerRectY1, headerRectY2) - (checkboxSize / 2);
			var headerCheckboxX2 = headerCheckboxX1 + checkboxSize;
			var headerCheckboxY2 = headerCheckboxY1 + checkboxSize;
			var mouseoverHeaderCheckbox = point_in_rectangle(mouse_x, mouse_y, headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2) && ds_list_size(chainNavList) > 0 && !mouseoverCancel;
			if (mouseoverHeaderCheckbox) {
				draw_set_color(merge_color(global.colorThemeSelected2, global.colorThemeBG, 0.4));
				draw_roundrect(headerCheckboxX1 - (strHeight * 0.15), headerCheckboxY1 - (strHeight * 0.15), headerCheckboxX2 + (strHeight * 0.15), headerCheckboxY2 + (strHeight * 0.15), false);
				
				var tooltipText = (allChainsSelected) ? "Deselect all" : "Select all";
				scr_createTooltip(mean(headerCheckboxX1, headerCheckboxX2), headerCheckboxY2, tooltipText, TOOLTIP_DIR_UP);
				
				// click on checkbox header
				if (mouse_check_button_released(mb_left)) {
					scr_setValueForAllChains(tabChainType, true, "selected", (allChainsSelected) ? false : true);
					allChainsSelected = (ds_list_size(chainNavList) == ds_list_size(selectedList));
				}
			}
			
			// fill in checkbox header if any chains are selected
			if (allChainsSelected || someChainsSelected) {
				draw_set_color(merge_color(global.colorThemeSelected2, global.colorThemeBG, 0.6));
				draw_rectangle(headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2, false);
			}
			
			// draw checkmark for checkbox header
			if (allChainsSelected) {
				draw_sprite_ext(spr_checkmark, 0, mean(headerCheckboxX1, headerCheckboxX2), mean(headerCheckboxY1, headerCheckboxY2), checkBoxScale , checkBoxScale , 0, global.colorThemeText, 1);
			}
			else if (someChainsSelected) {
				// draw line in checkbox if only some chains are selected
				var someChainsSelectedLineY = mean(headerCheckboxY1, headerCheckboxY2);
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerCheckboxX1 + (checkboxSize * 0.2), someChainsSelectedLineY, headerCheckboxX2 - (checkboxSize * 0.2), someChainsSelectedLineY, 2);
			}
			
			draw_set_color(global.colorThemeBorders);
			scr_drawRectWidth(headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2, 2 , false);
		}
		
		// filter all / visible all / align all chain options
		if (i == 1) {
			
			// filter all
			var allChainsFiltered = (ds_list_size(chainNavList) == ds_list_size(filterList) && ds_list_size(chainNavList) > 0);
			var filterAllX = filterChainX;
			var filterAllY = mean(headerRectY1, headerRectY2);
			var mouseoverFilterAll = scr_pointInCircleClippedWindow(mouse_x, mouse_y, filterAllX, filterAllY, optionsIconRad) && !mouseoverCancel;
			if (mouseoverFilterAll) {
				draw_set_color(global.colorThemeSelected1);
				draw_circle(filterAllX, filterAllY, optionsIconRad, false);
				scr_createTooltip(filterAllX, filterAllY + optionsIconRad, scr_get_translation("option_filter-all"), TOOLTIP_DIR_UP);
				
				if (mouse_check_button_pressed(mb_left)) {
					scr_setValueForAllChains(tabChainType, true, "filter", (allChainsFiltered) ? false : true);
					// update the filter if we need to
					if (obj_control.currentView == obj_control.filterView) {
						scr_renderFilter2();
						//if (ds_list_size(filterList) > 0) scr_renderFilter2();
						//else scr_disableFilter();
					}
				}
			}
			draw_sprite_ext(spr_filterIcons, !allChainsFiltered, filterAllX, filterAllY, 1, 1, 0, global.colorThemeText, 1);
			
			
			// visible all
			var allChainsHidden = (ds_list_size(chainNavList) == ds_list_size(hiddenList) && ds_list_size(chainNavList) > 0);
			var hideAllX = visibleChainX;
			var hideAllY = mean(headerRectY1, headerRectY2);
			var mouseoverHideAll = scr_pointInCircleClippedWindow(mouse_x, mouse_y, hideAllX, hideAllY, optionsIconRad) && !mouseoverCancel && !mouseoverFilterAll;
			if (mouseoverHideAll) {
				draw_set_color(global.colorThemeSelected1);
				draw_circle(hideAllX, hideAllY, optionsIconRad, false);
				scr_createTooltip(hideAllX, hideAllY + optionsIconRad, scr_get_translation("option_hide-all"), TOOLTIP_DIR_UP);
				
				if (mouse_check_button_pressed(mb_left)) {
					scr_setValueForAllChains(tabChainType, true, "visible", (allChainsHidden) ? true : false);
				}
			}
			draw_sprite_ext(spr_toggleDraw, !allChainsHidden, hideAllX, hideAllY, 1, 1, 0, global.colorThemeText, 1);
					
		}
		
		
		// more options button
		if ((i == 3 && functionChainList_currentTab == NAVTAB_STACK) or (i == 2 && functionChainList_currentTab != NAVTAB_STACK)) {
			//x + windowWidth - sprite_get_width(spr_moreOptions);
			var moreOptionsY = mean(headerRectY1, headerRectY2);
			var moreOptionsClickable = (ds_list_size(selectedList) >= 1);
			var mouseoverMoreOptions = point_in_circle(mouse_x, mouse_y, moreOptionsX, moreOptionsY, optionsIconRad) && moreOptionsClickable && !mouseoverCancel;
			var moreOptionsDropDownExists = false;
			with (obj_dropDown) {
				if (optionListType == global.optionListTypeChainListMulti) moreOptionsDropDownExists = true;
			}
			if (mouseoverMoreOptions || moreOptionsDropDownExists) {
				draw_set_color(global.colorThemeSelected1);
				draw_circle(moreOptionsX, moreOptionsY, optionsIconRad, false);
			}
			if (mouseoverMoreOptions) {
				scr_createTooltip(moreOptionsX, moreOptionsY + optionsIconRad, "More", TOOLTIP_DIR_UP);
				if (mouse_check_button_pressed(mb_left)) {
					var dropDownOptionList = ds_list_create();
					if (obj_panelPane.functionChainList_currentTab == NAVTAB_STACK) {
						ds_list_add(dropDownOptionList, "option_add-to-show");
					}
					ds_list_add(dropDownOptionList, "help_label_delete_plain", "menu_filter", "menu_hide", "option_clip");
					if (functionChainList_currentTab == NAVTAB_STACK) {
						ds_list_add(dropDownOptionList, "option_create-tree");
					}
					
					scr_createDropDown(moreOptionsX - (optionsIconRad * 0.4), moreOptionsY + (optionsIconRad * 0.8), dropDownOptionList, global.optionListTypeChainListMulti);
				}
			}
			var moreOptionsAlpha = (moreOptionsClickable) ? 0.8 : 0.4;
			draw_sprite_ext(spr_moreOptions, 0, moreOptionsX, moreOptionsY, 1, 1, 0, c_black, moreOptionsAlpha);
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
	
	// display currently active layer/stacking
	if (functionChainList_currentTab == NAVTAB_STACK || functionChainList_currentTab == NAVTAB_TRACK || functionChainList_currentTab == NAVTAB_RESONANCE) {
		
		var _layerMap = undefined;
		var _activeLayer = "";
		var _layerList = undefined;
		var _optionNewLayer = "";
		var _optionListType = "";
		if (functionChainList_currentTab == NAVTAB_STACK) {
			_layerMap = global.stackingMap;
			_activeLayer = obj_control.activeStacking;
			_layerList = global.nodeMap[? "stackingList"];
			_optionNewLayer = "option_new-stacking";
			_optionListType = global.optionListTypeStacking;
		}
		else if (functionChainList_currentTab == NAVTAB_TRACK) {
			_layerMap = global.trailLayerMap;
			_activeLayer = obj_control.activeTrailLayer;
			_layerList = global.nodeMap[? "trailLayerList"];
			_optionNewLayer = "option_new-trail-layer";
			_optionListType = global.optionListTypeTrailLayer;
		}
		else if (functionChainList_currentTab == NAVTAB_RESONANCE) {
			_layerMap = global.resonanceLayerMap;
			_activeLayer = obj_control.activeResonanceLayer;
			_layerList = global.nodeMap[? "resonanceLayerList"];
			_optionNewLayer = "option_new-resonance-layer";
			_optionListType = global.optionListTypeResonanceLayer;
		}
		
		var _activeLayerSubMap = _layerMap[? _activeLayer];
		if (scr_isNumericAndExists(_activeLayerSubMap, ds_type_map)) {

			var activeLayerStrHeight = string_height("0");
			var activeLayerName = _activeLayerSubMap[? "name"];
			var activeLayerStr = string(activeLayerName);
			var spaceWidth = string_width(" ");
			var activeLayerX2 = x + windowWidth - spaceWidth;
			var activeLayerX1 = activeLayerX2 - min(string_width(activeLayerStr), windowWidth * 0.25) - (spaceWidth * 2);
			var activeLayerY1 = y + (headerHeight / 2) - (activeLayerStrHeight / 2);
			var activeLayerY2 = activeLayerY1 + activeLayerStrHeight;
			var mouseoverActiveLayer = point_in_rectangle(mouse_x, mouse_y, activeLayerX1, activeLayerY1, activeLayerX2, activeLayerY2) && !mouseoverCancel;
			
			// draw highlight effect if mousing over or if layer dropdown exists
			var _activeLayerDrawMouseover = false;
			if (mouseoverActiveLayer) _activeLayerDrawMouseover = true;
			if (instance_exists(obj_dropDown)) {
				if ((functionChainList_currentTab == NAVTAB_RESONANCE && obj_dropDown.optionListType == global.optionListTypeResonanceLayer)
				|| (functionChainList_currentTab == NAVTAB_TRACK && obj_dropDown.optionListType == global.optionListTypeTrailLayer)
				|| (functionChainList_currentTab == NAVTAB_STACK && obj_dropDown.optionListType == global.optionListTypeStacking)) _activeLayerDrawMouseover = true;				
			}
			if (_activeLayerDrawMouseover) {
				draw_set_color(global.colorThemeSelected1);
				draw_roundrect(activeLayerX1, activeLayerY1, activeLayerX2, activeLayerY2, false);
			}
			
			// click to change active layer
			if (mouseoverActiveLayer) {
				if (mouse_check_button_released(mb_left)) {
					if (scr_isNumericAndExists(_layerList, ds_type_list)) {
						var stackingOptionList = ds_list_create();
						ds_list_copy(stackingOptionList, _layerList);
						ds_list_add(stackingOptionList, _optionNewLayer);
						scr_createDropDown(activeLayerX1, activeLayerY2, stackingOptionList, _optionListType);
					}
				}
			}
			
			// draw text of active stacking
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(global.colorThemeText);
			draw_text(floor(mean(activeLayerX1, activeLayerX2)), floor(mean(activeLayerY1, activeLayerY2)), activeLayerStr);
		}
	}
	

	// border for headers
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + windowWidth - 2, y + headerHeight, true);

}
