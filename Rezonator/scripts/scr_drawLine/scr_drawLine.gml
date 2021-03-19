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
	var tabsHeight = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListHeight = windowHeight;
		}
		else if (currentFunction == functionTabs) {
			tabsHeight = windowHeight;
		}
	}
	if(obj_panelPane.showNav){
		wordTopMargin = menuBarHeight + chainListHeight + tabsHeight;
	}
	else{
		wordTopMargin = menuBarHeight;
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
	if (!obj_control.showSpeakerName) {
		ds_list_set(obj_control.speakerLabelColXList, 3, ds_list_find_value(obj_control.speakerLabelColXList, 2));
	}
	speakerLabelMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1);
	if (speakerLabelColXHolding > -1) {// || !obj_control.showSpeakerName) {
		wordLeftMargin = speakerLabelMargin + 20;
	}


	if (speakerLabelColXHolding > -1) {
		mouseoverPanelPane = true;
	}

	var lineGridHeight = ds_grid_height(obj_control.lineGrid);
	var unitInStackGridHeight = ds_grid_height(obj_chain.unitInStackGrid);
	var unitGridHeight = ds_grid_height(obj_control.unitGrid);

	if (not mouseoverPanelPane and not global.wheresElmo and not instance_exists(obj_dropDown) and not instance_exists(obj_dialogueBox)) {
		scr_mouseToolCheck();
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
		var currentWordIDListSize = 0;
		
		if(is_numeric(currentWordIDList) and currentWordIDList != undefined){
			if(ds_exists(currentWordIDList, ds_type_list)){
				currentWordIDListSize = ds_list_size(currentWordIDList);
			}
		}

	
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
				if (device_mouse_check_button_released(0, mb_left) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow) and not obj_control.speakerLabelHoldingDelay) {
					var currentWordID = ds_list_find_value(currentWordIDList, 0);
					if (obj_control.ctrlHold) {
						
						// make a temporary "fake" inChainsList that will contain the chain that this stack is in (or no chain if there is none)
						var fakeInChainsList = ds_list_create();
						var chainToAdd = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1);
						if (ds_map_exists(global.nodeMap, chainToAdd)) {
							ds_list_add(fakeInChainsList, chainToAdd);
						}
	
						// combine the chains
						scr_combineChainsDrawLine(fakeInChainsList);
						ds_list_destroy(fakeInChainsList);
						
					}
					else {
						var focusedchainIDSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
				
						if(is_numeric(focusedchainIDSubMap)){
							if(ds_exists(focusedchainIDSubMap, ds_type_map)){
								var prevChainType = ds_map_find_value(focusedchainIDSubMap, "type");
								if( prevChainType == "rezChain" or prevChainType == "trackChain" ){
									scr_chainDeselect();
								}
							}
						}
						
						
						// if we are in the search screen, the currentWordID will actually be a hitID,
						// so we need to convert it back to a wordID before trying to make a stack
						if (obj_control.currentActiveLineGrid == obj_control.searchGrid) {
							currentWordID = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colWordID, currentWordID - 1);
						}
			
						with (obj_chain) {
							scr_wordClicked(currentWordID, unitID);
						}
					}
				}
			}
		}
		else if (currentWordIDListSize > 0 and obj_toolPane.currentMode == obj_toolPane.modeRead) {
			var mouseRectExists = (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5);
			if(mouseRectExists) {
				obj_control.mouseoverNeutralSpace = false;		
			}
			 
			if(obj_control.currentActiveLineGrid == obj_control.searchGrid) {
				var mouseOverLine = point_in_rectangle(mouse_x, mouse_y, speakerRectX1, speakerRectY1, camera_get_view_width(camera_get_active()), speakerRectY2);
				if((not mouseoverPanelPane and (window_get_cursor() != cr_size_we) and mouseOverLine)) {
				obj_control.mouseoverNeutralSpace = false;
				if (device_mouse_check_button_released(0, mb_left) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow) and not obj_control.speakerLabelHoldingDelay) {
					
					ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
					ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, drawLineLoop, 1);
					//var currentLineInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, lineGridHeight, unitID);
					with (obj_panelPane) {
						functionChainList_lineGridRowFocused = drawLineLoop;
						functionChainContents_BGColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, unitID - 1);
						functionChainList_currentTab = functionChainList_tabLine;
						// Y value not in a grid for read tab, have to store somewhere
						for (var i = 0; i < instance_number(obj_panelPane); i++) {
							var currentPane = instance_find(obj_panelPane, i);
							if (currentPane.currentFunction == obj_panelPane.functionChainList) {
								var strHeight = string_height("0") * 1.5;
								scrollPlusYDest = -((y + currentPane.functionTabs_tabHeight + (strHeight * (drawLineLoop - 2)))) + 10;
							}
						}
						
					}
				}
			}
			}
			else {
				var mouseOverLine = point_in_rectangle(mouse_x, mouse_y, speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2);
			
				if((not mouseoverPanelPane and (window_get_cursor() != cr_size_we) and mouseOverLine)) {
					obj_control.mouseoverNeutralSpace = false;
					if (device_mouse_check_button_released(0, mb_left) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow) and not obj_control.speakerLabelHoldingDelay) {
						//show_message("here");
						ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, lineGridHeight, 0);
						ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, drawLineLoop, 1);
						with (obj_panelPane) {
							functionChainList_lineGridRowFocused = drawLineLoop;
							functionChainContents_BGColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, unitID - 1);
							functionChainList_currentTab = functionChainList_tabLine;
							// Y value not in a grid for read tab, have to store somewhere
							for (var i = 0; i < instance_number(obj_panelPane); i++) {
								var currentPane = instance_find(obj_panelPane, i);
								if (currentPane.currentFunction == obj_panelPane.functionChainList && currentPane.functionChainList_currentTab != currentPane.functionChainList_tabShow) {
									//show_message(i);
									var strHeight = string_height("0") * 1.5;
									//we can affect the scrollPlusY, now we need the correct placement
									scrollPlusYDest = -((y + currentPane.functionTabs_tabHeight + (strHeight * (drawLineLoop - 2)))) + 10; //currentPane.scrollPlusY - 
								}
							}
						
						}
					}
				}
			}
			
		}

	
	
		var currentLineInStack = "";
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
				currentLineInStack = "";
			}
		}
		
		
		var drawStackRect = false;
		if (obj_chain.toggleDrawStack) {
			if (ds_map_exists(global.nodeMap, currentLineInStack)) {
				
				var stackChainSubMap = ds_map_find_value(global.nodeMap, currentLineInStack);
				if (is_numeric(stackChainSubMap)) {
					if (ds_exists(stackChainSubMap, ds_type_map)) {
						var stackColor = ds_map_find_value(stackChainSubMap, "chainColor");
						var stackVisible = ds_map_find_value(stackChainSubMap, "visible");
						draw_set_color(stackColor);
						draw_set_alpha(0.2);
						if (stackVisible) drawStackRect = true;
					}
				}
			}
			else {
				if (ds_list_size(inRectUnitIDList) > 0) {
					if (ds_list_find_index(inRectUnitIDList, unitID) > -1) {
						
						var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
						if (is_numeric(focusedChainSubMap)) {
							if (ds_exists(focusedChainSubMap, ds_type_map)) {
								var stackColor = ds_map_find_value(focusedChainSubMap, "chainColor");
								var stackVisible = ds_map_find_value(stackChainSubMap, "visible");
								draw_set_color(stackColor);
								draw_set_alpha(0.2);
								if (stackVisible) drawStackRect = true;
							}
						}
						
					}
				}
			}
		}
		
		if (drawStackRect) {
			var stackRectWidth = (camViewWidth - speakerRectX2);
			var stackRectX1 = speakerRectX2;
			var stackRectY1 = speakerRectY1;
			var stackRectX2 = camViewWidth;
			var stackRectY2 = speakerRectY2;
						
			draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
		}

		
	
		//Draw quickstack highlights here
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

	
		// draw hits if in search view, otherwise draw words for this line
		if (searchGridActive) {
			scr_drawLineHitIDListLoop(currentWordIDList, currentLineY, drawLineLoop, unitID);
		}
		else {
			scr_drawLineWordIDListLoop(currentWordIDList, currentLineY, drawLineLoop, unitID);
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


}
