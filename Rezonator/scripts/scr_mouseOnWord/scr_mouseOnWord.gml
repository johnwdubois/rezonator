function scr_mouseOnWord(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {
	// Check for the mouse pointer on top of the current word

	var currentWordID = argument0;
	var wordRectX1 = argument1;
	var wordRectY1 = argument2;
	var wordRectX2 = argument3;
	var wordRectY2 = argument4;
	var unitID = argument5;
	var drawWordLoop = argument6;
	var currentWordIDListSize = argument7;
	var panelPaneResizeHeld = argument8;
	var currentWordState = argument9;
	var drawLineLoop = argument10;
	//var inMouseHoldRect = argument9;

	//Prevent the mouse from clicking on words/lines while releasing from a drag
	var mouseRectExists = ((abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5) or (abs(obj_control.mouseHoldRectX1 - obj_control.mouseHoldRectX2) > 5));
	if(mouseRectExists) {
		obj_control.mouseoverNeutralSpace = false;		
	}
	//var hoverWordID = -1;	
	
	// figure out if the user has their mouse hovering over this word, and if so, are they clicking?
	var mouseover = false;
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2)) {
		obj_control.mouseoverNeutralSpace = false;	
		mouseover = true;
		hoverWordID = currentWordID;
		
		if(not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not obj_chain.inRezPlay
			and not obj_control.mouseoverPanelPane and (hoverWordID == currentWordID || hoverWordID == -1)){
		
			draw_set_color(global.colorThemeBorders);
			draw_set_alpha(1);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
			// Word clicked with a Chain tool selected
			if ((device_mouse_check_button_released(0, mb_left) and not mouseRectExists) and obj_control.touchReleaseCheck and !instance_exists(obj_stackShow) and obj_toolPane.currentMode != obj_toolPane.modeRead) {
				if(keyboard_check(vk_control)){
					scr_combineChains(currentWordID);
				}
				else {
					with (obj_chain) {
						scr_wordClicked(currentWordID, unitID);
					}
				}
				
			}
			// If in Read Mode, focus line in Nav window
			else if (obj_toolPane.currentMode == obj_toolPane.modeRead and ((device_mouse_check_button_released(0, mb_left) and not mouseRectExists) and obj_control.touchReleaseCheck and !instance_exists(obj_stackShow))) {
				
				if (instance_exists(obj_audioUI)) {
					if (obj_audioUI.visible and file_exists(obj_audioUI.audioFile) and obj_audioUI.audioSound != -1) {
						scr_audioJumpToUnit(unitID);
					}
				}
				//forgot why this was taken out
				/*ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
				ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, drawLineLoop, 1);
				with (obj_panelPane) {
					functionChainList_lineGridRowFocused = drawLineLoop;
					functionChainContents_BGColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, unitID - 1);
					functionChainList_currentTab = functionChainList_tabLine;
				}*/
				if(!global.readHintHide){
					var popUpInst = instance_create_layer(x, y, "InstancesPopUp", obj_readModePopUp);
					//obj_control.readModeHints++;
				}
			}
				
			if (device_mouse_check_button_released(0, mb_right) and !instance_exists(obj_dialogueBox)and !instance_exists(obj_stackShow)) {

				if(!instance_exists(obj_dialogueBox)){
				obj_control.rightClickWordID = obj_control.newWordHoverWordID;
				obj_control.rightClickUnitID = obj_control.newWordHoverUnitID;
				obj_control.rightClickWordSeq = obj_control.newWordHoverWordSeq;
				}

				obj_control.rightClickonWord = true;
				obj_control.wideDropDown = true;
				var dropDownOptionList = ds_list_create();
				if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
					obj_control.ableToCreateDropDown = false;
				}
				else if(scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource , obj_control.rightClickWordID, obj_chain.linkGrid_colDead, obj_chain.chainStateNormal) != -1){
					if(obj_control.searchGridActive){
						ds_list_add(dropDownOptionList, "Delete Link");
					}
					else{
						ds_list_add(dropDownOptionList, "Split Word", "New Word", "Delete New Word", "Delete Link");
					}
				}
				else{
					if(obj_control.searchGridActive){
						obj_control.ableToCreateDropDown = false;
					}
					else{
						ds_list_add(dropDownOptionList, "Split Word", "New Word", "Delete New Word");
					}
				}
				if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
					var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
					dropDownInst.optionList = dropDownOptionList;
					dropDownInst.optionListType = 8;
					
					obj_control.ableToCreateDropDown = false;
					obj_control.alarm[0] = 2;
				}

			}
				
		}
	}
	/*else if for Chunks???{
			
	}
	*/
	// Allows for adding to a stack w/in the speaker labels
	else if(obj_control.mouseoverSpeakerLabel and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and not obj_control.mouseoverPanelPane 
	and rectangle_in_rectangle(0, wordRectY1, room_width - global.scrollBarWidth, wordRectY1 + gridSpaceVertical, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2))) {
		if ((device_mouse_check_button_released(0, mb_left) and !obj_chain.inRezPlay) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow)) {
			with (obj_chain) {
				scr_wordClicked(currentWordID, unitID);
			}
		}
	}

	
	// If the mouse is dragged, record all the words that fit into the rectangle in order to quickStack them.
	var inMouseHoldRect = 0;	
	if ((obj_toolPane.currentTool == obj_toolPane.toolRezBrush) and mouseRectMade) {
		if(obj_control.mouseRectWithinLine) {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		}
		else {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal - 20, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		}
		if (inMouseHoldRect) {
			with (obj_control) {
				if (ds_list_find_index(inRectWordIDList, currentWordID) < 0) {
					ds_list_add(inRectWordIDList, currentWordID);
				}
			}
		}
	}
	else if ((obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) and mouseRectMade and not mouseoverPanelPane) {
		inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		if (inMouseHoldRect) {
			with (obj_control) {
				if (ds_list_find_index(inRectWordIDList, currentWordID) == -1) {
					// Add the word info to the rectangle lists
					//ds_list_add(inRectUnitIDList, unitID);
					ds_list_add(inRectWordIDList, currentWordID);
				}
			}
		}
	}
	
	
		
	var inBoxHoldRect = false;
	// Make sure the user has the box brush selected
	if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
			
		// Check if this word is within the Box brush rectangle
		with (obj_control) { 
			if(boxRectWithinLine) {
				if(shape = shapeBlock) {
					inBoxHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY1 + gridSpaceVertical, min(boxHoldRectX1, boxHoldRectX2), min(boxHoldRectY1, boxHoldRectY2), max(boxHoldRectX1, boxHoldRectX2), max(boxHoldRectY1, boxHoldRectY2));	
				}
				// If the text is left justified, we don't use the gridSpaceHorizontal
				else {
					inBoxHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY1, min(boxHoldRectX1, boxHoldRectX2), min(boxHoldRectY1, boxHoldRectY2), max(boxHoldRectX1, boxHoldRectX2), max(boxHoldRectY1, boxHoldRectY2));
				}
			}
		}
		// If the box has been made, capture the info of the contained words
		if(obj_control.boxRectMade and inBoxHoldRect > 0) {
			//show_message("here");
			// Make sure this word has not already been captured
			with (obj_control) {
				if (ds_list_find_index(inRectWordIDList, currentWordID) == -1) {
					// Add the word info to the rectangle lists
					ds_list_add(inRectUnitIDList, unitID);
					ds_list_add(inRectWordIDList, currentWordID);
				}
			}
		}
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and !instance_exists(obj_dialogueBox)) {
				
		// Set this to be the hovered wordID
		newWordHoverUnitID = unitID;
		newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
		newWordHoverWordID = currentWordID;
				
	}
	
	
	// If the user has the New-Word tool selected, create a new word right next to this word
	if (obj_toolPane.currentTool == obj_toolPane.toolNewWord or (instance_exists(obj_dropDown) and rightClickonWord) ) {
		if (newWordHoverUnitID == unitID and newWordHoverWordSeq == ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1) and newWordHoverWordID == currentWordID) {
			draw_set_color(c_ltblue);
			draw_line_width(wordRectX2, wordRectY1, wordRectX2, wordRectY2, 2);
		}
			
		// Functionality for focusing on a new word
		if ( (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and currentWordState == obj_control.wordStateNew and not obj_control.newWordCreated)
			or instance_exists(obj_dropDown) and rightClickWordID == currentWordID) {
				
			// Fill in the rectangle of the newWord being focused
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(0.5);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
				
			//Set the word to be focused here, draw the focus above with the chunks, and handle the delete with wordClicked
			/*if (mouse_check_button_pressed(mb_left)) {
				//ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentChunkWordID - 1, true);
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1, obj_control.wordStateDead);
					
			}*/
			// Set this to be the hovered wordID
			newWordHoverUnitID = unitID;
			newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
			newWordHoverWordID = currentWordID;
			hoverWordID = currentWordID;
				
			}
		
			// CHeck for adding a newWord after this current word
			else if (point_in_rectangle(mouse_x, mouse_y, wordRectX2, wordRectY1, wordRectX2 + gridSpaceHorizontal, wordRectY2) and not instance_exists(obj_dropDown)) {
				// Set this to be the hovered wordID
				if(not obj_control.dialogueBoxActive and not obj_control.newWordCreated) {
					newWordHoverUnitID = unitID;
					newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
					newWordHoverWordID = currentWordID;
				}
			
				if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.newWordCreated =true;
						}


						dialogueBoxActive = true;

							if (!instance_exists(obj_dialogueBox)) {
								instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
							}

				}
			}

		}
		if (point_in_rectangle(mouse_x, mouse_y, wordRectX2, wordRectY1, wordRectX1 + gridSpaceHorizontal, wordRectY1 + gridSpaceVertical) and hoverWordID == -1 and not obj_control.mouseRectMade) {
			//draw_set_color(c_red);
			//draw_rectangle(wordRectX2, wordRectY1, wordRectX2 + gridSpaceHorizontal, wordRectY1 + gridSpaceVertical, true);
			if(mouse_check_button_pressed(mb_left)) {
					
				obj_control.mouseRectBeginBetweenWords = currentWordID;
			}
		}


}
