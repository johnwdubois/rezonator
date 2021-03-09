function scr_panelPane_drawUnits1to1() {
	/*
	    Purpose: Draw the translation of each line in the Nav window
	*/
	
	
	// Access the lineList panelPane object to get it's scrollPlusY

	var lineListPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			lineListPanelPaneInst = self.id;
		}
	}



	var strHeight = string_height("0") * 1.5;
	
	
	var drawScrollbar = (obj_control.showUnitTags);
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : lineListPanelPaneInst.scrollPlusY;
	
	

	

	// Set text margin area
	var filterRectMargin = 8;
	var filterRectSize = (strHeight / 2) + 5;
	var textMarginLeft = filterRectMargin;

	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var chainNameRectMinusY = 4;
	
	var mouseoverScrollBar = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + headerHeight, x + windowWidth, y + windowHeight);
	var focusedElementY = -1;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;
	var xbuffer = (windowWidth / 6);

	var drawDropDowns = false;


	var headerListSize = unitContentsHeaderListSize;
	unitContentsHeaderListSize = min(6, max(1, ds_grid_width(global.unitImportGrid)));
	headerListSize = unitContentsHeaderListSize;


	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);

	//scr_surfaceStart();
	// Not doing a surface here so it can scroll along with the left Navwindow

	var lineGridHeight = ds_grid_height(obj_control.lineGrid);
	var widthOfUnitGrid = 1;
	if (ds_exists(global.unitImportColNameList, ds_type_list)) {
		widthOfUnitGrid = ds_list_size(global.unitImportColNameList);
	}


	for (var j = 0; j < headerListSize; j++) {
	
		textPlusY = 0;
		drawDropDowns = false;


	    var colRectX1 = x + (j * (windowWidth / 6));
	    var colRectY1 = y;
	    var colRectX2 = colRectX1 + (windowWidth / 6);
	    var colRectY2 = colRectY1 + windowHeight;
		// if this is the last column, extend it to the end of the window
		if (j == headerListSize - 1) {
			colRectX2 = x + windowWidth;
		}
    
	    draw_set_color(global.colorThemeBG);
	    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);

		var discoTagUnitView = false;
		var isUnitIDCol = false;
		if (j > 0) {
			var importColReal = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
			var colName = ds_list_find_value(global.unitImportColNameList, importColReal);
			if (ds_list_find_index(global.discoImportColNameList, colName) > -1) {
				discoTagUnitView = true;
			}
			if (colName == "UnitID") {
				isUnitIDCol = true;
			}
		}
	

		for (var i = 0; i < lineGridHeight; i++) {
    
		    if (y + headerHeight + relativeScrollPlusY + textPlusY < y - strHeight
		    or y + headerHeight + relativeScrollPlusY + textPlusY > y + windowHeight + strHeight) {
		        textPlusY += strHeight;
		        continue;
		    }

    
		    // Get grid info of current chain
		    var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, i);
		    var currentLineState = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colLineState, i);
		    var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1); // Access color of line
		    var lineSpeaker = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentLineUnitID - 1);
			
		    // Prevent those pesky comments from showing up in the line list
		    if (lineSpeaker == "COMMENT") {
		        continue;
		    }
    
		    var discoColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colDiscoColor, currentLineUnitID - 1);
		    if (!is_numeric(discoColor)) {
		        discoColor = obj_control.c_ltblue;
		    }
			if (!is_numeric(lineColor)) {
		        lineColor = c_gray;
		    }

		    var currentLineWordString = "";
		    if (ds_grid_height(global.importGrid) > 0) {
		        currentLineWordString = ds_grid_get(global.importGrid, 12, i + 1);
		    }
		    else {
		        var currentLineWordList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentLineUnitID - 1);
		        var currentLineWordListSize = ds_list_size(currentLineWordList);
				for(var wordListLoop = 0; wordListLoop < currentLineWordListSize; wordListLoop++) {
		            var currentWordID = ds_list_find_value(currentLineWordList, wordListLoop);
		            var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
		            currentLineWordString += currentWordTranscript + " ";
		        }
		    }
    
		    // Get dimensions of rectangle around line name
		    var lineRowRectX1 = x;
		    var lineRowRectY1 = y + headerHeight + textPlusY + relativeScrollPlusY - (strHeight / 2);
		    var lineRowRectX2 = x + windowWidth;
		    var lineRowRectY2 = lineRowRectY1 + strHeight;
			var mouseoverLineRowRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, lineRowRectX1, max(lineRowRectY1, y + headerHeight), lineRowRectX2, lineRowRectY2) && !mouseoverScrollBar;
    
		    //Check mouse clicks to focus a line in the list
		    if (mouseoverLineRowRect && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)) {
				drawDropDowns = true;
				with (obj_panelPane) {
					unitTagsHighlightRow = i;
				}
        
		        if (device_mouse_check_button_released(0, mb_left)) {
		            ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
		            ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, i, 1);
		            with (obj_panelPane) {
		                functionChainList_lineGridRowFocused = i;
		                functionChainContents_BGColor = lineColor;
		            }
		        }
		    }
			
			
			
			if (unitTagsHighlightRow == i) {
				
				// highlight rect
				draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, 0.4));
				draw_rectangle(colRectX1 - clipX, lineRowRectY1 - clipY, colRectX2 - clipX, lineRowRectY2 - clipY, false);
				
				
				if (j > 0) {
					if (!discoTagUnitView && !isUnitIDCol) {
						// dropdown buttons
						var dropDownButtonX1 = colRectX2 - sprite_get_width(spr_dropDown) - 4;
						if (j == headerListSize - 1) dropDownButtonX1 -= global.scrollBarWidth;
						var dropDownButtonY1 = lineRowRectY1;
						var dropDownButtonX2 = dropDownButtonX1 + sprite_get_width(spr_dropDown);
						var dropDownButtonY2 = lineRowRectY2;
						var mouseoverDropDownButton = point_in_rectangle(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2);
					
						draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
						if (mouseoverDropDownButton) {
							scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, "Change tag", obj_tooltip.arrowFaceUp);
							draw_set_alpha(1);
							draw_set_color(global.colorThemeBorders);
							draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				
							if (mouse_check_button_released(mb_left)) {
					
								with (obj_panelPane) {
									selectedColUnit = j;
								}
								
								var dropDownOptionList = ds_list_create();
								var colIndex = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
								var mapKey = ds_list_find_value(global.unitImportColNameList, colIndex);
								var tagMapList = ds_map_find_value(global.unitImportTagMap, mapKey);
						
								if (!is_undefined(tagMapList)) {
									ds_list_copy(dropDownOptionList, tagMapList);
									obj_control.unitImportColToChange = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
									obj_control.unitImportRowToChange = currentLineUnitID - 1;
								
									var dropDownX = colRectX1;
									var dropDownY = lineRowRectY2;

									if (ds_list_size(dropDownOptionList) > 0 ) {
										var dropDownInst = instance_create_depth(dropDownX, dropDownY , -999, obj_dropDown);
										dropDownInst.optionList = dropDownOptionList;
										dropDownInst.optionListType = global.optionListTypeUnitTagMap;

									}
								}
							}
						}
					}
				}
			}
			draw_set_alpha(1);
    
    
		    //Color codes the line lists for User
		    draw_set_color(discoColor); //soften the color
    
		    // Outline the rectangle in black
		    if (currentLineState == 1) {
		        focusedRowRectY1 = lineRowRectY1;
		        focusedRowRectY2 = lineRowRectY2;
		        focusedElementY = y + headerHeight + relativeScrollPlusY + textPlusY;
		    }

    
		    // Draw text of unit tags
		    draw_set_halign(fa_left);
		    draw_set_valign(fa_middle);
		    draw_set_color(global.colorThemeText);
		
			var tagToDraw = "";
			var unitImportGridRow = currentLineUnitID - 1;
		
			var importCol = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
			if (importCol != undefined) {
				tagToDraw = string(ds_grid_get(global.unitImportGrid, importCol, unitImportGridRow));
			}
			else {
				tagToDraw = ds_grid_get(global.unitImportGrid, j, unitImportGridRow);
			}
		
		
			tagToDraw = (tagToDraw == undefined) ? "" : tagToDraw;
			scr_adaptFont(string(tagToDraw), "S");
		    draw_text(x + (textMarginLeft) + (xbuffer*j) - clipX, y + headerHeight + relativeScrollPlusY + textPlusY - clipY, string(tagToDraw));
    
		    // Get height of chain name
		    textPlusY += strHeight;
		}

	}



	// draw focus outline
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}



	// draw BG for headers
	var headerHeight = functionTabs_tabHeight;
	draw_set_color(global.colorThemeSelected2);
	draw_rectangle(x - clipX, colRectY1 - clipY, x + windowWidth - clipX, colRectY1 + headerHeight - clipY, false);

	// Create the column headers
	var activeCols = 0;
	for (var i = 0; i < headerListSize; i++) {
	    var colRectX1 = x + (i * (windowWidth / 6));
	    var colRectY1 = y;
	    var colRectX2 = colRectX1 + (windowWidth / 6);
		var colWidth = colRectX2 - colRectX1;
	    var colRectY2 = colRectY1 + windowHeight;
		
		// dividing lines
		if (i > 0) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBG);
			draw_line(colRectX1 - clipX, y - clipY, colRectX1 - clipX, y + headerHeight - clipY);
			draw_set_color(global.colorThemeBorders);
			draw_line(colRectX1 - clipX, y + headerHeight - clipY, colRectX1 - clipX, y + windowHeight - clipY);
		}
		
		// if this is the last column, extend it to the end of the window
		if (i == headerListSize - 1) {
			colRectX2 = x + windowWidth;
		}
    
	    var colName = "";
    
		var nameFromList =  ds_list_find_value(global.unitImportColNameList, i);
		if(i != 0){
			var unitColValue = ds_list_find_value(obj_control.currentDisplayUnitColsList, i - 1);
			nameFromList = ds_list_find_value(global.unitImportColNameList, unitColValue);
		}	
		if(nameFromList == undefined){
				nameFromList = "";
		}
		colName = nameFromList
    
	    draw_set_color(global.colorThemeBG);
	    draw_set_valign(fa_middle);
	    scr_adaptFont(colName, "M")
	    draw_text(colRectX1 + 4 - clipX, floor(y + (headerHeight / 2)) - clipY, colName);
	
		var notDiscoTag = (ds_list_find_index(global.discoImportColNameList, colName) == -1);
		var isUnitIDCol = (colName == "UnitID");
		var isTildaField = false;
		if (typeof(colName) == "string") {
			isTildaField = (string_char_at(colName, 1) == "~");
		}



	
		// draw wordView button
		var wordViewButtonSize = (headerHeight / 4);
		var wordViewButtonX = colRectX2 - wordViewButtonSize - 4;
		var wordViewButtonY = colRectY1 + (headerHeight) - (headerHeight / 4)/2 - 10;
	
	
		//draw token selection button
		var dropDownButtonSize = sprite_get_width(spr_dropDown);
		var dropDownRectX1 = wordViewButtonX - 16 - dropDownButtonSize;
		var dropDownRectY1 = colRectY1 + (dropDownButtonSize * 0.6);
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonSize;
		var dropDownRectY2 = colRectY1 + headerHeight - (dropDownButtonSize * 0.2);
	


	
		if(i == 0 ){
		}
		else{
			var tempColRectX2 = x + ((activeCols + 1) * (windowWidth / 6)) - (windowWidth / 6);
			if (point_in_rectangle(mouse_x, mouse_y, colRectX1, colRectY1, colRectX2, colRectY1 + headerHeight)) {
				if (mouse_check_button_released(mb_right)) {
					with (obj_dropDown) {
						instance_destroy();
					}
					with (obj_panelPane) {
						chosenCol = i;
					}
					obj_control.unitImportColToChange = ds_list_find_index(global.unitImportColNameList, colName);
					var dropDownOptionList = ds_list_create();		
					ds_list_add(dropDownOptionList, "Set as Translation", "Create Field");
					if (notDiscoTag && !isUnitIDCol && !isTildaField) {
						ds_list_add(dropDownOptionList, "Add new Tag");
					}
					//ds_list_add(dropDownOptionList, "Set as Translation");
					if (ds_list_size(dropDownOptionList) > 0) {
						var dropDownInst = instance_create_depth(colRectX1, colRectY1 + headerHeight, -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = global.optionListTypeUnitMarker;
					}
				}
			}
		
		
			//user interaction for token selection
			if (point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2)) {
				scr_createTooltip(mean(dropDownRectX1, dropDownRectX2), dropDownRectY2, "Change field", obj_tooltip.arrowFaceUp);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(dropDownRectX1- clipX, dropDownRectY1 - clipY, dropDownRectX2 - clipX, dropDownRectY2 - clipY, true);

				if (mouse_check_button_released(mb_left)) {
					with(obj_panelPane){
						chosenCol = i;
					}

					var dropDownOptionList = ds_list_create();

					ds_list_copy(dropDownOptionList, global.unitImportColNameList);

					if (ds_list_size(dropDownOptionList) > 0 ) {
						var dropDownInst = instance_create_depth(colRectX1,colRectY1+headerHeight , -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = global.optionListTypeUnitSelection;
					}
				}
			}
		

	
	
			//user interaction for display view change
			if (point_in_circle(mouse_x, mouse_y, wordViewButtonX, wordViewButtonY, wordViewButtonSize)) {
				scr_createTooltip(wordViewButtonX, wordViewButtonY + wordViewButtonSize, "Speaker", obj_tooltip.arrowFaceUp);
				draw_set_color(global.colorThemeBG);
				draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize * 0.75, false);
				if (mouse_check_button_released(mb_left)) {
					obj_control.unitView = i;
			
					var toggleTranscriptionGrid = -1;
					var toggleTranscriptionCol = -1;

					toggleTranscriptionGrid = global.unitImportGrid;

					var colIndex =  ds_list_find_value(obj_control.currentDisplayUnitColsList,obj_control.unitView-1);
					toggleTranscriptionCol = colIndex;

				
					scr_toggleUnitMulti(toggleTranscriptionGrid, toggleTranscriptionCol);
				}
			}
			
			// draw circle for selecting unit tag
			draw_set_color(global.colorThemeBG);
			draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize, true);
			draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
	
			// draw filled in circle if this unit tag is chosen
			if (obj_control.unitView == i) {
				draw_set_color(global.colorThemeBG);
				draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize * 0.75, false);
				draw_set_color(global.colorThemeBG);
			}
			else {
				draw_set_color(global.colorThemeText);
			}

	
		}
	
		activeCols++;
	}








	// will create a focusedLine vriable in panelPane create, update it when changed, no gridValueY
	var instToScroll = (drawScrollbar) ? self.id : chainContentsPanelPaneInst;

	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	if (clickedIn) {    
	    if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
            
	        if (functionChainList_lineGridRowFocused > 0 and functionChainList_lineGridRowFocused < ds_grid_height(obj_control.lineGrid)) {

	            //Allow for arrow keys to shift focus down the list of lines
	            obj_panelPane.functionChainList_lineGridRowFocused--;
	            var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
	            var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
	            obj_panelPane.functionChainContents_BGColor = lineColor;
	            ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
	            ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
            
            

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
            
	        if (functionChainList_lineGridRowFocused < ds_grid_height(obj_control.lineGrid) - 1 and functionChainList_lineGridRowFocused >= 0) {

	            //Allow for arrow keys to shift focus down the list of lines
	            obj_panelPane.functionChainList_lineGridRowFocused++;
	            var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
	            var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
	            obj_panelPane.functionChainContents_BGColor = lineColor;
	            ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
	            ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
            

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
	
	if (obj_control.showUnitTags) {
		scr_scrollBar(ds_grid_height(obj_control.lineGrid), focusedElementY, strHeight, headerHeight,
		    global.colorThemeSelected1, global.colorThemeSelected2,
		    global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}






}
