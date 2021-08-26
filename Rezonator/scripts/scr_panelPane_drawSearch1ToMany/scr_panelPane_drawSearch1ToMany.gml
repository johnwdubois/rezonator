// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawSearch1ToMany(){


	
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
	if(scr_isNumericAndExists(global.searchMap, ds_type_map)){
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
		}
	}
	hitColWidth = clamp(hitColWidth, windowWidth * 0.05, windowWidth * 0.4);


	
	var anyOptionMousedOver = false;
	var mouseoverScrollBar = (drawScrollbar) ? point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight) : false;
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	var unitColX = x;
	var beforeColX = unitColX + unitColWidth;
	var hitColX = beforeColX + contextColWidth;
	var afterColX = hitColX + hitColWidth;
	
	var unitTextX = mean(unitColX, unitColX+unitColWidth);
	var beforeTextX = beforeColX + contextColWidth - textBuffer;
	var hitTextX = mean(hitColX, hitColX+hitColWidth);
	var afterTextX = afterColX + textBuffer;

	
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
	
	

	
	if(scr_isNumericAndExists( global.searchMap, ds_type_map)){
		// get the search list & make sure it exists
		var searchSubMap = global.searchMap[? obj_panelPane.functionSearchList_searchSelected];
		if (scr_isNumericAndExists(searchSubMap, ds_type_map)) {
			

			var tokenDisplayList = searchSubMap[?"displayTokenList"];
			var tokenDisplayListSize = ds_list_size(tokenDisplayList);
	
	
			var discourseNodeSubMap = global.nodeMap[?global.discourseNode];
			var tokenList = discourseNodeSubMap[?"tokenList"];
	
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
				var unitSubMap = global.nodeMap[? currentUnitID];
				if(scr_isNumericAndExists(unitSubMap, ds_type_map)){
					unitSeq = unitSubMap[?"unitSeq"];
				}
				var currentTokenIndex = ds_list_find_index(tokenList, currentToken);
				var currentTokenSelected = (functionSearchList_tokenSelected == currentToken);
				if(currentTokenSelected){
					currentSelectedTokenIndex = i;
				}
				var beforeTokenList = ds_list_create();
				var afterTokenList = ds_list_create();
				var contextAmount = 6;
				var itterator = 1;
				repeat(contextAmount){
					var newTokenID = tokenList[| currentTokenIndex - itterator];
					var newTokenSubMap = global.nodeMap[? newTokenID];
					if(scr_isNumericAndExists(newTokenSubMap, ds_type_map)){
						var newTokenTagMap = newTokenSubMap[? "tagMap"];
						var newTokenText = newTokenTagMap[? global.displayTokenField];
						if(newTokenText != undefined && newTokenText != ""){
							ds_list_add(beforeTokenList, newTokenText);
						}
					}
					itterator ++;
				}
				itterator = 1;
				repeat(contextAmount){
					var newTokenID = tokenList[| currentTokenIndex + itterator];
					var newTokenSubMap = global.nodeMap[? newTokenID];
					if(scr_isNumericAndExists(newTokenSubMap, ds_type_map)){
						var newTokenTagMap = newTokenSubMap[? "tagMap"];
						var newTokenText = newTokenTagMap[? global.displayTokenField];
						if(newTokenText != undefined && newTokenText != ""){
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
		
		
				
				sizeOfLine = (searchRectY2 - searchRectY1);
				
				
				// click on search name
				if (mouseoverSearchRect) {
					anyOptionMousedOver = true;
					if (mouse_check_button_released(mb_left) && !instance_exists(obj_dropDown)) {
						with (obj_panelPane) functionSearchList_tokenSelected = currentToken;
						obj_control.selectedSearchTokenID = functionSearchList_tokenSelected;
						scr_jumpToUnit(currentUnitID);
					}
			
					if (mouse_check_button_released(mb_right)) {
						with (obj_panelPane) functionSearchList_tokenSelected = currentToken;
						obj_control.selectedSearchTokenID = functionSearchList_tokenSelected;
						var dropDownOptionList = ds_list_create();

						ds_list_add(dropDownOptionList, "Rename", "Delete");

						if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
							//scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypesearchList);
						}
			
					}
				}


				var unitRectX1 = searchRectX1
				var unitRectY1 = searchRectY1
				var unitRectX2 = searchRectX1 + unitColWidth;
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

				//draw rect to clip before text
				draw_set_color(rectColor);
				draw_rectangle(unitRectX1 - clipX, unitRectY1 - clipY, unitRectX2 - clipX, unitRectY2 - clipY, false);


				// unit column
				draw_set_halign(fa_center);
				draw_set_color(textColor);
				draw_text(unitTextX - clipX, textY - clipY, string(unitSeq));

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



	var headerPlusX = 0;
	var colAmount = 4;
	for (var i = 0; i < colAmount; i++) {
		var colWidth = 0;
		// get coordinates for header rect
		if(i == 0){
			colWidth = unitColWidth;
		}
		else if(i == 1  or i == 3){
			colWidth = contextColWidth;
		}
		else{
			colWidth = hitColWidth;
		}
		
		var headerRectX1 =  x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		if (i == 3) {
			headerRectX2 = windowX + windowWidth;
			colWidth = headerRectX2 - headerRectX1;
		}
		var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
			
		// get coordinates for header text
		var headerTextX = 0;
		if(i == 0 ){
			draw_set_halign(fa_center);
			var headerTextX = floor(mean(headerRectX2 , headerRectX1));
		}
		else if(i == 1 ){
			draw_set_halign(fa_right);
			var headerTextX = floor(headerRectX2 - textMarginLeft);
		}
		
		else if(i == 2 ){
			draw_set_halign(fa_center);
			var headerTextX = floor(mean(headerRectX2 , headerRectX1));
		}
		
		else if(i == 3 ){
			draw_set_halign(fa_left);
			var headerTextX = floor(headerRectX1 + textMarginLeft);
		}
		

		var headerTextY = floor(y + (headerHeight / 2));
	
		// get header string for static columns
		var colName = "";
		if (i == 0) colName = scr_get_translation("error_unit");

		// make headers not overlap with each other
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + headerHeight, false);
		
		
		// draw header name
		draw_set_color(global.colorThemeText);
		draw_set_valign(fa_middle);


		scr_adaptFont(colName, "M");
			

			
		draw_text(headerTextX, headerTextY, colName);
		

			
			
	
	
				
	
		// draw vertical line separating unit column from the others
		if (i <= 1) {
			draw_set_color(global.colorThemeBorders);
			draw_line_width(headerRectX1, y, headerRectX1, y + windowHeight, 1);
		}


		
		headerPlusX += colWidth;

	}


	// draw horizontal line between headers and contents
	draw_line(x , y + headerHeight , x + windowWidth , y + headerHeight);


	var instToScroll = self.id;

		
	// show buttons (next) 
	var showNextButtonText = "  >  ";
	var buttonWidth = string_width(showNextButtonText)
	scr_adaptFont(showNextButtonText, "M");
	var showNextButtonX2 = windowX + windowWidth - 20;
	var showNextButtonY1 = y + (functionTabs_tabHeight * 0.5) - (strHeight * 0.25);
	var showNextButtonX1 = showNextButtonX2 - buttonWidth;
	var showNextButtonY2 = showNextButtonY1 + strHeight/2;			
		
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
				
		if(scr_isNumericAndExists(newTokenSubMap, ds_type_map)){
			scrollPlusYDest += sizeOfLine;	
			
			with(obj_panelPane){
				functionSearchList_tokenSelected = newSelectedToken;
			}
			var newUnitID = newTokenSubMap[?"unit"];

			scr_jumpToUnit(newUnitID);				



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
	
	if(mouseoverShowNextButton){scr_createTooltip(mean(showNextButtonX1, showNextButtonX2),showNextButtonY2, scr_get_translation("find_next"),obj_tooltip.arrowFaceUp);}
	

	if (mouse_check_button_released(mb_left) && mouseoverShowNextButton) {
		var newSelectedToken = scr_findNext(functionSearchList_tokenSelected,false);
			
		var newTokenSubMap = global.nodeMap[?newSelectedToken];
				
		if(scr_isNumericAndExists(newTokenSubMap, ds_type_map)){
			scrollPlusYDest -= sizeOfLine;
			
			with(obj_panelPane){
				functionSearchList_tokenSelected = newSelectedToken;
			}
			var newUnitID = newTokenSubMap[?"unit"];

			scr_jumpToUnit(newUnitID);
					
			


				
		}	
	}



	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList

	if (clickedIn) {
		if (mouse_wheel_up()){
			scrollPlusYDest += sizeOfLine/2;
		}
		if ( keyboard_check(vk_up) and (holdUp < 2 or holdUp > 30)) {
			scrollPlusYDest += sizeOfLine;
		}
		
		if (mouse_wheel_down()){
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