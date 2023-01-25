

function scr_panelPane_drawSearch1ToMany() {


	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var textMarginLeft = 8;
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	
	var headerHeight = functionTabs_tabHeight;
	var textBuffer = 8;
	var textPlusY = 0;
	var textAdjustY = 0;
	var drawScrollbar = true;	
	var strHeight = string_height("0") * 1.5;
	var spaceWidth = string_width(" ");
	
	// get hit col width by finding the longest string width in the search's search term list
	var unitColWidth = windowWidth * 0.1;
	var hitColWidth = windowWidth * 0.05;
	var contextColWidth = windowWidth * 0.35;
	if (scr_isNumericAndExists(global.searchMap, ds_type_map)) {
		var searchSubMap = global.searchMap[? obj_panelPane.functionSearchList_searchSelected];
		if (scr_isNumericAndExists(searchSubMap, ds_type_map)) {
			var searchTermList = searchSubMap[? "searchTermList"];
			if (scr_isNumericAndExists(searchTermList, ds_type_list)) {
				var searchTermListSize = ds_list_size(searchTermList);
				for (var i = 0; i < searchTermListSize; i++) {
					var strWidth = string_width(searchTermList[| i]) + (spaceWidth * 2);
					hitColWidth = max(hitColWidth, strWidth);
				}
			}
			
			var tokenTokenList = searchSubMap[? "displayTokenList"];
			if (scr_isNumericAndExists(tokenTokenList, ds_type_list)) {
				var tokenTokenListSize = ds_list_size(tokenTokenList);
				for (var i = 0; i < tokenTokenListSize; i++) {
					var tokenID = tokenTokenList[| i];
					var tokenSubMap = global.nodeMap[?tokenID]
					var tokenTagMap = tokenSubMap[? "tagMap"];
					var currentTokenStr = tokenTagMap[?global.displayTokenField];
					var strWidth = string_width(currentTokenStr) + (spaceWidth * 2);
					hitColWidth = max(hitColWidth, strWidth);
				}
			}
			
		}
	}
	hitColWidth = clamp(hitColWidth, windowWidth * 0.05, windowWidth * 0.4);


	
	var anyOptionMousedOver = false;
	var mouseoverScrollBar = (drawScrollbar) ? point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight) : false;
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	var filterRectMargin = 8;
	var filterRectSize = (strHeight / 2) + 5;
	var checkboxColX = x;
	var checkboxColWidth = filterRectMargin + (filterRectSize * 2);
	var checkboxSize = checkboxColWidth * 0.35;
	
	var unitColX = checkboxColX + checkboxColWidth;
	var beforeColX = unitColX + unitColWidth;
	var hitColX = beforeColX + contextColWidth;
	var afterColX = hitColX + hitColWidth;
	
	var unitTextX = mean(unitColX, unitColX+unitColWidth);
	var beforeTextX = beforeColX + contextColWidth - textBuffer;
	var hitTextX = mean(hitColX, hitColX+hitColWidth);
	var afterTextX = afterColX + textBuffer;
	
	
	var checkBoxScale = 1* max(global.fontSize,3)/5;
	var sizeOfLine = 0;
	var currentSelectedTokenIndex = -1;
	
	// get the instance ID for the searchContents pane so we can easily reference it
	var chainContentsPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			chainContentsPanelPaneInst = self.id;
		}
	}
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : chainContentsPanelPaneInst.scrollPlusY;
	
	var tokenDisplayListSize = 0;
	var selectedTokenList = "";
	
	if (scr_isNumericAndExists( global.searchMap, ds_type_map)) {
		// get the search list & make sure it exists
		var searchSubMap = global.searchMap[? obj_panelPane.functionSearchList_searchSelected];
		if (scr_isNumericAndExists(searchSubMap, ds_type_map)) {
			

			var tokenDisplayList = searchSubMap[? "displayTokenList"];
			var selectedTokenList = searchSubMap[? "selectedTokenList"];
			var displayUnitList = searchSubMap[? "displayUnitList"];
			tokenDisplayListSize = ds_list_size(tokenDisplayList);
	
	
			var discourseNodeSubMap = global.nodeMap[?global.discourseNode];
			var tokenList = discourseNodeSubMap[? "tokenList"];
	
			scr_surfaceStart();
	
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_set_alpha(1);
			var setList = "";
			var setListSize = 0;

			// loop over searchs
			for (var i = 0; i < tokenDisplayListSize; i++) {

				
				// don't bother drawing this stuff if it won't be on screen
				if (y + headerHeight + scrollPlusY + textPlusY < y - strHeight
				or y + headerHeight + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
					textPlusY += strHeight;
					continue;
				}
		
				// get data for currentSearch
				var currentToken = tokenDisplayList[| i];
				var currentTokenSubMap = global.nodeMap[? currentToken];
				if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
		
				var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
				var currentTokenText = currentTokenTagMap[? global.displayTokenField];
				var currentUnitID = currentTokenSubMap[? "unit"];
				var unitSeq = "NULL";
				var unitTagMap = "";
				var displayUnitStr = "";
				var unitSubMap = global.nodeMap[? currentUnitID];
				if (scr_isNumericAndExists(unitSubMap, ds_type_map)) {
					unitSeq = unitSubMap[? "unitSeq"];
					unitTagMap = unitSubMap[? "tagMap"];
					displayUnitStr = unitTagMap[?global.participantField];
				}
				
				var currentTokenIndex = ds_list_find_index(tokenList, currentToken);
				var currentTokenSelected = (functionSearchList_tokenSelected == currentToken);
				var currentTokenChecked = (ds_list_find_index(selectedTokenList, currentToken) != -1);
				if (currentTokenSelected) {
					currentSelectedTokenIndex = i;
				}
				var beforeTokenList = ds_list_create();
				var afterTokenList = ds_list_create();
				var contextAmount = 20;
				var itterator = 1;
				var totalLineCount = (windowWidth/string_width("A"))/2;
				var charCount = 0;
				while(charCount < totalLineCount && itterator < 100) {
					var newTokenID = tokenList[| currentTokenIndex - itterator];
					var newTokenSubMap = global.nodeMap[? newTokenID];
					if (scr_isNumericAndExists(newTokenSubMap, ds_type_map)) {
						var newTokenTagMap = newTokenSubMap[? "tagMap"];
						var newTokenText = newTokenTagMap[? global.displayTokenField];
						var tokenCharCount = string_length(newTokenText);
						charCount += tokenCharCount;
						if (newTokenText != undefined && newTokenText != "") {
							ds_list_add(beforeTokenList, newTokenText);
						}
					}
					itterator ++;
				}
				itterator = 1;
				charCount = 0;
				while(charCount < totalLineCount && itterator < 100) {
					var newTokenID = tokenList[| currentTokenIndex + itterator];
					var newTokenSubMap = global.nodeMap[? newTokenID];
					if (scr_isNumericAndExists(newTokenSubMap, ds_type_map)) {
						var newTokenTagMap = newTokenSubMap[? "tagMap"];
						var newTokenText = newTokenTagMap[? global.displayTokenField];
						var tokenCharCount = string_length(newTokenText);
						charCount += tokenCharCount;
						if (newTokenText != undefined && newTokenText != "") {
							ds_list_add(afterTokenList, newTokenText);
						}
					}
					itterator ++;
				}
		
		
				// Get dimensions of rectangle around search name
				var searchRectX1 = x;
				var searchRectY1 = y + headerHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
				var searchRectX2 = x + windowWidth;
				var searchRectY2 = searchRectY1 + strHeight;
				var mouseoverSearchRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, searchRectX1, searchRectY1, searchRectX2, searchRectY2) && !mouseoverScrollBar && !scrollBarHolding && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeaderRegion;
				var highlight = (mouseoverSearchRect || functionSearchList_tokenMouseover == currentToken);
				var textY = floor(mean(searchRectY1, searchRectY2));
				
				// get dimensions of checkbox rect
				var checkboxRectX1 = checkboxColX + (checkboxColWidth / 2) - (checkboxSize / 2);
				var checkboxRectY1 = mean(searchRectY1, searchRectY2) - (checkboxSize / 2);
				var checkboxRectX2 = checkboxRectX1 + checkboxSize;
				var checkboxRectY2 = checkboxRectY1 + checkboxSize;
				var mouseoverCheckbox = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, checkboxRectX1, checkboxRectY1, checkboxRectX2, checkboxRectY2) && !mouseoverHeaderRegion && !mouseoverScrollBar;
				if (mouseoverCheckbox) mouseoverSearchRect = false;
		
		
				
				sizeOfLine = (searchRectY2 - searchRectY1);
				
				
				// click on search name
				if (mouseoverSearchRect) {
					anyOptionMousedOver = true;
					if (mouse_check_button_released(mb_left)) {
						with (obj_panelPane) functionSearchList_tokenSelected = currentToken;
						obj_control.selectedSearchTokenID = functionSearchList_tokenSelected;
						
						//var nextUnitPos = min(ds_list_size(displayUnitList)-1,ds_list_find_index(displayUnitList,currentUnitID)+1);
						//displayUnitList[|nextUnitPos]
						scr_jumpToUnitTop(currentUnitID);
						
						// deselect all other tokens and select the current one
						if (!global.ctrlHold) ds_list_clear(selectedTokenList);
						scr_addToListOnce(selectedTokenList, currentToken);
						currentTokenChecked = true;
						
						// hold SHIFT and click to select range of chains
						if (keyboard_check(vk_shift)) {
							if (selectListPrevIndex >= 0) {
								var loopIncrement = (selectListPrevIndex < i) ? 1 : -1;
								var selectIndex = selectListPrevIndex;		
								show_debug_message("selectListPrevIndex: " + string(selectListPrevIndex) + ", i: " + string(i));
								
								while (selectIndex != i) {										
									var tokenToSelect = tokenDisplayList[| selectIndex];
									show_debug_message("tokenToSelect: " + string(tokenToSelect) + ", selectIndex: " + string(selectIndex));
									if (ds_list_find_index(selectedTokenList, tokenToSelect) == -1) {
										ds_list_add(selectedTokenList, tokenToSelect);
									}
									else {
										scr_deleteFromList(selectedTokenList, tokenToSelect);
									}
									selectIndex += loopIncrement;
								}
							}
						}
						
						with (obj_panelPane) selectListPrevIndex = i;
					}

			
					if (mouse_check_button_released(mb_right)) {
						with (obj_panelPane) functionSearchList_tokenSelected = currentToken;
						obj_control.selectedSearchTokenID = functionSearchList_tokenSelected;
						/*
						var dropDownOptionList = ds_list_create();

						ds_list_add(dropDownOptionList, "help_label_rename", "help_label_delete_plain");

						if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
							scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypesearchList);
						}
						*/
					}
				}
				
				


				var unitRectX1 = searchRectX1;
				var unitRectY1 = searchRectY1
				var unitRectX2 = searchRectX1 + checkboxColWidth + unitColWidth;
				var unitRectY2 = searchRectY2
		
		
				// draw rect
				var rectColor = (currentTokenSelected) ? global.colorThemeSelected2 : merge_color(global.colorThemeBG, global.colorThemeSelected1, highlight ? 0.8 : 0.4);
				var textColor = (currentTokenSelected) ? global.colorThemeBG : global.colorThemeText;
				draw_set_color(rectColor);
				draw_rectangle(searchRectX1 - clipX, searchRectY1 - clipY, searchRectX2 - clipX, searchRectY2 - clipY, false);



				// before column
				draw_set_halign(fa_right);
				draw_set_color(textColor);
				var beforeText = scr_getSearchString(beforeTokenList, true);
				scr_adaptFont(beforeText, "M");
				draw_text(beforeTextX - clipX, textY - clipY,beforeText);
				rectColor = merge_color(rectColor,scr_strToColor(displayUnitStr), 0.5);
				//draw rect to clip before text
				draw_set_color(rectColor);
				draw_rectangle(unitRectX1 - clipX, unitRectY1 - clipY, unitRectX2 - clipX, unitRectY2 - clipY, false);


				// unit column
				draw_set_halign(fa_center);
				draw_set_color(textColor);
				draw_text(unitTextX - clipX, textY - clipY, string(unitSeq));
				
				
				if (mouseoverCheckbox) {
					scr_createTooltip(mean(checkboxRectX1, checkboxRectX2), checkboxRectY2, scr_get_translation("option_select"), obj_tooltip.arrowFaceUp);
				}
				if (currentTokenChecked) {
					draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.9));
					draw_roundrect(checkboxRectX1 - clipX, checkboxRectY1 - clipY, checkboxRectX2 - clipX, checkboxRectY2 - clipY, false);
				}
				else if (mouseoverCheckbox) {
					draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.9));
					draw_roundrect(checkboxRectX1 - (strHeight * 0.15) - clipX, checkboxRectY1 - (strHeight * 0.15) - clipY, checkboxRectX2 + (strHeight * 0.15) - clipX, checkboxRectY2 + (strHeight * 0.15) - clipY, false);
				}
				draw_set_color(global.colorThemeBorders);
				scr_drawRectWidth(checkboxRectX1 - clipX, checkboxRectY1 - clipY, checkboxRectX2 - clipX, checkboxRectY2 - clipY, 2, false);
				if (currentTokenChecked) draw_sprite_ext(spr_checkmark, 0, mean(checkboxRectX1, checkboxRectX2) - clipX, mean(checkboxRectY1, checkboxRectY2) - clipY, checkBoxScale , checkBoxScale , 0, global.colorThemeText, 1);
				
				
				
				// click on checkbox
				if (mouseoverCheckbox && mouse_check_button_released(mb_left)) {
					if (currentTokenChecked) {
						scr_deleteFromList(selectedTokenList,currentToken);
					}
					else{
						scr_addToListOnce(selectedTokenList,currentToken);
					}
				}
		

				// text column
				draw_set_halign(fa_center);
				draw_set_color( (currentTokenSelected) ? global.colorThemeBG : make_color_rgb(20, 146, 181));
				scr_adaptFont(string(currentTokenText), "M");
				draw_text(hitTextX - clipX, textY - clipY, string(currentTokenText));

				// after column
				draw_set_halign(fa_left);
				draw_set_color(textColor);
				
				var afterText = scr_getSearchString(afterTokenList, false);
				scr_adaptFont(afterText, "M");
				draw_text(afterTextX - clipX, textY - clipY, afterText);

	
				// increment plusY
				textPlusY += strHeight;
		
				ds_list_destroy(beforeTokenList);
				ds_list_destroy(afterTokenList);
		
			}
	
	
			// only search a scrollbar 
			if (drawScrollbar) {
				scr_scrollBar(tokenDisplayListSize, -1, strHeight, headerHeight,
					global.colorThemeSelected1, global.colorThemeSelected2,
					global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
			}

	
		
			scr_surfaceEnd();
			


		}
	}




	var colWidth = 0;

		
	var headerRectX1 =  x;
	var headerRectY1 = y;
	var headerRectX2 = x+windowWidth;
	var headerRectY2 = headerRectY1 + headerHeight;

	// get coordinates for header text
	var headerTextX = unitTextX;

	var headerTextY = floor(y + (headerHeight / 2));
	
	// get header string for static columns
	var colName = scr_get_translation("error_unit");

	// make headers not overlap with each other
	draw_set_color(global.colorThemeBG);
	draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + headerHeight, false);
		
		
	// draw header name
	draw_set_color(global.colorThemeText);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	scr_adaptFont(colName, "M");
	draw_text(headerTextX, headerTextY, colName);
	var allChainsSelected = false;
	var someChainsSelected = false;
	if (scr_isNumericAndExists(selectedTokenList, ds_type_list)) {
		allChainsSelected = (tokenDisplayListSize == ds_list_size(selectedTokenList) && tokenDisplayListSize > 0);
		someChainsSelected = (tokenDisplayListSize > ds_list_size(selectedTokenList) && ds_list_size(selectedTokenList) > 0 && tokenDisplayListSize > 0);

		var headerCheckboxX1 = checkboxColX + (checkboxColWidth / 2) - (checkboxSize / 2);
		var headerCheckboxY1 = mean(headerRectY1, headerRectY2) - (checkboxSize / 2);
		var headerCheckboxX2 = headerCheckboxX1 + checkboxSize;
		var headerCheckboxY2 = headerCheckboxY1 + checkboxSize;
		var mouseoverHeaderCheckbox = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2) ;


	
		if (mouseoverHeaderCheckbox) {
			draw_set_color(merge_color(global.colorThemeSelected2, global.colorThemeBG, 0.4));
			draw_roundrect(headerCheckboxX1 - (strHeight * 0.15), headerCheckboxY1 - (strHeight * 0.15), headerCheckboxX2 + (strHeight * 0.15), headerCheckboxY2 + (strHeight * 0.15), false);
				
			var tooltipText = (allChainsSelected) ? "Deselect all" : "Select all";
			scr_createTooltip(mean(headerCheckboxX1, headerCheckboxX2), headerCheckboxY2, tooltipText, obj_tooltip.arrowFaceUp);
				
			// click on checkbox header
			if (mouse_check_button_released(mb_left)) {
				if (allChainsSelected) {
					ds_list_clear(selectedTokenList);
				}
				else{
					var i = 0
					repeat(tokenDisplayListSize) {
						scr_addToListOnce(selectedTokenList, tokenDisplayList[|i]);
						i++
					}
				}
				allChainsSelected = (tokenDisplayListSize == ds_list_size(selectedTokenList));
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
		scr_drawRectWidth(headerCheckboxX1, headerCheckboxY1, headerCheckboxX2, headerCheckboxY2, 2, false);
		//if (currentTokenChecked) draw_sprite_ext(spr_checkmark, 0, mean(checkboxRectX1, checkboxRectX2) - clipX, mean(checkboxRectY1, checkboxRectY2) - clipY, checkBoxScale , checkBoxScale , 0, global.colorThemeText, 1);
	}			
				


	// draw horizontal line between headers and contents
	draw_line(x , y + headerHeight , x + windowWidth , y + headerHeight);


	var instToScroll = self.id;

	// activate search button
	var showNextButtonText = "  >  ";
	var buttonWidth = string_width(showNextButtonText)
	scr_adaptFont(showNextButtonText, "M");
	var activateButtonX2 = x + windowWidth - 20;
	var activateButtonY1 = y + (functionTabs_tabHeight * 0.5) - (strHeight * 0.4);
	var activateButtonX1 = activateButtonX2 - buttonWidth;
	var activateButtonY2 = y + (functionTabs_tabHeight * 0.5) + strHeight * 0.4;
	var searchEnabled = (obj_control.currentView == obj_control.searchView);
	var mouseoverActivateButton = point_in_rectangle(mouse_x, mouse_y, activateButtonX1, activateButtonY1, activateButtonX2, activateButtonY2);
	if (searchEnabled) {
		draw_set_color(merge_color(global.colorThemeRezPink, global.colorThemeBG, mouseoverActivateButton ? 0.4 : 0.1));
	}
	else {
		draw_set_color(merge_color(global.colorThemeSelected2, global.colorThemeBG, mouseoverActivateButton ? 0.4 : 0));
	}
	draw_roundrect(activateButtonX1, activateButtonY1, activateButtonX2, activateButtonY2, false);
	
	draw_sprite_ext(spr_search, 0, floor(mean(activateButtonX1, activateButtonX2)), floor(mean(activateButtonY1, activateButtonY2)), obj_toolPane.toolSpriteScale, obj_toolPane.toolSpriteScale, -90, global.colorThemeBG, 1);
	if (mouseoverActivateButton) {
		
		scr_createTooltip(floor(mean(activateButtonX1, activateButtonX2)), activateButtonY2, searchEnabled ? scr_get_translation("msg_enabled") : scr_get_translation("msg_disabled"), obj_tooltip.arrowFaceUp);
		
		if (mouse_check_button_released(mb_left)) {
			if (obj_control.currentView != obj_control.searchView) {
				obj_control.selectedSearchID = functionSearchList_searchSelected;
				obj_control.currentView = obj_control.searchView;
				scr_renderFilter2();
			}
			else {
				obj_control.currentView = obj_control.mainView;
				scr_disableFilter();
			}
		}
	}
	
	
	
		
	// show buttons (next) 
	var showNextButtonX2 = activateButtonX1 - (buttonWidth / 2);
	var showNextButtonY1 = activateButtonY1;
	var showNextButtonX1 = showNextButtonX2 - buttonWidth;
	var showNextButtonY2 = activateButtonY2;			
		
	// show buttons (prev)
	var showPrevButtonText = "  <  ";
	var showPrevButtonX2 = showNextButtonX1 - (buttonWidth / 2);
	var showPrevButtonX1 = showPrevButtonX2 - buttonWidth;
	var showPrevButtonY1 = showNextButtonY1;
	var showPrevButtonY2 = showNextButtonY2;
		
		
	// show buttons (prev)
	var mouseoverShowPrevButton = point_in_rectangle(mouse_x, mouse_y, showPrevButtonX1, showPrevButtonY1, showPrevButtonX2, showPrevButtonY2);
	draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowPrevButton ? 0 : 0.5));
	draw_roundrect(showPrevButtonX1, showPrevButtonY1, showPrevButtonX2, showPrevButtonY2, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(floor(mean(showPrevButtonX1, showPrevButtonX2)), floor(mean(showPrevButtonY1, showPrevButtonY2)), showPrevButtonText);
		
	if (mouseoverShowPrevButton) {scr_createTooltip(mean(showPrevButtonX1, showPrevButtonX2), showPrevButtonY2, scr_get_translation("msg_find_previous"), obj_tooltip.arrowFaceUp);}
		

	if (mouse_check_button_released(mb_left) && mouseoverShowPrevButton) {
		
		var newSelectedToken = scr_findNext(functionSearchList_tokenSelected,true);
			
		var newTokenSubMap = global.nodeMap[?newSelectedToken];
				
		if (scr_isNumericAndExists(newTokenSubMap, ds_type_map)) {
			scrollPlusYDest += sizeOfLine;	
			
			with(obj_panelPane) {
				functionSearchList_tokenSelected = newSelectedToken;
			}
			var newUnitID = newTokenSubMap[? "unit"];

			scr_jumpToUnitTop(newUnitID);				



		}	
	}
	
		
		
	// show buttons (next)
	var mouseoverShowNextButton = point_in_rectangle(mouse_x, mouse_y, showNextButtonX1, showNextButtonY1, showNextButtonX2, showNextButtonY2);
	draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowNextButton ? 0 : 0.5));
	draw_roundrect(showNextButtonX1, showNextButtonY1, showNextButtonX2, showNextButtonY2, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(floor(mean(showNextButtonX1, showNextButtonX2)), floor(mean(showNextButtonY1, showNextButtonY2)), showNextButtonText);
	
	if (mouseoverShowNextButton) {scr_createTooltip(mean(showNextButtonX1, showNextButtonX2),showNextButtonY2, scr_get_translation("find_next"),obj_tooltip.arrowFaceUp);}
	

	if (mouse_check_button_released(mb_left) && mouseoverShowNextButton) {
		var newSelectedToken = scr_findNext(functionSearchList_tokenSelected,false);
			
		var newTokenSubMap = global.nodeMap[?newSelectedToken];
				
		if (scr_isNumericAndExists(newTokenSubMap, ds_type_map)) {
			scrollPlusYDest -= sizeOfLine;
			
			with(obj_panelPane) {
				functionSearchList_tokenSelected = newSelectedToken;
			}
			var newUnitID = newTokenSubMap[? "unit"];

			scr_jumpToUnitTop(newUnitID);
					
			


				
		}	
	}
	
	
	var addToChainButtonX2 = showPrevButtonX1 - (buttonWidth / 2);
	var addToChainButtonX1 = addToChainButtonX2 - buttonWidth;
	var addToChainButtonY1 = showNextButtonY1;
	var addToChainButtonY2 = showNextButtonY2;
		
		
	// addTo buttons (Chain)
	var mouseoverAddToChainButton = point_in_rectangle(mouse_x, mouse_y, addToChainButtonX1, addToChainButtonY1, addToChainButtonX2, addToChainButtonY2);
	draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverAddToChainButton ? 0 : 0.5));
	draw_roundrect(addToChainButtonX1, addToChainButtonY1, addToChainButtonX2, addToChainButtonY2, false);
	draw_set_color(global.colorThemeText);

	draw_sprite_ext(spr_moreOptions,1,floor(mean(addToChainButtonX1, addToChainButtonX2)), floor(mean(addToChainButtonY1, addToChainButtonY2)),.8,.8,0,(someChainsSelected or allChainsSelected)? global.colorThemeRezPink:c_white,1)
	
	if (mouseoverAddToChainButton) {scr_createTooltip(mean(addToChainButtonX1, addToChainButtonX2), addToChainButtonY2, scr_get_translation("More"), obj_tooltip.arrowFaceUp);}
		

	if (mouse_check_button_released(mb_left) && mouseoverAddToChainButton) {
		var dropDownOptionList = ds_list_create();
		//, "Add to Stack"
		// localize
		ds_list_add(dropDownOptionList, "Add to Trail", "Add to Resonance", "Tag Token", "Remove from Search");
		scr_createDropDown(addToChainButtonX1, addToChainButtonY2, dropDownOptionList, global.optionListTypeSearchPane);
	}



	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList

	if (clickedIn) {
		if (mouse_wheel_up()) {
			scrollPlusYDest += sizeOfLine/2;
		}
		if ( keyboard_check(vk_up) and (holdUp < 2 or holdUp > 30)) {
			scrollPlusYDest += sizeOfLine;
		}
		
		if (mouse_wheel_down()) {
			scrollPlusYDest -= sizeOfLine/2;
		}
		
		if ( keyboard_check(vk_down) and (holdDown < 2 || holdDown > 30)) {
			scrollPlusYDest -= sizeOfLine;
		}
	
		// CTRL+UP and CTRL+DOWN
		if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
			scrollPlusYDest = 100;
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
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





}