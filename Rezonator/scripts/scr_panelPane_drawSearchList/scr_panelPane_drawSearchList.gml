function scr_panelPane_drawSearchList() {

		
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.08;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.2;
	var termColX = nameColX + nameColWidth;
	var termColWidth = windowWidth * 0.17
	var fieldColWidth = windowWidth * 0.1;
	var fieldColX = termColX + termColWidth;
	var rangeColWidth = windowWidth * 0.1;
	var rangeColX = fieldColX + fieldColWidth;
	var regExColWidth = windowWidth * 0.1;
	var regExColX = rangeColX + rangeColWidth;
	var caseSensitiveColWidth = windowWidth * 0.1;
	var caseSensitiveColX = regExColX + regExColWidth;
	
	var deleteColWidth = clamp(windowWidth * 0.15, sprite_get_width(spr_trash), sprite_get_width(spr_trash) * 2);
	var deleteColX = x + windowWidth - deleteColWidth - global.scrollBarWidth;
	
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var textAdjustY = 0;
	var drawScrollbar = true;
	
	var mouseOverDel = false;
	var anyOptionMousedOver = false;
	var mouseoverScrollBar = (drawScrollbar) ? point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight) : false;
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	var currentSelectedSearchIndex = -1;
	
	
	
	
	// get the instance ID for the searchContents pane so we can easily reference it
	var chainContentsPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			chainContentsPanelPaneInst = self.id;
		}
	}
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : chainContentsPanelPaneInst.scrollPlusY;
	
	
	
	// get the search list & make sure it exists
	var searchList = global.nodeMap[? "searchNodeList"];
	if (!scr_isNumericAndExists(searchList, ds_type_list)) {
		show_debug_message("scr_panelPane_drawsearchList ... searchList does not exist");
		exit;
	}
	var searchListSize = ds_list_size(searchList);
	scr_surfaceStart();
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	var setList = "";
	var setListSize = 0;
	
	// make sure search map exists
	global.searchMap = global.nodeMap[? "searchMap"];
	if (!scr_isNumericAndExists(global.searchMap, ds_type_map)) {
		scr_surfaceEnd();
		exit;
	}
	
	// loop over searchs
	for (var i = 0; i < searchListSize; i++) {
		
		// get data for currentSearch
		var currentSearch = searchList[| i];
	
		var currentSearchSubMap = global.searchMap[? currentSearch];
		if (!scr_isNumericAndExists(currentSearchSubMap, ds_type_map)) {
			continue;
		}
		
		var currentSearchName = currentSearchSubMap[? "name"];
		var currentSearchTermList = currentSearchSubMap[? "searchTermList"];
		var searchField = currentSearchSubMap[? "field"];
		var searchRange = currentSearchSubMap[? "range"];
		var searchRegEX = currentSearchSubMap[? "regex"];
		var searchCaseSensitive = currentSearchSubMap[? "caseSensitive"];
		var currentSearchSelected = (functionSearchList_searchSelected == currentSearch);
		if (currentSearchSelected) {
			currentSelectedSearchIndex = i;
		}
		
		
		// Get dimensions of rectangle around search name
		var searchRectX1 = x;
		var searchRectY1 = y + headerHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
		var searchRectX2 = x + windowWidth;
		var searchRectY2 = searchRectY1 + strHeight;
		var mouseoverSearchRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, searchRectX1, searchRectY1, searchRectX2, searchRectY2) && !mouseoverScrollBar && !scrollBarHolding && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeaderRegion;
		var highlight = (mouseoverSearchRect || functionSearchList_searchMouseover == currentSearch);
		var textY = floor(mean(searchRectY1, searchRectY2));
		
		// click on search name
		if (mouseoverSearchRect) {
			anyOptionMousedOver = true;
			if (mouse_check_button_released(mb_left) && !instance_exists(obj_dropDown) && !mouseOverDel) {
				with (obj_panelPane) functionSearchList_searchSelected = currentSearch;
				obj_control.selectedSearchID = functionSearchList_searchSelected;
				obj_control.currentView = obj_control.searchView;
				scr_renderFilter2();
			}
			
			if (mouse_check_button_released(mb_right)) {
				with (obj_panelPane) functionSearchList_searchSelected = currentSearch;
				obj_control.selectedSearchID = functionSearchList_searchSelected;
				var dropDownOptionList = ds_list_create();

				ds_list_add(dropDownOptionList, "help_label_rename", "help_label_delete_plain");

				if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
					//scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypesearchList);
				}
			
			}
		}

		
		// draw rect
		var rectColor = (currentSearchSelected) ? global.colorThemeSelected2 : merge_color(global.colorThemeBG, global.colorThemeSelected1, highlight ? 0.8 : 0.4);
		var textColor = (currentSearchSelected) ? global.colorThemeBG : global.colorThemeText;
		draw_set_color(rectColor);
		draw_rectangle(searchRectX1 - clipX, searchRectY1 - clipY, searchRectX2 - clipX, searchRectY2 - clipY, false);
		
		// # column
		draw_set_color(textColor);
		draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
		// name column
		draw_set_color(textColor);
		draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, string(currentSearchName));

		
		// ListOfTerms column
		draw_set_color(textColor);
		scr_adaptFont(scr_getStringOfList(currentSearchTermList), "M");
		draw_text(floor(termColX + textBuffer) - clipX, textY - clipY, scr_getStringOfList(currentSearchTermList));
		
		
		// parameter columns
		draw_set_color(rectColor);
		draw_rectangle(fieldColX - clipX, searchRectY1 - clipY, rangeColX - clipX, searchRectY2 - clipY, false);
		draw_set_color(textColor);
		draw_text(floor(fieldColX + textBuffer) - clipX, textY - clipY, string(searchField));
		
		draw_set_color(rectColor);
		draw_rectangle(rangeColX - clipX, searchRectY1 - clipY, regExColX - clipX, searchRectY2 - clipY, false);
		draw_set_color(textColor);
		draw_text(floor(rangeColX + textBuffer) - clipX, textY - clipY, string(scr_get_translation(searchRange)));
		
		draw_set_color(rectColor);
		draw_rectangle(regExColX - clipX, searchRectY1 - clipY, caseSensitiveColX - clipX, searchRectY2 - clipY, false);
		draw_set_color(textColor);
		if (searchRegEX) {
			draw_sprite_ext(spr_checkmark, 0, mean(regExColX, regExColX+ regExColWidth)- clipX, mean(searchRectY1,searchRectY2) - clipY,1,1,0,global.colorThemeBorders,1);
		}

		
		draw_set_color(rectColor);
		draw_rectangle(caseSensitiveColX - clipX, searchRectY1 - clipY, deleteColX - clipX, searchRectY2 - clipY, false);
		draw_set_color(textColor);
		if (searchCaseSensitive) {
			draw_sprite_ext(spr_checkmark, 0, mean(caseSensitiveColX, caseSensitiveColX+ caseSensitiveColWidth)- clipX, mean(searchRectY1,searchRectY2) - clipY,1,1,0,global.colorThemeBorders,1);
		}


	
		// get coordinates for delete button
		var delButtonX = mean(deleteColX, deleteColX + deleteColWidth);
		var delButtonY = searchRectY1 + (strHeight * 0.5);
		mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, deleteColX, searchRectY1, deleteColX + deleteColWidth, searchRectY2) && mouseoverSearchRect;
		var trashAlpha =  1;
		
		if (mouseoverSearchRect || currentSearchSelected) {
								
			// mouseover & click on sequence arrows
			if (mouseOverDel) {
				draw_set_color(global.colorThemeSelected1);
				draw_rectangle(deleteColX - clipX, searchRectY1 - clipY, deleteColX + deleteColWidth + global.scrollBarWidth - clipX, searchRectY2 - clipY, false);
				if (mouse_check_button_released(mb_left)) {
					
					
					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						obj_dialogueBox.removeSearch = true
						obj_dialogueBox.questionWindowActive = true;
						obj_dialogueBox.searchToBeRemoved = currentSearch;
					}

					
				}
				
				scr_createTooltip(delButtonX, searchRectY2, scr_get_translation("msg_remove"), TOOLTIP_DIR_UP);
			}
			

								
			draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
			
		}

		
	
		// increment plusY
		textPlusY += strHeight;
		
	}
	
	
	// draw "create search" option at end of list
	var createsearchRectX1 = x;
	var createsearchRectY1 = y + headerHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
	var createsearchRectX2 = x + windowWidth;
	var createsearchRectY2 = createsearchRectY1 + strHeight;
	var mouseoverCreatesearchRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, createsearchRectX1, createsearchRectY1, createsearchRectX2, createsearchRectY2) && !mouseoverScrollBar && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
	draw_set_color(merge_color(c_green, global.colorThemeSelected1, mouseoverCreatesearchRect ? 0.4 : 0.6));
	draw_rectangle(createsearchRectX1 - clipX, createsearchRectY1 - clipY, createsearchRectX2 - clipX, createsearchRectY2 - clipY, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_text(floor(mean(x, nameColX)) - clipX, floor(mean(createsearchRectY1, createsearchRectY2)) - clipY, "+");
	draw_set_halign(fa_left);
	draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(createsearchRectY1, createsearchRectY2)) - clipY, scr_get_translation("option_create-search"));
	
	// click on "create search"
	if (mouseoverCreatesearchRect && mouse_check_button_released(mb_left)) {
		
		// Activates word searching using search grid
		obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
		obj_control.preSwitchSearchDisplayRow = 0;

		if (!obj_control.dialogueBoxActive) {
			keyboard_string = "";
			obj_control.fPressed = true;
		}


		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	}
	
	
	
	
	
	// only search a scrollbar if we're in 1toMany
	if (drawScrollbar) {
		scr_scrollBar(searchListSize + 1, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}

	
		
	scr_surfaceEnd();

	
	
	
	// draw column headers
	var headerPlusX = 0;
	for (var i = 0; i <= 6; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = nameColWidth;
			colText = "name";
		}
		else if (i == 2) {
			colWidth = termColWidth;
			colText = "searched_words";
		}
		else if (i == 3) {
			colWidth = fieldColWidth;
			colText = "option_field";
		}
		else if (i == 4) {
			colWidth = rangeColWidth;
			colText = "option_range";
		}
		else if (i == 5) {
			colWidth = regExColWidth;
			colText = "(.*)";
		}
		else if (i == 6) {
			colWidth = windowWidth-headerPlusX;
			colText = "Aa";
		}

		
		// get header coordinates
		var headerRectX1 = x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// draw header rects
		draw_set_color(global.colorThemeBG);;
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_color(global.colorThemeBorders);
		//draw vertical dividing line
		draw_line(headerRectX1, headerRectY1, headerRectX1, headerRectY2)
		//draw horizontal diving line
		draw_line(x, headerRectY2, x+windowWidth, headerRectY2);
		// draw header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		colText = scr_get_translation(colText);
		scr_adaptFont(colText, "M");
		draw_text(headerTextX, headerTextY, colText);
		

		
		
		headerPlusX += colWidth;
	}
	

	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	var instToScroll = self.id;
	if (clickedIn) {
		if (mouse_wheel_up()) {
			scrollPlusYDest += strHeight/2;
		}
		if ( keyboard_check(vk_up) and (holdUp < 2 or holdUp > 30)) {
			with (instToScroll) {
				scrollPlusYDest += strHeight;
				
			}
		}
		
		if (mouse_wheel_down()) {
			scrollPlusYDest -= strHeight/2;
		}
		
		if ( keyboard_check(vk_down) and (holdDown < 2 || holdDown > 30)) {
			with (instToScroll) {
				scrollPlusYDest -= strHeight;
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