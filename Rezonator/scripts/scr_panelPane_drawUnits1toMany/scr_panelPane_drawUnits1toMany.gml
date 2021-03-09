function scr_panelPane_drawUnits1toMany() {
	
	if (live_call()) return live_result;
	
	/*
		Purpose: whatever Line is focused on in the lineList panelPane, draw information on the individual words of that Line
	*/

	// Set opacity, alignment, and font of contents list
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("0");
	var headerHeight = functionTabs_tabHeight;
	var scrollBarListHeight = 0;
	var drawDropDowns = false;


	var grid = obj_control.currentActiveLineGrid;




	if (functionChainContents_colXList == -1 or is_undefined(functionChainContents_colXList)) {
		exit;
	}


	var rowInLineGrid = functionChainList_lineGridRowFocused;



	// Set text margins
	var textMarginTop = headerHeight;
	var textPlusY = 0;
	var ableToBeMouseOver = true;


	// Create scroll bars

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
					if(currentWordState == obj_control.wordStateDead){
						continue;
					}
				
					var currentWordInfoCol;
					currentWordInfoCol[0] = "";
		
					//Set size of rectangle around word
					var rectX1 = x;
					var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
					var rectX2 = x + windowWidth - global.scrollBarWidth;
					var rectY2 = rectY1 + strHeight;
					var mouseoverRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, max(rectY1, y + headerHeight), rectX2, rectY2);

					if (mouseoverRect and ableToBeMouseOver and !instance_exists(obj_dropDown)
					and !instance_exists(obj_dialogueBox)) {
						drawDropDowns = true;
						ableToBeMouseOver = false;
						lineContentsHighlightRow = j;
					}
				
					draw_set_alpha(1);
	
					// Check for double click
					if (mouseoverRect) {
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
							with (obj_panelPane) {
								functionChainContents_lineGridRowFocused = j;
							}
							doubleClickTimer = 0;
						}
					}
					
					scr_panelPane_drawUnits1toManyInnerLoop(currentWordID, drawDropDowns, strHeight, textPlusY, rectY1, rectY2, (lineContentsHighlightRow == j));
			
					textPlusY += strHeight;
				} 
			}
		}
	}





	var strHeight = string_height("0");


	var scrollBarListSize = 0;
	if (functionChainContents_IDList != undefined) {
		if (ds_exists(functionChainContents_IDList, ds_type_list)) {
			scrollBarListSize = ds_list_size(functionChainContents_IDList) + 2;
		}
	}

	var scrollBarBackColor = global.colorThemeSelected1;
	if (scrollBarListSize > 1000) {
		scrollBarBackColor = global.colorThemeSelected2;
	}

	scr_scrollBar(scrollBarListSize, focusedElementY, strHeight, headerHeight,
		scrollBarBackColor, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);


	draw_set_alpha(1);




	draw_set_color(global.colorThemeBG);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + headerHeight - clipY, false);

	var headerListSize = 3;
	tokenContentsHeaderListSize = min(8, max(3, ds_grid_width(global.tokenImportGrid)));
	if (functionChainList_currentTab == functionChainList_tabLine) {
		headerListSize = tokenContentsHeaderListSize;
	}


	// Create the column headers
	var lastCol = headerListSize - 1;
	if (!obj_control.transcriptAvailable && headerListSize == 4) lastCol = 2;
	
	var activeCols = 0;
	for (var i = 0; i < headerListSize; i++) {
		
		// if this is the transcript column, and there's no transcript, skip it!
		if (i == 3 and !obj_control.transcriptAvailable) {
			continue;
		}
		
		// get column coordinates
		var colRectX1 = 0;
		var colRectX2 = 0;
		var colWidth = 0;
		if (i == 0 or i == 1) {
			colWidth = windowWidth / 12;
			colRectX1 = x + (activeCols * colWidth);
		}
		else {
			colWidth = windowWidth / 6;
			colRectX1 = x + (activeCols * colWidth) - colWidth;
		}
		
		if (i == lastCol) {
			colWidth = x + windowWidth - colRectX1;
		}
		colRectX2 = colRectX1 + colWidth;
		var colRectY1 = y;
		var colRectY2 = colRectY1 + headerHeight;
		
		

		
	
		// get column name
		var colName = "";
		if (i == 0) {
			colName = "tokenID";
		}
		else if (i == 1) {
			colName = "place";
		}
		else if(i >= 2 and i < 8) {
			if (i == 2) {
				var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList, i - 2);
			}
			else{
				var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList, i - 3);
			}
			colName = ds_list_find_value(global.tokenImportColNameList, colIndex);
		}
	
		var notUnitOrDiscoOrWordTag = ((ds_list_find_index(global.unitImportColNameList, colName) == -1) && (ds_list_find_index(global.discoImportColNameList, colName) == -1) && (ds_list_find_index(global.wordImportColNameList, colName) == -1));
		var isTildaField = false;
		if (is_string(colName)) {
			isTildaField = (string_char_at(colName, 1) == "~");
		}
	
		// draw BG rects & lines to separate columns
		draw_set_alpha(1);
		draw_set_color(global.colorThemeSelected2);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
		if (i > 0) {
			draw_set_color(global.colorThemeBorders);
			draw_line(colRectX1 - clipX, colRectY1 + headerHeight - clipY, colRectX1 - clipX, y + windowHeight - clipY);
			draw_set_color(global.colorThemeBG);
			draw_line(colRectX1 - clipX, colRectY1 - clipY, colRectX1 - clipX, y + headerHeight - clipY);
		}

		// draw column header names
		draw_set_color(global.colorThemeBG);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		scr_adaptFont(colName, "M");
		draw_text(colRectX1 + 8 - clipX, floor(y + (headerHeight / 2)) - clipY, colName);
	
		// draw wordView button
		var wordViewButtonSize = (headerHeight / 4);
		var wordViewButtonX = colRectX2 - wordViewButtonSize - 4;
		var wordViewButtonY = mean(colRectY1, colRectY2);
	
		//draw token selection button
		var dropDownButtonSize = sprite_get_width(spr_dropDown);
		var dropDownRectX1 = wordViewButtonX - 16 - dropDownButtonSize;
		var dropDownRectY1 = colRectY1 + (dropDownButtonSize * 0.25);
		var dropDownRectX2 = dropDownRectX1 + dropDownButtonSize;
		var dropDownRectY2 = colRectY2 - (dropDownButtonSize * 0.25);
		var mouseoverDropDownButton = point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2);
	
		if (i >= 2) {
			if (point_in_rectangle(mouse_x, mouse_y, colRectX1, colRectY1, colRectX2, colRectY1 + headerHeight)) {
				if (mouse_check_button_released(mb_right)) {
					with (obj_dropDown) {
						instance_destroy();
					}
					with(obj_panelPane) {
						chosenCol = i;
					}
					obj_control.tokenImportColToChange = ds_list_find_index(global.tokenImportColNameList, colName);
					var dropDownOptionList = ds_list_create();
					ds_list_add(dropDownOptionList, "Set as Transcription" , "Create Field");
					if (notUnitOrDiscoOrWordTag && !isTildaField) {
						ds_list_add(dropDownOptionList, "Add new Tag"); // only add the "Add new Tag" option if this is a token-level field
					}
					if (ds_list_size(dropDownOptionList) > 0) {
						var dropDownInst = instance_create_depth(colRectX1, colRectY1 + headerHeight, -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = global.optionListTypeTokenMarker;
					}
				}
			}
		}


	
		if(i == 0 or i ==1){
		}
		else {
			//user interaction for token selection
			if (mouseoverDropDownButton && !instance_exists(obj_dropDown)) {
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
							
							var dropDownInst = instance_create_depth(colRectX1, colRectY1 + headerHeight, -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = global.optionListTypeTokenSelection;
							//obj_control.ableToCreateDropDown = false;
							//obj_control.alarm[0] = 2;
						}
					}
				}
			}
		

	
	
			//user interaction for display view change
			if (point_in_circle(mouse_x, mouse_y, wordViewButtonX, wordViewButtonY, wordViewButtonSize) && !instance_exists(obj_dropDown)) {
				
				scr_createTooltip(wordViewButtonX, wordViewButtonY + wordViewButtonSize, "Display token", obj_tooltip.arrowFaceUp);
				draw_set_color(global.colorThemeSelected1);
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

			draw_set_color(global.colorThemeBG);
			draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize, true);
			draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
		}

		if (obj_control.wordView == i) {
			draw_set_color(global.colorThemeBG);
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
	draw_line(x - clipX, y + headerHeight - clipY, x + windowWidth - clipX, y + headerHeight - clipY);
	
	// draw short white line to separate from left nav
	draw_set_color(global.colorThemeBG);
	draw_line(x - clipX, y - clipY, x - clipX, y + headerHeight - clipY);

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
