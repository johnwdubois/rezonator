// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawSearch1ToMany(){


	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var textMarginLeft = 8;
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	
	var tabHeight = functionTabs_tabHeight;
	var textBuffer = 8;
	var textPlusY = 0;
	var textAdjustY = 0;
	var drawScrollbar = true;	
	var strHeight = string_height("0") * 1.5;
	
	var unitColWidth = windowWidth * 0.1;
	var contextColWidth = windowWidth * 0.35;
	var hitColWidth = windowWidth * 0.2;

	
	var anyOptionMousedOver = false;
	var mouseoverScrollBar = (drawScrollbar) ? point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight) : false;
	
	var unitColX = x;
	var beforeColX = unitColX + unitColWidth;
	var hitColX = beforeColX + contextColWidth;
	var afterColX = hitColX + hitColWidth;
	
	var unitTextX = mean(unitColX, unitColX+unitColWidth);
	var beforeTextX = beforeColX + contextColWidth - textBuffer;
	var hitTextX = mean(hitColX, hitColX+hitColWidth);
	var afterTextX = afterColX + textBuffer;

	
	
	
	
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
				var searchRectY1 = y + tabHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
				var searchRectX2 = x + windowWidth;
				var searchRectY2 = searchRectY1 + strHeight;
				var mouseoverSearchRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, searchRectX1, searchRectY1, searchRectX2, searchRectY2) && !mouseoverScrollBar;
				var highlight = (mouseoverSearchRect || functionSearchList_tokenMouseover == currentToken);
				var textY = floor(mean(searchRectY1, searchRectY2));
		
		
		
				// click on search name
				if (mouseoverSearchRect) {
					anyOptionMousedOver = true;
					if (mouse_check_button_released(mb_left) && !instance_exists(obj_dropDown)) {
						with (obj_panelPane) functionSearchList_tokenSelected = currentToken;
						obj_control.selectedSearchTokenID = functionSearchList_tokenSelected;
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
				draw_text(beforeTextX - clipX, textY - clipY, scr_getSearchString(beforeTokenList, true));

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
				draw_text(hitTextX - clipX, textY - clipY, string(currentTokenText));

				// after column
				draw_set_halign(fa_left);
				draw_set_color(textColor);
				draw_text(afterTextX - clipX, textY - clipY, scr_getSearchString(afterTokenList, false));

	
				// increment plusY
				textPlusY += strHeight;
		
				ds_list_destroy(beforeTokenList);
				ds_list_destroy(afterTokenList);
		
			}
	
	
			// only search a scrollbar if we're in 1toMany
			if (drawScrollbar) {
				scr_scrollBar(tokenDisplayListSize, -1, strHeight, tabHeight,
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
		var headerRectY2 = headerRectY1 + tabHeight;
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
		

		var headerTextY = floor(y + (tabHeight / 2));
	
		// get header string for static columns
		var colName = "";
		switch (i) {
			case 0:
				colName = "unit";
				break;
			case 1:
				colName = "before"; // stacks
				break;
			case 2:
				colName = "hit"; // stacks
				break;
			case 3:
				colName = "after"; // stacks
				break;
			default:
				colName = "N/A";
				break;
		}

		// make headers not overlap with each other
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + tabHeight, false);
		
		
		// draw header name
		draw_set_color(global.colorThemeText);
		draw_set_valign(fa_middle);


		scr_adaptFont(colName, "M");
			

			
		draw_text(headerTextX, headerTextY, colName);
		
	


		draw_set_color(global.colorThemeBorders);
		draw_line_width(headerRectX1, y, headerRectX1, y + windowHeight, 1);


		
		headerPlusX += colWidth;

	}


	// draw horizontal line between headers and contents
	draw_line(x , y + tabHeight , x + windowWidth , y + tabHeight);


}