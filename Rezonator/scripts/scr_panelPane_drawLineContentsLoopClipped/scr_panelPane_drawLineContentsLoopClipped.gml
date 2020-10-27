function scr_panelPane_drawLineContentsLoopClipped() {
	/*
		scr_panelPane_drawLineContentsLoop();
	
		Last Updated: 2019-012-28
	
		Called from: obj_panelPane
	
		Purpose: whatever Line is focused on in the lineList panelPane, draw information on the individual words of that Line
	
		Mechanism: loop through the IDList of the focused Line and gather information from corresponding grids
	
		Author: Terry DuBois, Georgio Klironomos
	*/


	// Set opacity, alignment, and font of contents list
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(global.fontChainContents);
	var strHeight = string_height("0");
	draw_set_font(global.fontPanelTab);
	var tabHeight = functionChainList_tabHeight;
	var scrollBarListHeight = 0;
	var drawDropDowns = false;


	var grid = obj_control.currentActiveLineGrid;




	if (functionChainContents_colXList == -1 or is_undefined(functionChainContents_colXList)) {
		exit;
	}


	var rowInLineGrid = functionChainList_lineGridRowFocused;



	// Set text margins
	var textMarginTop = tabHeight;
	var textPlusY = 0;
	var ableToBeMouseOver = true;

	var xBuffer = 6;

	// Create scroll bars
	global.scrollBarWidth = 16;

	var focusedChainExists = false;
	var alignRectSize = strHeight;
	var oldRow = -1;

	var focusedElementY = -1;

	if (!instance_exists(obj_dropDown)) {
		lineContentsHighlightRow = -1;
	}




	// Check for focused chain and make sure grid is not empty, gather information from grids
	if (ds_grid_height(grid) != 0 and functionChainList_lineGridRowFocused >= 0
	and functionChainList_lineGridRowFocused < ds_grid_height(grid)) {
		// Collect beginning of chain info
		focusedChainExists = true;
		var unitID = ds_grid_get(grid, obj_control.lineGrid_colUnitID, rowInLineGrid);
	
		if (unitID >= 0) {
	
			// Get wordID list
			with (obj_panelPane) {
				functionChainContents_IDList = ds_grid_get(grid, obj_control.lineGrid_colWordIDList, rowInLineGrid);
		
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
	
			if (functionChainContents_IDList != undefined) {
		
				scrollBarListHeight = ds_list_size(functionChainContents_IDList);
			

	
				// Gather specfic information on words
				var IDListSize = ds_list_size(functionChainContents_IDList);
				for (var j = 0; j < IDListSize; j++) {
					drawDropDowns = false;
					//Get info on current word
					var currentWordID = ds_list_find_value(functionChainContents_IDList, j);
					var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID-1);
					if(currentWordState == 3){
						continue;
					}
				
					var currentWordInfoCol;
					currentWordInfoCol[0] = "";
		
					//Set size of rectangle around word
					var rectX1 = x;
					var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
					var rectX2 = x + windowWidth - global.scrollBarWidth;
					var rectY2 = rectY1 + strHeight;
				


					if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, max(rectY1, y + tabHeight), rectX2, rectY2) and ableToBeMouseOver and !instance_exists(obj_dropDown)
					and !instance_exists(obj_dialogueBox)) {
						drawDropDowns = true;
						ableToBeMouseOver = false;
						lineContentsHighlightRow = j;
					}
					if (lineContentsHighlightRow == j) {
						draw_set_alpha(0.25);
						draw_set_color(global.colorThemeText);
						draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, false);
					}
				
					draw_set_alpha(1);
	
					// Check for double click
					if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2)) {

						if(device_mouse_check_button_released(0, mb_left)){
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
						}
						else {
			
							//ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
							//ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, i, 1);
							with (obj_panelPane) {
								functionChainContents_lineGridRowFocused = j;
								//functionChainContents_BGColor = lineColor;
							}
							doubleClickTimer = 0;
						}
		
					}
			
					var infoListSize = 3;
					if (functionChainList_currentTab == functionChainList_tabLine) {
						infoListSize = tokenContentsHeaderListSize;
					}
				
					var activeCols = 0;
					// Set collected info into respective columns
					for (var getInfoLoop = 0; getInfoLoop < infoListSize; getInfoLoop++) {
					
						// if this is the transcript column, and there's no transcript, skip it!
						if (getInfoLoop == 3 and !obj_control.transcriptAvailable) {
							continue;
						}
					
						var unitOrWordTagTokenView = false;
					
						currentWordInfoCol[getInfoLoop] = "";
					
						if (getInfoLoop == 0) {

								//var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
								currentWordInfoCol[getInfoLoop] = currentWordID //string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1));

						}
						else if (getInfoLoop == 1) {
							if (functionChainList_currentTab == functionChainList_tabStackBrush
							or functionChainList_currentTab == functionChainList_tabClique) {
								currentWordInfoCol[getInfoLoop] = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentWordID - 1);
							}
							else {
								currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1));
							}
						}
						/*
						else if (getInfoLoop == 2) {
							if (functionChainList_currentTab == functionChainList_tabStackBrush
							or functionChainList_currentTab == functionChainList_tabClique) {
								currentWordInfoCol[getInfoLoop] = "";
								var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentWordID - 1);
								if (currentWordIDList == undefined) {
									break;
								}
								var currentWordIDListSize = ds_list_size(currentWordIDList);
								for (var i = 0; i < currentWordIDListSize; i++) {
									var currentWordID = ds_list_find_value(currentWordIDList, i);
									var currentWordString = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
									currentWordInfoCol[getInfoLoop] += string(currentWordString) + " ";
								}
						
								if (string_length(currentWordInfoCol[getInfoLoop]) > 100) {
									currentWordInfoCol[getInfoLoop] = string_delete(currentWordInfoCol[getInfoLoop], 100, string_length(currentWordInfoCol[getInfoLoop]) - 100);
									currentWordInfoCol[getInfoLoop] += "...";
								}
							}
							else {
								currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1));
							}
						}
						*/
						else if (getInfoLoop >= 2) {
							if(getInfoLoop == 2) {
								var importCol = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop-2);
							
							
							}
							else{
								var importCol = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop-3);
							}
							//show_message(string(importcol));
							if( importCol != undefined ){
								currentWordInfoCol[getInfoLoop] = string(ds_grid_get(global.tokenImportGrid, importCol, currentWordID - 1));
							}
							else{
								currentWordInfoCol[getInfoLoop] = "";
							}
	
							var colName = ds_list_find_value(global.tokenImportColNameList, importCol);
							if (ds_list_find_index(global.unitImportColNameList, colName) != -1 && ds_list_find_index(global.wordImportColNameList, colName) != -1) {
								unitOrWordTagTokenView = true;
							}
							
						
						}
					
			
						if(getInfoLoop == 0 or getInfoLoop ==1){
							var textX = x + (activeCols * (windowWidth / 12)) + xBuffer;
						}
						else{
							var textX = x + (activeCols * (windowWidth / 6)) + xBuffer - (windowWidth / 6);
						}
						var textY = y + textMarginTop + textPlusY;
			
						draw_set_color(global.colorThemeText);
						draw_set_alpha(1);
						draw_set_valign(fa_middle);
						draw_set_font(global.fontChainContents);
						draw_text(textX - clipX + 2, textY - clipY + scrollPlusY, currentWordInfoCol[getInfoLoop]);
					
					
						var scrollBarBuffer = 0;				
						if(getInfoLoop >= 7){
							scrollBarBuffer = global.scrollBarWidth;
						}

						var dropDownButtonSize = (tabHeight / 2);
						var dropDownButtonWidthSize = sprite_get_width(spr_dropDown);
						var dropDownRectX1 = textX + (windowWidth / 6) - 16 - scrollBarBuffer - dropDownButtonWidthSize;
						var dropDownRectY1 = textY - (strHeight / 2) + 5 + scrollPlusY;
						var dropDownRectX2 = dropDownRectX1 + dropDownButtonWidthSize;
						var dropDownRectY2 = dropDownRectY1 + dropDownButtonSize;

					

					
						if(getInfoLoop >= 2) {
						//draw tag selection
						
							if (getInfoLoop >= 3) {
								var colIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 3);
							}
							else {
								var colIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 2);
							}
							var mapKey = ds_list_find_value(global.tokenImportColNameList, colIndex);
							var isTildaField = (string_char_at(string(mapKey), 1) == "~");

							if (drawDropDowns && !unitOrWordTagTokenView && ds_map_exists(global.tokenImportTagMap, mapKey) && !isTildaField) {
								
								var tagMapList = ds_map_find_value(global.tokenImportTagMap, mapKey);
								draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, c_white, 1);
				
								if (point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2)) {
									
									scr_createTooltip(mean(dropDownRectX1, dropDownRectX2), dropDownRectY2, "Change tag", obj_tooltip.arrowFaceUp);
									draw_set_color(global.colorThemeBorders);
						
									draw_rectangle(dropDownRectX1- clipX, dropDownRectY1 - clipY , dropDownRectX2 - clipX, dropDownRectY2 - clipY, true);

									if (mouse_check_button_released(mb_left)) {
										with (obj_panelPane) {
											selectedColToken = getInfoLoop;
										}
								
										var dropDownOptionList = ds_list_create();
										if (getInfoLoop >= 3) {
											if (!is_undefined(dropDownOptionList) && !is_undefined(tagMapList)) {
												ds_list_copy(dropDownOptionList, tagMapList);
												obj_control.tokenImportColToChange = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 3);
												obj_control.tokenImportRowToChange =currentWordID-1;
											}
										}
										else {
											if (!is_undefined(dropDownOptionList) && !is_undefined(tagMapList)) {
												ds_list_copy(dropDownOptionList, tagMapList);
												obj_control.tokenImportColToChange = ds_list_find_value(obj_control.currentDisplayTokenColsList, getInfoLoop - 2);
												obj_control.tokenImportRowToChange = currentWordID - 1;
											}
										}
								
										var dropDownX = textX - xBuffer;
										var dropDownY = textY + scrollPlusY + (strHeight / 2);

								

										if (ds_list_size(dropDownOptionList) > 0 ) {
											var dropDownInst = instance_create_depth(dropDownX, dropDownY , -999, obj_dropDown);
											dropDownInst.optionList = dropDownOptionList;
											dropDownInst.optionListType = dropDownInst.optionListTypeTokenTagMap;

										}
								
						


									}
				
								}
							}
					
					
						}
					
						activeCols++;
					}
				
			
			
					textPlusY += strHeight;
				} 
			}
		}
	}




	draw_set_font(global.fontChainContents);
	var strHeight = string_height("0");


	var scrollBarListSize = 0;
	if (functionChainContents_IDList != undefined) {
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


	draw_set_alpha(1);


	draw_set_font(global.fontPanelTab);


	draw_set_color(global.colorThemeBG);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + tabHeight - clipY, false);

	var headerListSize = 3;
	tokenContentsHeaderListSize = min(8,max(3,ds_grid_width(global.tokenImportGrid)));
	if (functionChainList_currentTab == functionChainList_tabLine) {
		headerListSize = tokenContentsHeaderListSize;
	}



	/*if(obj_control.showDevVars) {
		headerListSize = 6;
	}*/
	// Create the column headers
	var activeCols = 0;
	for (var i = 0; i < headerListSize; i++) {
	
		// if this is the transcript column, and there's no transcript, skip it!
		if (i == 3 and !obj_control.transcriptAvailable) {
			continue;
		}
	
		if(i == 0 or i ==1){
			var colRectX1 = x + (activeCols * (windowWidth / 12));
		}
		else{
			var colRectX1 = x + (activeCols * (windowWidth / 6))- (windowWidth / 6);
		}
		var colRectY1 = y;
		if(i == 0 or i ==1){
			var colRectX2 = x + (activeCols * (windowWidth / 12));
		}
		else{
			var colRectX2 = colRectX1 ;
		}
		var colRectY2 = colRectY1 + windowHeight;
	
		var colName = "";
	
	
		if (i == 0) {
			colName = "tokenID";
		}
		else if (i == 1) {
			colName = "place";
		}
		else if(i >= 2 and i < 8) {
			if(i == 2){
				var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList,i-2)
			}
			else{
				var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList,i-3)
			}
			colName = ds_list_find_value(global.tokenImportColNameList, colIndex);
		}
	
		var notUnitOrDiscoOrWordTag = ((ds_list_find_index(global.unitImportColNameList, colName) == -1) && (ds_list_find_index(global.discoImportColNameList, colName) == -1) && (ds_list_find_index(global.wordImportColNameList, colName) == -1));
	
	
		// draw lines to separate columns
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
	
		// draw column header names
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_font(global.fontPanelTab);
		draw_text(colRectX1 + 4 - clipX, y - clipY, colName);
	
		// draw wordView button
		var wordViewButtonSize = (tabHeight / 3);
		var wordViewButtonX = colRectX2 - wordViewButtonSize - 4 + (windowWidth / 6);
		var wordViewButtonY = colRectY1 + (tabHeight / 2);
	
	
		//draw token selection button
		var dropDownButtonSize = sprite_get_width(spr_dropDown);
		var dropDownRectX1 = wordViewButtonX - 16 - dropDownButtonSize;
		var dropDownRectY1 = y + (dropDownButtonSize * 0.2);
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonSize;
		var dropDownRectY2 = y + tabHeight - (dropDownButtonSize * 0.2);
	
		if (i >= 2) {
			var tempColRectX2 = x + ((activeCols + 1) * (windowWidth / 6)) - (windowWidth / 6);
			if (point_in_rectangle(mouse_x, mouse_y, colRectX1, colRectY1, tempColRectX2, colRectY1 + tabHeight)) {
				if (mouse_check_button_released(mb_right)) {
					with (obj_dropDown) {
						instance_destroy();
					}
					with(obj_panelPane) {
						chosenCol = i;
					}
					obj_control.tokenImportColToChange = ds_list_find_index(global.tokenImportColNameList, colName);
					var dropDownOptionList = ds_list_create();
					ds_list_add(dropDownOptionList, "Create Field");
					if (notUnitOrDiscoOrWordTag) {
						ds_list_add(dropDownOptionList, "Add new Tag"); // only add the "Add new Tag" option if this is a token-level field
					}
					//ds_list_add(dropDownOptionList, "Set as Transcript");
					if (ds_list_size(dropDownOptionList) > 0) {
						var dropDownInst = instance_create_depth(colRectX1, colRectY1 + tabHeight, -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = dropDownInst.optionListTypeTokenMarker;
					}
				}
			}
		}


	
		if(i == 0 or i ==1){
		}
	
		else {
		
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
				
					if (!is_undefined(dropDownOptionList) && !is_undefined(global.tokenImportColNameList)) {
						ds_list_copy(dropDownOptionList, global.tokenImportColNameList);
						if (ds_list_size(dropDownOptionList) > 0 ) {
							var dropDownInst = instance_create_depth(colRectX2,colRectY1+tabHeight , -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = dropDownInst.optionListTypeTokenSelection;
							//obj_control.ableToCreateDropDown = false;
							//obj_control.alarm[0] = 2;
						}
					}
				}
			}
		

	
	
			//user interaction for display view change
			if (point_in_circle(mouse_x, mouse_y, wordViewButtonX, wordViewButtonY, wordViewButtonSize) && !instance_exists(obj_dropDown)) {
				
				scr_createTooltip(wordViewButtonX, wordViewButtonY + wordViewButtonSize, "Display token", obj_tooltip.arrowFaceUp);
				draw_set_color(global.colorThemeSelected2);
				draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize * 0.75, false);
				if (mouse_check_button_released(mb_left)) {
					obj_control.wordView = i;
			
					var toggleTranscriptionGrid = -1;
					var toggleTranscriptionCol = -1;
					if (i == 0) {
						toggleTranscriptionGrid = obj_control.wordGrid;
						toggleTranscriptionCol = obj_control.wordGrid_colUtteranceID;
					}
					else if (i == 1) {
						toggleTranscriptionGrid = obj_control.wordGrid;
						toggleTranscriptionCol = obj_control.wordGrid_colWordSeq;
					}

					else if (i == 2) {
						toggleTranscriptionGrid = global.tokenImportGrid;
						var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList,i-2)
						toggleTranscriptionCol =  colIndex;
					
					
					}
					else if (i >= 3 and i < 8) {
						toggleTranscriptionGrid = global.tokenImportGrid;
						var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList,i-3)
						toggleTranscriptionCol = colIndex;
					
					
					}
				
					scr_toggleTranscriptionMulti(toggleTranscriptionGrid, toggleTranscriptionCol);
				}
			}
	

			draw_set_color(global.colorThemeBorders);
			draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize, true);
			draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, c_white, 1);
		}
	
	
	
		if (obj_control.wordView == i) {
			draw_set_color(global.colorThemeBorders);
			draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize * 0.75, false);
			draw_set_color(global.colorThemeBG);
		}
		else {
			draw_set_color(global.colorThemeText);
		}


		activeCols++;
	}
	draw_set_alpha(1);







	// draw line to separate column headers from data
	draw_set_color(global.colorThemeBorders);
	draw_line(x - clipX, y + tabHeight - clipY, x + windowWidth - clipX, y + tabHeight - clipY);

	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainContents
	if (clickedIn) {
	
		// Scroll up with mouse/key
		if (((mouse_wheel_up() || keyboard_check(vk_up)) and (obj_panelPane.holdUp < 2 || obj_panelPane.holdUp > 30)) and !instance_exists(obj_dropDown)) {
			scrollPlusYDest += strHeight;
		}
	
		// Scroll down with mouse/key
		if (((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30))  and !instance_exists(obj_dropDown)) {
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






}
