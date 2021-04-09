/*
	Purpose: draws words to main screen, using wordIDs from the given wordIDList
*/

function scr_drawLineWordIDListLoop(currentWordIDList, currentLineY, drawLineLoop, unitID) {
	

	var currentWordIDListSize = 0;
	var previousWordID = -1;
	
	if (is_numeric(currentWordIDList) and currentWordIDList != undefined) {
		if (ds_exists(currentWordIDList, ds_type_list)) {
			currentWordIDListSize = ds_list_size(currentWordIDList);
		}
	}
	else {
		exit;
	}

	
	var shapeTextX = wordLeftMargin;
	var shapeTextSpace = 12;
	var previousWordDisplayString = "0";
	var strHeightRegular = string_height("0");
	var strHeightScaled = string_height("0");
	var fontScale = strHeightScaled / strHeightRegular;
	var panelPaneResizeHeld = false;

	with(obj_panelPane) {
		if(windowResizeYHolding) {
			panelPaneResizeHeld = true;
		}
	}

	var chainShowList = obj_chain.chainShowList;
	var chunkShowList = obj_chain.chunkShowList;
	var wordStateDead = obj_control.wordStateDead;
	var wordStateChunk = obj_control.wordStateChunk;
	var wordStateNormal = obj_control.wordStateNormal;
	var gridSpaceHorizontal = obj_control.gridSpaceHorizontal;
	var showPlaceChains = obj_chain.showPlaceChains;
	var showDevVars = obj_control.showDevVars;
	var leftScreenBound = obj_control.leftScreenBound;
	var currentTool = obj_toolPane.currentTool;
	var toolRezBrush = obj_toolPane.toolRezBrush;
	var toolTrackBrush = obj_toolPane.toolTrackBrush;
	var mouseRectWithinLine = obj_control.mouseRectWithinLine;
	var mouseRectBeginBetweenWords = obj_control.mouseRectBeginBetweenWords;
	var colorThemeBG = global.colorThemeBG;
	var hitGridHeight = ds_grid_height(obj_control.hitGrid);
	var camWidth = camera_get_view_width(camera_get_active());


	// if we are justifying right with shapeText, we need to calculate the entire unit width
	var unitWidth = 0;
	var drawWordLoop = 0;
	if (shape == shapeText) {
		if (justify == justifyCenter || justify == justifyRight) {
			shapeTextX = 0;
			repeat (currentWordIDListSize) {
				var currentWordID = ds_list_find_value(currentWordIDList, drawWordLoop);
				unitWidth += string_width(string(ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID - 1))) + shapeTextSpace;
				drawWordLoop++;
			}
		}
	}
	
	var rtlMulti = (obj_control.drawLineState == obj_control.lineState_ltr) ? 1 : -1;


	// get each wordID from wordIDList and draw it
	drawWordLoop = (obj_control.drawLineState == obj_control.lineState_ltr)? 0 : currentWordIDListSize-1;
	repeat (currentWordIDListSize) {

		var currentWordID = currentWordIDList[| drawWordLoop];
		var currentWordGridRow = currentWordID - 1;
		
		if (currentWordID == obj_control.rightClickWordID) {
			obj_control.rightClickDisplayRow = drawLineLoop;
		}
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayRow, currentWordID - 1, drawLineLoop);

		var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow);
		var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordGridRow);
		var currentWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordGridRow);
		var currentWordInChainsList = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colInChainList, currentWordGridRow);
		var currentWordInBoxList = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colInBoxList, currentWordGridRow);
		
		if (currentWordState == wordStateDead) {
			scr_deleteFromList(currentWordIDList, currentWordID);
			continue;
		}

		scr_updateChainShowList(currentWordInChainsList, chainShowList, currentWordInBoxList, chunkShowList);	

		scr_wordCalculateVoid(currentWordID);
		
		var currentWordX = scr_setTokenX(currentWordID, shapeTextX, currentWordIDListSize, unitWidth, drawWordLoop, camWidth);
		
		

		
		// get the string of this word to draw to the main screen
		var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow);
		var currentWordStringType = string(currentWordString);
		scr_adaptFont(currentWordStringType,"M");
		var currentWordStringWidth = string_width(currentWordStringType);
	
		
		var wordRectBuffer = 3;
		var wordRectX1 = currentWordX - wordRectBuffer;
		var wordRectY1 = currentLineY - (strHeightScaled / 2) - wordRectBuffer;
		var wordRectX2 = wordRectX1 + currentWordStringWidth + (wordRectBuffer * 2);
		var wordRectY2 = wordRectY1 + strHeightScaled + (wordRectBuffer * 2);
	
	
		var inMouseHoldRect = 0;
		if (mouse_check_button(mb_left) and (currentTool == toolRezBrush or currentTool == toolTrackBrush)) {
			if(mouseRectWithinLine) {
				inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
				obj_control.mouseoverNeutralSpace = false;	
			}
			else if (mouseRectBeginBetweenWords == -1 and not mouseRectWithinLine) {//not (currentTool == toolTrackBrush and not searchGridActive)) {
				inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + gridSpaceHorizontal - 20, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
				obj_control.mouseoverNeutralSpace = false;	
			}
			else {
				inMouseHoldRect = 0;
			}
		 
			if (inMouseHoldRect) {
				if (not drawBorder) {
					ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, 2);
				}
			}
			else {
				if (drawBorder == 2) {
					ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, false);
				}
			}
		}
		else {
			if (drawBorder == 2) {
				ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, false);
			}
		}
	
	

	
		draw_set_alpha(1);
		draw_set_color(colorThemeBG);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
	
	
		// Draw Place chains when needed
		if(showPlaceChains) {
			// Place Chains Prototype
			var wordHasLetters = string_length(string_letters(currentWordStringType)) > 0;
			if(drawWordLoop != currentWordIDListSize - 1 && wordHasLetters) {
				scr_drawPlaceChains(wordRectX1, wordRectY1, wordRectX2, wordRectY2, drawWordLoop, currentWordIDListSize, currentWordGridRow,currentWordDisplayCol);
			}
		}
	
		if (wordRectX2 > speakerRectX2) {
			scr_drawWordBorder(drawBorder, currentWordGridRow, wordRectX1, wordRectY1, wordRectX2, wordRectY2, borderRounded, fontScale);
			// Until I can get a check that sees if the mouseRect is in the line, this can't happen
			if (!obj_toolPane.mouseOverToolPane && !obj_control.mouseOverUI && (hoverWordID == -1 || hoverWordID == currentWordID) && ((mouse_y > wordRectY1 && mouse_y < wordRectY2) || (mouseRectMade || obj_control.boxRectMade))) {
				scr_mouseOnWord(currentWordID, wordRectX1, wordRectY1, wordRectX2, wordRectY2, unitID, drawWordLoop, currentWordIDListSize, panelPaneResizeHeld, currentWordState, drawLineLoop);
			}
	
			scr_drawWord(currentWordGridRow, currentWordID, unitID, currentWordX, currentLineY, currentWordString, hitGridHeight);
		}
		
		
		// check to see if this word should be added to inRectWordIDList (if it is in mouse rect)
		var inMouseRectX2 = (shape == shapeBlock) ? wordRectX1 + obj_control.gridSpaceHorizontal - 20 : wordRectX2;
		var inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, inMouseRectX2, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		if (mouse_check_button(mb_left)) {
			if (inMouseHoldRect && !mouseoverPanelPane) {
				with (obj_control) {
					if (ds_list_find_index(inRectWordIDList, currentWordID) < 0) {
						ds_list_add(inRectWordIDList, currentWordID);
					}
				}
			}
		}

	
		previousWordID = currentWordID;
		previousWordDisplayString = currentWordString;
	
		shapeTextX += currentWordStringWidth + shapeTextSpace;
		if(drawLineState = lineState_ltr){ drawWordLoop++; }
		else{drawWordLoop--;}
	}


}
