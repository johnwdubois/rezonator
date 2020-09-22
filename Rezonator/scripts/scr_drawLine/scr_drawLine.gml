function scr_drawLine() {
	/*
		scr_drawLine();
	
		Last Updated: 2018-07-12
	
		Called from: obj_control
	
		Purpose: draws words and lines from the lineGrid that are within the drawRange
	
		Mechanism: loop through the lineGrid (only loop through necessary lines) and get wordIDList from each line, then draw out those words
	
		Author: Terry DuBois
	*/


	if (gridView || ds_grid_height(dynamicWordGrid) < 1) {
		exit;
	}

	scr_setSpeakerLabelColWidth();

	ds_grid_set_region(wordDrawGrid, wordDrawGrid_colVisible, 0, wordDrawGrid_colVisible, ds_grid_height(wordDrawGrid), false);

	// set draw variables for column text
	draw_set_font(global.fontMain);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);

	var camViewWidth = camera_get_view_width(camera_get_active());
	var camViewHeight = camera_get_view_height(camera_get_active());

	drawLineYOffset = 0;
	if (filterGridActive) {
		drawLineYOffset = (camViewHeight / 2) - 200;
	}

	var menuBarHeight = 0;
	if (instance_exists(obj_menuBar)) {
		menuBarHeight = obj_menuBar.menuHeight;
	}
	var chainListHeight = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListHeight = windowHeight;
		}
	}


	wordTopMargin = menuBarHeight + chainListHeight;
	if (global.wheresElmo || global.rezzles) {
		wordTopMargin += 80;
	}

	var activeLineGridHeight = ds_grid_height(currentActiveLineGrid);

	scr_setDrawRange();
	ds_grid_set_grid_region(currentActiveLineGrid, currentActiveLineGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, activeLineGridHeight, lineGrid_colPixelY, 0);
	ds_grid_add_region(currentActiveLineGrid, lineGrid_colPixelY, 0, lineGrid_colPixelY, activeLineGridHeight, (scrollPlusY + wordTopMargin + 10));




	// draw out of bounds rectangles on top & bottom of discourse
	if (drawRangeStart == 0 and activeLineGridHeight > 0) {
		//var firstLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, 0);
		draw_set_color(global.colorThemeOutOfBounds);
		//draw_rectangle(0, 0, camera_get_view_width(camera_get_active()), firstLinePixelY - (obj_control.gridSpaceVertical / 2), false);
		var oobTopRectY2 = wordTopMargin;
		if (activeLineGridHeight > 0) {
			var lowestY = ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, 0) - (gridSpaceVertical / 2) - 10;
			oobTopRectY2 = clamp(wordTopMargin, 0, lowestY);
		}
		draw_rectangle(0, 0, camViewWidth, oobTopRectY2, false);
	}
	if (drawRangeEnd == activeLineGridHeight - 1 and activeLineGridHeight > 0) {
		var lastLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, activeLineGridHeight - 1);
		draw_set_color(global.colorThemeOutOfBounds);
		draw_rectangle(0, lastLinePixelY + (obj_control.gridSpaceVertical / 2), camViewWidth, camViewHeight, false);
	}




	// get speakerLabelMargin
	if (!obj_control.showParticipantName) {
		ds_list_set(obj_control.speakerLabelColXList, 3, ds_list_find_value(obj_control.speakerLabelColXList, 2));
	}
	speakerLabelMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1);
	if (speakerLabelColXHolding > -1) {// || !obj_control.showParticipantName) {
		wordLeftMargin = speakerLabelMargin + 20;
	}


	if (speakerLabelColXHolding > -1) {
		mouseoverPanelPane = true;
	}

	var stackChainGridHeight = ds_grid_height(obj_chain.stackChainGrid);
	var lineGridHeight = ds_grid_height(obj_control.lineGrid);
	var unitInStackGridHeight = ds_grid_height(obj_chain.unitInStackGrid);
	var unitGridHeight = ds_grid_height(obj_control.unitGrid);

	if (not mouseoverPanelPane and not global.wheresElmo and not instance_exists(obj_dropDown) and not instance_exists(obj_dialogueBox)) {
		scr_mouseToolCheck(stackChainGridHeight);
	}



	// draw out of bounds rectangle on left
	if (obj_control.wordLeftMargin > obj_control.speakerLabelMargin) {
		scr_drawLeftBounds(camViewHeight);
	}

	draw_set_color(global.colorThemeText);

	obj_control.leftScreenBound = camViewWidth;

	hoverWordID = -1;
	hoverChunkID = -1;
	hoverChunkIDRow = -1;


	ds_list_clear(obj_chain.chainShowList);

	var previousWordDisplayCol = -1;

	// for every row in lineGrid from drawRangeStart to drawRangeEnd, draw the words in that line
	for (var drawLineLoop = drawRangeStart; drawLineLoop <= drawRangeEnd; drawLineLoop++) {
		if (drawLineLoop < 0 or drawLineLoop >= activeLineGridHeight) {
			continue;
		}
	
	
		var unitID = ds_grid_get(currentActiveLineGrid, lineGrid_colUnitID, drawLineLoop);
	
		if (unitID < 0) {
			continue;
		}
	
		var currentWordIDList = ds_grid_get(currentActiveLineGrid, lineGrid_colWordIDList, drawLineLoop);
		var currentDiscoID = ds_grid_get(currentActiveLineGrid, lineGrid_colDiscoID, drawLineLoop);
		var currentLineNumberLabel = ds_grid_get(currentActiveLineGrid, lineGrid_colLineNumberLabel, drawLineLoop);
		var currentWordIDListSize = ds_list_size(currentWordIDList);
	
		// get & set the correct pixel-Y value for each line
		var currentLineY = ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawLineLoop);
		// Adapt to dynamic line height
		//currentLineY *= (obj_control.gridSpaceVertical/33.4);
	
	
		// set speaker label stuff up
		speakerRectX1 = 0;
		speakerRectY1 = currentLineY - (gridSpaceVertical / 2);
		speakerRectX2 = speakerLabelMargin;
		speakerRectY2 = speakerRectY1 + gridSpaceVertical;
	
	
	
		if(obj_toolPane.currentMode != obj_toolPane.modeRead and currentWordIDListSize > 0) {
		
			var mouseRectExists = (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5);
			if(mouseRectExists) {
				obj_control.mouseoverNeutralSpace = false;		
			}
			if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouseRectMade and not mouseoverPanelPane and !instance_exists(obj_stackShow) and !instance_exists(obj_dialogueBox)) {
				//show_message("here");
				inMouseHoldRect = rectangle_in_rectangle(speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
				if (inMouseHoldRect) {
					with (obj_control) {
						if (ds_list_find_index(inRectUnitIDList, unitID) == -1) {
							ds_list_add(inRectUnitIDList, unitID);
						}
					}
				}
			}
			else if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and not mouseoverPanelPane and (window_get_cursor() != cr_size_we) and point_in_rectangle(mouse_x, mouse_y, speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2)) {
				obj_control.mouseoverNeutralSpace = false;
				if ((device_mouse_check_button_released(0, mb_left) and !obj_chain.inRezPlay) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow) and not obj_control.speakerLabelHoldingDelay) {
					//show_message("here");
					var currentWordID = ds_list_find_value(currentWordIDList, 0);
					with (obj_chain) {
						scr_wordClicked(currentWordID, unitID);
					}
				}
			}
		}
		else if(currentWordIDListSize > 0 and obj_toolPane.currentMode == obj_toolPane.modeRead) {
			var mouseRectExists = (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5);
			if(mouseRectExists) {
				obj_control.mouseoverNeutralSpace = false;		
			}
			if((not mouseoverPanelPane and (window_get_cursor() != cr_size_we) and point_in_rectangle(mouse_x, mouse_y, speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2))) {
				obj_control.mouseoverNeutralSpace = false;
				if ((device_mouse_check_button_released(0, mb_left) and !obj_chain.inRezPlay) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow) and not obj_control.speakerLabelHoldingDelay) {
					//show_message("here");
					ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, lineGridHeight, 0);
					ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, drawLineLoop, 1);
					with (obj_panelPane) {
						functionChainList_lineGridRowFocused = drawLineLoop;
						functionChainContents_BGColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, unitID - 1);
						functionChainList_currentTab = functionChainList_tabLine;
						// Y value not in a grid for read tab, have to store somewhere
						//var linePixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
						//obj_panelPane.scrollPlusYDest = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
					}
					if(!global.readHintHide) {
						//var popUpInst = instance_create_layer(x, y, "InstancesPopUp", obj_readModePopUp);
					}
				}
			}
		}

	
	
		var currentLineInStack = -1;
		if (mouse_y > speakerRectY1 and mouse_y < speakerRectY2 and not obj_control.rectNotInPanelPane) {
			obj_control.lineContainsMouseYPos = speakerRectY1;	
		}
	
		if (unitInStackGridHeight == unitGridHeight) {
			// want this to be quicker, but it works for now
			//show_message(unitID);
			var currentStackType = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, unitID - 1);
			if (obj_control.activeStackType == currentStackType) {
				currentLineInStack = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1);
			}
			else {
				currentLineInStack = -1;
			}
		}

	
		// draw stack rectangle if this line is in a stack
	
		if (currentLineInStack > -1) {
			//scr_drawStackRect();
		
			if (obj_chain.toggleDrawStack) {
				var currentStackChainID = currentLineInStack;
				var rowInStackChainGrid = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, stackChainGridHeight, currentStackChainID);
			
				//var showStack = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colShow, rowInStackChainGrid);
				//if (showStack) {
					var stackColor = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colColor, rowInStackChainGrid);
			
					if (typeof(stackColor) == "number") {
		
						draw_set_color(stackColor);
						draw_set_alpha(0.2);
			
						var stackRectWidth = (camViewWidth - speakerRectX2);
						var stackRectX1 = speakerRectX2;
						var stackRectY1 = speakerRectY1;
						var stackRectX2 = camViewWidth;
						var stackRectY2 = speakerRectY2;
				
						draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
					}
				//}
			}
		}
		else {
			if (ds_list_size(inRectUnitIDList) > 0) {
				if (ds_list_find_index(inRectUnitIDList, unitID) > -1) {
					if (stackChainGridHeight > 0) {
						var focusedStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, stackChainGridHeight, obj_chain.chainStateFocus);
						if (focusedStackRow >= 0 and focusedStackRow < stackChainGridHeight) {
							var stackColor = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colColor, focusedStackRow);
							var stackRectWidth = (camViewWidth - speakerRectX2);
							var stackRectX1 = speakerRectX2 + (stackRectWidth);
							var stackRectY1 = speakerRectY1;
							var stackRectX2 = camViewWidth;
							var stackRectY2 = speakerRectY2;
						
							draw_set_color(stackColor);
							draw_set_alpha(0.2);
						
							draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
						}
					}
				}
			}
		}
	
	
	
		// Set the opacity of the Highlight
		if(currentActiveLineGrid == obj_control.searchGrid) {
			highlightedSearchRowAlpha = 0.3;
		}
		else {
			highlightedSearchRowAlpha -= 0.00005;
		}
		highlightedSearchRowAlpha = max(0, highlightedSearchRowAlpha);
	
		// Highlight last clicked word in Search view
		if(unitID == highlightedSearchRow) {
			draw_set_color(global.colorThemeHighlight);
			draw_set_alpha(highlightedSearchRowAlpha);
			
			var highlightRectX1 = speakerRectX2;
			var highlightRectY1 = speakerRectY1;
			var highlightRectX2 = camViewWidth;
			var highlightRectY2 = speakerRectY2;
		
			draw_rectangle(highlightRectX1, highlightRectY1, highlightRectX2, highlightRectY2, false);
		}
	
		//Draw quickstack highlights here
		if (!obj_chain.inRezPlay) {
			if (mouse_check_button(mb_left) and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and !instance_exists(obj_dialogueBox) and !instance_exists(obj_stackShow)) {
		
				var inMouseRect = rectangle_in_rectangle(0, speakerRectY1, camViewWidth, speakerRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
				if (inMouseRect and speakerLabelColXHolding == -1) {
					draw_set_color(c_ltblue);
					draw_set_alpha(0.3);
			
					var quickStackRectX1 = speakerRectX2;
					var quickStackRectY1 = speakerRectY1;
					var quickStackRectX2 = camViewWidth;
					var quickStackRectY2 = speakerRectY2;
		
					draw_rectangle(quickStackRectX1, quickStackRectY1, quickStackRectX2, quickStackRectY2, false);
				}
			}
		}
		
		//var previousWordDisplayCol = -1;
	
		// draw hits if in search view, otherwise draw words for this line
		if (searchGridActive) {
			scr_drawLineHitIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
		}
		else {
			scr_drawLineWordIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
		}
	
	
		var discoColor = ds_grid_get(unitGrid, unitGrid_colDiscoColor, unitID - 1);
		if (discoColor == -1 or discoColor == 0) {
			discoColor = c_ltblue;
		}
	
		var participantColor = ds_grid_get(unitGrid, unitGrid_colParticipantColor, unitID - 1);
		var participantName = ds_grid_get(unitGrid, unitGrid_colParticipantName, unitID - 1);
		draw_set_alpha(1);
		draw_set_halign(fa_left);
		draw_set_color(is_undefined(participantColor) ? c_gray : participantColor);
		var speakerLabelTextBuffer = 3;
	
		scr_drawSpeakerLabel(unitID, currentDiscoID, currentLineNumberLabel, participantName, participantColor, speakerLabelTextBuffer, discoColor);
	
	}

	// show draw range of lines if development variables are on
	if (showDevVars) {
		draw_set_alpha(1);
		draw_set_font(fnt_debug);
		draw_set_halign(fa_right);
		draw_text(camViewWidth - 300, 250, "drawRange: " + string(drawRangeStart) + " ... " + string(drawRangeEnd));
		draw_text(camViewWidth - 300, 265, "camY range: " + string(camera_get_view_y(camera_get_active()) + camViewHeight));
	
		draw_text(mouse_x, mouse_y, "(" + string(mouse_x) + ", " + string(mouse_y) + ")");
	}


}
