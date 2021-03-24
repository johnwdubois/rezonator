/*
	Purpose: draws words to main screen, using wordIDs from the given wordIDList
*/

function scr_drawLineWordIDListLoop(currentWordIDList, currentLineY, drawLineLoop, unitID) {

	var currentWordIDListSize = 0;
	var previousWordID = -1;
	
	if (is_numeric(currentWordIDList) and currentWordIDList != undefined) {
		if(ds_exists(currentWordIDList, ds_type_list)){
			currentWordIDListSize = ds_list_size(currentWordIDList);
		}
	}
	else{
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
	var wordStateDead = obj_control.wordStateDead;
	var wordStateChunk = obj_control.wordStateChunk;
	var wordStateNormal = obj_control.wordStateNormal;
	var gridSpaceHorizontal = obj_control.gridSpaceHorizontal;
	var showPlaceChains = obj_chain.showPlaceChains;
	var stackShowActive = obj_control.stackShowActive;
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


	// get each wordID from wordIDList and draw it
	drawWordLoop = (obj_control.drawLineState == obj_control.lineState_ltr)? 0 : currentWordIDListSize-1;
	repeat (currentWordIDListSize) {

		var currentWordID = ds_list_find_value(currentWordIDList, drawWordLoop);
		var currentWordGridRow = currentWordID - 1;
		
		if (currentWordID == obj_control.rightClickWordID) {
			obj_control.rightClickDisplayRow = drawLineLoop;
		}
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayRow, currentWordID - 1, drawLineLoop);

		var currentWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordGridRow);
		var currentWordInChainsList = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colInChainList, currentWordGridRow);
		var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow);
		var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordGridRow);
		var currentWordInChainsListSize = 0;
		
		if(currentWordInChainsList != undefined){
			if(ds_exists(currentWordInChainsList, ds_type_list)){
				currentWordInChainsListSize = ds_list_size(currentWordInChainsList);
			}
		}

		
		
		for (var i = 0; i < currentWordInChainsListSize; i++) {
			if (ds_list_find_index(chainShowList, ds_list_find_value(currentWordInChainsList, i)) == -1) {
				ds_list_add(chainShowList, ds_list_find_value(currentWordInChainsList, i));
			}
		}
	
	
		if(currentWordState != wordStateNormal) {
			if(currentWordState == wordStateDead) {
				
				if(drawLineState = lineState_ltr){ drawWordLoop++; }
				else{drawWordLoop--;}
				
				continue;
			}
	
			// Check if the word is a ChunkWord
			if(currentWordState == wordStateChunk) {
		
				scr_drawChunk(currentWordID, currentLineY, fontScale, unitID);
				
				// set displayWordSeq for chunk
				ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayWordSeq, currentWordID - 1, drawWordLoop);
			
				if(drawLineState = lineState_ltr){ drawWordLoop++; }
				else{drawWordLoop--;}
				continue;
			}
		}
	
	
	
	
	
	
		// get void for word
		var currentWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow);

		var previousWordDisplayCol = 0;
		if (previousWordID >= 0) previousWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, previousWordID - 1);
		
		var currentWordVoid = currentWordDisplayCol - previousWordDisplayCol;
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colVoid, currentWordGridRow, currentWordVoid);
		
		if (currentWordVoid < 1 && previousWordID >= 0) {
			currentWordDisplayCol++;
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol);
			
			// if we are pushing a word in a chain, realign that chain
			if (currentWordInChainsListSize > 0) {
				for (var i = 0; i < currentWordInChainsListSize; i++) {
					var currentChain = ds_list_find_value(currentWordInChainsList, i);
					scr_alignChain2ElectricBoogaloo(currentChain);
				}
			}
		}
		
		// if this word is not in a chain, but has a void greater than 1, bring it back!!
		if (currentWordInChainsListSize < 1) {
			if (currentWordVoid > 1) {
				currentWordDisplayCol--;
				ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol);
			}
		}
		
		
		
		
		
		
		
		
	
		// if showing developer variables, draw rectangle to visualize voids
		/*
		if ((showDevVars and currentWordVoid > 0)) {
			scr_drawVoids(drawWordLoop, previousWordDisplayCol, gridSpaceHorizontal, wordLeftMargin, currentLineY, currentWordVoid, currentWordDisplayCol);
		}
		*/









		// horizontally move this word to its desired x-pixel value
		var currentWordDestX = 0;
		if (justify == justifyLeft) {
			if (shape == shapeText) {
				currentWordDestX = shapeTextX;
			}
			else {
				currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
			}
		}
		else if (justify == justifyCenter) {
			if (shape == shapeText) {
				currentWordDestX = (camWidth / 2) - (unitWidth / 2) + shapeTextX;
			}
			else {
				currentWordDestX = (camWidth / 2) - (ceil((currentWordIDListSize / 2)) * gridSpaceHorizontal) + (currentWordDisplayCol * gridSpaceHorizontal);
			}
		}
		else if (justify == justifyRight) {
			if (shape == shapeText) {
				currentWordDestX = camWidth - global.toolPaneWidth -global.scrollBarWidth - unitWidth + shapeTextX;
			}
			else {
				currentWordDestX = camWidth - (currentWordIDListSize * gridSpaceHorizontal) + (currentWordDisplayCol * gridSpaceHorizontal);
			}
		}
	
		var currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow);
		if (is_string(currentWordX)) {
			currentWordX = 0;
		}
		leftScreenBound = min(currentWordX, leftScreenBound);
		
		if (currentWordX < currentWordDestX) {
			currentWordX += abs(currentWordX - currentWordDestX) / 4;
		}
		else if (currentWordX > currentWordDestX) {
			currentWordX -= abs(currentWordX - currentWordDestX) / 4;
		}
		
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow, currentWordX);
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayWordSeq, currentWordGridRow, drawWordLoop);
		
		// get the string of this word to draw to the main screen
		var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow);
		var currentWordStringType = string(currentWordString);
		scr_adaptFont(currentWordStringType,"M");
		var currentWordStringWidth = string_width(currentWordStringType);
		//var currentWordStringHeight = string_height(currentWordStringType);
	
		
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
	
	
		// figure out whether or not to draw fill/border for this word
		/*var drawFillRect = ds_grid_get(wordDrawGrid, wordDrawGrid_colFillRect, currentWordGridRow);
		//var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow);
		var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordGridRow);
		var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordGridRow);*/
		if(stackShowActive) {
			var drawGoldStandard = (currentWordState == obj_control.wordStateGold);
			var drawIncorrect = (currentWordState == obj_control.wordStateRed);
			if (drawGoldStandard) {
				draw_set_color(c_green);
				draw_set_alpha(0.4);
				draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
				draw_set_alpha(1);
			}
	
			if (drawIncorrect) {
				draw_set_color(c_red);
				draw_set_alpha(0.4);
				draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
				draw_set_alpha(1);
			}
		}
	
		if (wordRectX2 > speakerRectX2) {

			//scr_drawWordBorder(drawBorder, drawFillRect, drawFocused, effectColor, wordRectX1, wordRectY1, wordRectX2, wordRectY2, borderRounded, fontScale);
			scr_drawWordBorder(drawBorder, currentWordGridRow, wordRectX1, wordRectY1, wordRectX2, wordRectY2, borderRounded, fontScale);
			// Until I can get a check that sees if the mouseRect is in the line, this can't happen
			if (!obj_toolPane.mouseOverToolPane && !obj_control.mouseOverUI && (hoverWordID == -1 || hoverWordID == currentWordID) && ((mouse_y > wordRectY1 && mouse_y < wordRectY2) || (mouseRectMade || obj_control.boxRectMade))) {
				scr_mouseOnWord(currentWordID, wordRectX1, wordRectY1, wordRectX2, wordRectY2, unitID, drawWordLoop, currentWordIDListSize, panelPaneResizeHeld, currentWordState, drawLineLoop);
			}
	
			scr_drawWord(currentWordGridRow, currentWordID, unitID, currentWordX, currentLineY, currentWordString, hitGridHeight);
		}
	
		previousWordID = currentWordID;
		previousWordDisplayString = currentWordString;
	
		shapeTextX += currentWordStringWidth + shapeTextSpace;
		if(drawLineState = lineState_ltr){ drawWordLoop++; }
		else{drawWordLoop--;}
	}



	// set total void values for this line, now that we have gone through every word in the line
	//ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidMax, drawLineLoop, voidMax);
	//ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidSum, drawLineLoop, voidSum);


}
