/*
	Purpose: Check for the mouse cursor over this word, and check for left and right mouse click
*/
function scr_mouseOnWord(currentWordID, wordRectX1, wordRectY1, wordRectX2, wordRectY2, unitID, drawWordLoop, currentWordIDListSize, panelPaneResizeHeld, currentWordState, drawLineLoop) {


	//Prevent the mouse from clicking on words/lines while releasing from a drag
	var mouseRectExists = ((abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5) or (abs(obj_control.mouseHoldRectX1 - obj_control.mouseHoldRectX2) > 5));
	if(mouseRectExists) {
		obj_control.mouseoverNeutralSpace = false;		
	}
	
	// figure out if the user has their mouse hovering over this word, and if so, are they clicking?
	var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_flyout);
	var mouseoverWord = point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) && !mouseoverCancel;
	
	if (mouseoverWord) {
		obj_control.mouseoverNeutralSpace = false;	
		hoverTokenID = currentWordID;
		
		// Check to see if this word should be hovered over and allowed to be clicked
		if (not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not obj_control.mouseoverPanelPane and (hoverTokenID == currentWordID || hoverTokenID == -1)) {
		
			draw_set_color(global.colorThemeBorders);
			draw_set_alpha(1);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
			// Word clicked with a Chain tool selected
			if ((device_mouse_check_button_released(0, mb_left) and not mouseRectExists) and obj_control.touchReleaseCheck and obj_toolPane.currentMode != obj_toolPane.modeRead) {
				var focusedchainIDSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
				
				//dont allow words to be added to stacks by deselecting them
				if(is_numeric(focusedchainIDSubMap)){
					if(ds_exists(focusedchainIDSubMap, ds_type_map)){
						var prevChainType = ds_map_find_value(focusedchainIDSubMap, "type");
						if(prevChainType == "stackChain"){
							scr_chainDeselect();
						}
					}
				}
				// Check for Merge Chains click
				if (obj_control.ctrlHold) {
					// if we are going to combine chains, we need to get the inChainsList for this word
					var hoverWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, obj_control.hoverTokenID - 1);
					scr_combineChainsDrawLine(hoverWordInChainsList);
				}
				else {
					with (obj_chain) {
						scr_wordClicked(currentWordID, unitID);
					}
				}
				
			}
			// If in Read Mode, focus line in Nav window
			else if (obj_toolPane.currentMode == obj_toolPane.modeRead and ((device_mouse_check_button_released(0, mb_left) and not mouseRectExists) and obj_control.touchReleaseCheck)) {
				
				// With Audio, jump to this line's start time in the Audio File
				if (instance_exists(obj_audioUI)) {
					if (obj_audioUI.visible and file_exists(obj_audioUI.audioFile) and obj_audioUI.audioSound != -1) {
						scr_audioJumpToUnit(unitID);
					}
				}
				
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
				//forgot why this was taken out
				/*ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
				ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, drawLineLoop, 1);
				with (obj_panelPane) {
					functionChainList_lineGridRowFocused = drawLineLoop;
					functionChainContents_BGColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, unitID - 1);
					functionChainList_currentTab = functionChainList_tabLine;
				}*/
				

			}
			
			
			// Check for rightMouseClick
			if (device_mouse_check_button_released(0, mb_right) and !instance_exists(obj_dialogueBox)) {
				
				
				obj_control.rightClickWordID = obj_control.newWordHoverWordID;
				obj_control.rightClickUnitID = obj_control.newWordHoverUnitID;
				obj_control.rightClickWordSeq = obj_control.newWordHoverWordSeq;
				obj_control.rightClickDisplayRow = -1;
				
				// wait 1 frame and then show the right click dropdown
				with (obj_alarm) {
					alarm[11] = 2;
				}

			}
				
		}
	}
	



	
	
	
	
	
		
	var inBoxHoldRect = false;



	
	// Set this to be the hovered wordID
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and !instance_exists(obj_dialogueBox)) {
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
		if ( (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) 
		and currentWordState == obj_control.wordStateNew and not obj_control.newWordCreated)
		or instance_exists(obj_dropDown) and rightClickWordID == currentWordID) {
				
			// Fill in the rectangle of the newWord being focused
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(0.5);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
				
			// Set this to be the hovered wordID
			newWordHoverUnitID = unitID;
			newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
			newWordHoverWordID = currentWordID;
			hoverTokenID = currentWordID;
				
		}
		
			// Check for adding a newWord after this current word
		else if (point_in_rectangle(mouse_x, mouse_y, wordRectX2, wordRectY1, wordRectX2 + gridSpaceHorizontal, wordRectY2) 
		and not instance_exists(obj_dropDown)) {
			// Set this to be the hovered wordID
			if(not obj_control.dialogueBoxActive and not obj_control.newWordCreated) {
				newWordHoverUnitID = unitID;
				newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
				newWordHoverWordID = currentWordID;
			}
			
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.newWordCreated = true;
				}


				dialogueBoxActive = true;

				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				}
			}
		}

	}
	
	// Check if the mouseRect is starting between words
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX2, wordRectY1, wordRectX1 + gridSpaceHorizontal, wordRectY1 + gridSpaceVertical) and hoverTokenID == -1 and not obj_control.mouseRectMade) {
		if(mouse_check_button_pressed(mb_left)) {	
			obj_control.mouseRectBeginBetweenWords = currentWordID;
		}
	}
}
