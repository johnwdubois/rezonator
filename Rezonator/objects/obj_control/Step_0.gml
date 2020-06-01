/*
	obj_control: Step
	
	Last Updated: 2019-02-11
	
	Called from: Every frame of the game
	
	Purpose: Check for user key inputs and navigate accordingly, update the center display row based on positioning, change the font size, and check for panel pane mouse over
	
	Mechanism: Check keys every frame for input, and control the speed of navigation using conditionals
	
	Author: Terry DuBois
*/

shortcutsEnabled = true;
/*
if (instance_exists(obj_input_




text)) {
	for (var i = 0; i < instance_number(obj_input_text); i++) {
		var currentInputTextInst = instance_find(obj_input_text, i);
		if (instance_exists(currentInputTextInst)) {
			if (currentInputTextInst.enabled) {
				shortcutsEnabled = false;
			}
		}
	}
}
*/

/*
if(keyboard_check_pressed(vk_anykey)){
	show_message(string(keyboard_lastkey));
}
*/



// Mechanism to update center display row
if (!gridView) {
	if (ds_grid_height(currentActiveLineGrid) > 0) {
		var firstLinePixelY = (room_height / 2) - (currentCenterDisplayRow * gridSpaceVertical);
		if (firstLinePixelY > 150 + gridSpaceVertical) {
			currentCenterDisplayRow++;
		}
		
		
		var lastLinePixelY = (room_height / 2) + ((ds_grid_height(currentActiveLineGrid) - currentCenterDisplayRow) * gridSpaceVertical);
		if (lastLinePixelY < camera_get_view_height(view_camera[0]) - 30
		and currentCenterDisplayRow + drawRange >= ds_grid_height(currentActiveLineGrid)) {
			currentCenterDisplayRow--;
		}
		currentCenterDisplayRow = min(currentCenterDisplayRow, ds_grid_height(currentActiveLineGrid) - 1);
		currentCenterDisplayRow = max(currentCenterDisplayRow, 0);
	}
	
	
	//var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, currentCenterDisplayRow);
	//	obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
	
// Retrieve booleans for NavWindow.
var clickedInChainList = false;
var clickedInChainContents = false;
with (obj_panelPane) {
	if (currentFunction == functionChainList) {
		clickedInChainList = clickedIn;
	}
	if (currentFunction == functionChainContents) {
		clickedInChainContents = clickedIn;
	}
}

/*var numOfTouches = 0;
for(var touchLoop = 0; touchLoop < 4; touchLoop++) {
	if(device_mouse_check_button_pressed(touchLoop, mb_left)) {
		numOfTouches++;	
	}
	
}

if(numOfTouches >= 2) {
	multiTouch = true;	
	//show_message(string(numOfTouches));
}
else {
	numOfTouches = 0;
	for(var touchLoop = 0; touchLoop < 5; touchLoop++) {
		if(device_mouse_check_button(touchLoop, mb_left)) {
			numOfTouches++;	
		}
	}
	if(numOfTouches >= 2) {
		multiTouch = true;	
		//show_message(string(numOfTouches));
	}
	else {
		multiTouch = false;	
	}
}*/

var canScrollWithStackShow = true;
if (instance_exists(obj_stackShow)) {
	if (ds_grid_height(obj_chain.stackChainGrid) > 0) {
		if (ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0,  obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus)) {
			canScrollWithStackShow = false;
		}
	}
}


// Check if user is in the NavWindow. If not, allow key control on main screen.
if (!clickedInChainList and !clickedInChainContents and canScrollWithStackShow and not mouseoverHelpPane) {

	
	var scrollSpeed = 0;
	// Single press of arrow keys now moves screen by one line
	if ((keyboard_check(vk_down) or mouse_wheel_down())) {
		if(holdDownArrowKey == 0 and not mouse_wheel_down()) {
			scrollSpeed = -gridSpaceVertical;
		}
		if (holdDownArrowKey > 15) {
			scrollSpeed = (-min(arrowSpeed, 25)) * holdArrowMod;
			if (mouse_wheel_down()) {
				scrollSpeed = -(min(arrowSpeed, 25) * 2);
			}
		}
		if(holdDownArrowKey > 45) {
				holdArrowMod = 2;
		}
		if(holdDownArrowKey > 75) {
			holdArrowMod = 3;
		}
		holdDownArrowKey++;
		if (mouse_wheel_down()) {
			holdDownArrowKey = 31;
		} 
	}
	if (keyboard_check(vk_up) or mouse_wheel_up()) {
		if(holdUpArrowKey == 0 and not mouse_wheel_up()) {
			scrollSpeed = gridSpaceVertical;
		}
		if (holdUpArrowKey > 15) {
			scrollSpeed = min(arrowSpeed, 25) * holdArrowMod;
			if (mouse_wheel_up()) {
				scrollSpeed = (min(arrowSpeed, 25) * 2);
			}
		}
		if(holdUpArrowKey > 45) {
				holdArrowMod = 2;
		}
		if(holdUpArrowKey > 75) {
			holdArrowMod = 3;
		}
		holdUpArrowKey++;
		if (mouse_wheel_up()) {
			holdUpArrowKey = 31;
		}
	}

	// Allow the user to hold down the pageUp or pageDown buttons
	if (not instance_exists(obj_dialogueBox)) {
		if (keyboard_check(vk_pagedown) and not keyboard_check(vk_pageup)) {
			if (holdPgDn == 0 or (holdPgDn > 15 and holdPgDn % holdPgMod == 0)) {
				// will need to make this the difference with windowHeight to scale with PanelPanes
				scrollSpeed -= (((camera_get_view_height(view_camera[0]) - instance_find(obj_panelPane,0).windowHeight)) - obj_menuBar.menuHeight) * 0.9;//* 0.8;
			}
			if(holdPgDn > 45) {
				holdPgMod = 3;
			}
			if(holdPgDn > 75) {
				holdPgMod = 2;
			}
			holdPgDn++;
		}
		if (keyboard_check(vk_pageup) and not keyboard_check(vk_pagedown)) {
			if (holdPgUp == 0 or (holdPgUp > 15 and holdPgUp % holdPgMod == 0)) {
				scrollSpeed += (((camera_get_view_height(view_camera[0]) - instance_find(obj_panelPane,0).windowHeight)) - obj_menuBar.menuHeight) * 0.9;//* 0.8;
			}
			if(holdPgUp > 45) {
				holdPgMod = 3;
			}
			if(holdPgUp > 75) {
				holdPgMod = 2;
			}
			holdPgUp++;
		}
	}
	
	if (instance_exists(obj_dialogueBox)) {
		holdUpArrowKey = 0;
		holdDownArrowKey = 0;
		holdArrowMod = 1;
		holdPgDn = 0;
		holdPgUp = 0;
		holdPgMod = 4;
		scrollSpeed = 0;
	}
	
	if(flickVelY != 0) {
		flick_power = abs(flickVelY);
		flick_direction = sign(flickVelY);
	
		if(flick_power > flick_power_reduction_each_step) {
			 scrollPlusYDest += (( flick_power / flick_power_calibration) * flick_direction);
			 flickVelY -= flick_power_reduction_each_step * flick_direction;
	
		}
		else {
			flickVelY = 0;	
		}
	}
	
	if(scrollPlusYDest != undefined && scrollSpeed != undefined){
		scrollPlusYDest += scrollSpeed;
	}


	if (keyboard_check_released(vk_down) and !mouse_wheel_down()) {
		holdDownArrowKey = 0;
		holdArrowMod = 1;
	}
	if (holdDownArrowKey > 0 and !mouse_wheel_down() and !keyboard_check(vk_down)) {
		holdDownArrowKey = 0;
		holdArrowMod = 1;
	}
	if (keyboard_check_released(vk_up) and !mouse_wheel_up()) {
		holdUpArrowKey = 0;
		holdArrowMod = 1;
	}
	if (holdUpArrowKey > 0 and !mouse_wheel_up() and !keyboard_check(vk_up)) {
		holdUpArrowKey = 0;
		holdArrowMod = 1;
	}
	
	if (keyboard_check_released(vk_pagedown)) {
		holdPgDn = 0;
		holdPgMod = 4;
	}
	if (holdPgDn > 0 and !keyboard_check(vk_pagedown)) {
		holdPgDn = 0;
		holdPgMod = 4;
	}
	if (keyboard_check_released(vk_pageup)) {
		holdPgUp = 0;
		holdPgMod = 4;
	}
	if (holdPgUp > 0 and !keyboard_check(vk_pageup)) {
		holdPgUp = 0;
		holdPgMod = 4;
	}
	


	if (not instance_exists(obj_dialogueBox)) {
		// Scroll a full page up or down
		//if (keyboard_check_pressed(vk_pagedown)) {
		//	scrollPlusYDest -= (camera_get_view_height(view_camera[0]) * 0.8);
		//	//show_message(string(camera_get_view_height(view_camera[0])));
		//}
		//if (keyboard_check_pressed(vk_pageup)) {
		//	scrollPlusYDest += (camera_get_view_height(view_camera[0])* 0.8);
		//}
	
		// Sends user to the bottom of the main screen
		if ((keyboard_check(vk_control) and keyboard_check_pressed(vk_down)) or (keyboard_check(vk_alt) and keyboard_check_pressed(vk_down))) {
			scrollPlusYDest = -999999999999;
		}
		// Sends user to the top of the main screen
		else if ((keyboard_check(vk_control) and keyboard_check_pressed(vk_up)) or (keyboard_check(vk_alt) and keyboard_check_pressed(vk_up))) {
			scrollPlusYDest = 100;
		}
	}
}


	if (not instance_exists(obj_dialogueBox)) {		
		if (keyboard_check_pressed(vk_right) and not keyboard_check(vk_control) and not dialogueBoxActive) {
			wordLeftMarginDest -= gridSpaceHorizontal;
		}
		if (keyboard_check_pressed(vk_right) and keyboard_check(vk_control)
		or keyboard_check_pressed(vk_end) or keyboard_check_pressed(vk_right) and keyboard_check(vk_alt)) {
			scr_jumpToEnd(false);
		}
	
		/*if (keyboard_check_pressed(ord("Y")) and keyboard_check(vk_control)) {
			scr_createPlaceChains();
		}*/

		if (keyboard_check_pressed(vk_left) and not keyboard_check(vk_control) and not dialogueBoxActive) {
			wordLeftMarginDest += gridSpaceHorizontal;
		}
		if (keyboard_check_pressed(vk_left) and keyboard_check(vk_control)
		or keyboard_check_pressed(vk_home) or keyboard_check_pressed(vk_left) and keyboard_check(vk_alt)) {
			if (searchGridActive) {
				scr_jumpToEnd(true);
			}
			else {
				wordLeftMarginDest = speakerLabelMargin + 20;
			}
		}
	}
	
	if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("D"))) {
		showDevVars = !showDevVars;
		showFPS = !showFPS;
	}
	
	
	// replace word
	if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("X"))) {
		if (hoverWordID > -1 and hoverWordID  < ds_grid_height(wordGrid)) {
				
				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.replace = true;
				}


				obj_control.dialogueBoxActive = true;

				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				}
		
		}

	}

	
	if (wordDrawGridFocusedAnimationInc) {
		if (wordDrawGridFocusedAnimation < wordDrawGridFocusedAnimationMax) {
			wordDrawGridFocusedAnimation += 0.1;
		}
		else {
			wordDrawGridFocusedAnimationInc = false;
		}
	}
	else {	
		if (wordDrawGridFocusedAnimation > 0) {
			wordDrawGridFocusedAnimation -= 0.1;
		}
		else {
			wordDrawGridFocusedAnimationInc = true;
		}
	}
}

wordLeftMargin = lerp(wordLeftMargin, wordLeftMarginDest, 0.5);

var searchGridPopulated = ds_grid_height(searchGrid);
var filterGridPopulated = ds_grid_height(filterGrid);


// Culprit
if (shortcutsEnabled) {
	if(os_type == os_macosx){
		if (keyboard_check(vk_shift) and !keyboard_check(vk_control)) {
			if (keyboard_check(24) and canPressPlus) {
				prevCenterDisplayRow = scr_currentCenterLine();
				canPressPlus = false;
				if(gridSpaceVertical < gridSpaceVerticalMax) {
					gridSpaceVertical += 10;
					// Don't go above the max
					gridSpaceVertical = min(gridSpaceVertical, gridSpaceVerticalMax);
					lineSpacing += 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);
					// Multiply each line's pixelY by the new ratio
					ds_grid_multiply_region(lineGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(lineGrid), gridSpaceRatio);
			
					// If the search or filter grids are populated, then set their pixelY's as well
					if(searchGridPopulated) {
						ds_grid_multiply_region(searchGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(searchGrid), gridSpaceRatio);
					}
					if(filterGridPopulated) {
						ds_grid_multiply_region(filterGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(filterGrid), gridSpaceRatio);
					}
					if (string_length(string_digits(prevCenterDisplayRow)) == string_length(prevCenterDisplayRow)) {
						scr_jumpToLine("", prevCenterDisplayRow);
					}
					// reset the ratio
					prevGridSpaceVertical = gridSpaceVertical;
					if(arrowSpeed < arrowSpeedMax) {
						arrowSpeed++;	
					}
				}
				alarm[3] = 15;
			}

			if (keyboard_check(109) and canPressMinus) {
				prevCenterDisplayRow = scr_currentCenterLine();
				canPressMinus = false;
				if(gridSpaceVertical > gridSpaceVerticalMin) {
					gridSpaceVertical -= 10;
					// Don't go below the min
					gridSpaceVertical = max(gridSpaceVertical, gridSpaceVerticalMin);
					lineSpacing -= 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);
			
					// Multiply each line's pixelY by the new ratio
					ds_grid_multiply_region(lineGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(lineGrid), gridSpaceRatio);
			
					// If the search or filter grids are populated, then set their pixelY's as well
					if(searchGridPopulated) {
						ds_grid_multiply_region(searchGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(searchGrid), gridSpaceRatio);
					}
					if(filterGridPopulated) {
						ds_grid_multiply_region(filterGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(filterGrid), gridSpaceRatio);
					}
					if (string_length(string_digits(prevCenterDisplayRow)) == string_length(prevCenterDisplayRow)) {
						scr_jumpToLine("", prevCenterDisplayRow);
					}
					// reset the ratio
					prevGridSpaceVertical = gridSpaceVertical;
					if(arrowSpeed > arrowSpeedMin) {
						arrowSpeed--;	
					}
				}
				alarm[4] = 15;
			}
		}
	}
	else{
		if (keyboard_check(vk_shift) and !keyboard_check(vk_control)) {
			if (keyboard_check_direct(187) and canPressPlus) {
				prevCenterDisplayRow = scr_currentCenterLine();
			//	show_message(string(prevCenterDisplayRow));
				canPressPlus = false;
				if(gridSpaceVertical < gridSpaceVerticalMax) {
					gridSpaceVertical += 10;
					// Don't go above the max
					gridSpaceVertical = min(gridSpaceVertical, gridSpaceVerticalMax);
					lineSpacing += 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);
					// Multiply each line's pixelY by the new ratio
					ds_grid_multiply_region(lineGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(lineGrid), gridSpaceRatio);
			
					// If the search or filter grids are populated, then set their pixelY's as well
					if(searchGridPopulated) {
						ds_grid_multiply_region(searchGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(searchGrid), gridSpaceRatio);
					}
					if(filterGridPopulated) {
						ds_grid_multiply_region(filterGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(filterGrid), gridSpaceRatio);
					}
					if (string_length(string_digits(prevCenterDisplayRow)) == string_length(prevCenterDisplayRow)) {
						scr_jumpToLine("", prevCenterDisplayRow);
					}
					// reset the ratio
					prevGridSpaceVertical = gridSpaceVertical;
					if(arrowSpeed < arrowSpeedMax) {
						arrowSpeed *= gridSpaceRatio;	
					}
				}
				alarm[3] = 15;
				
			}

			if (keyboard_check_direct(189) and canPressMinus) {
				prevCenterDisplayRow = scr_currentCenterLine();
				//show_message(string(prevCenterDisplayRow));
				canPressMinus = false;
				if(gridSpaceVertical > gridSpaceVerticalMin) {
					gridSpaceVertical -= 10;
					// Don't go below the min
					gridSpaceVertical = max(gridSpaceVertical, gridSpaceVerticalMin);
					lineSpacing -= 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);
			
					// Multiply each line's pixelY by the new ratio
					ds_grid_multiply_region(lineGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(lineGrid), gridSpaceRatio);
			
					// If the search or filter grids are populated, then set their pixelY's as well
					if(searchGridPopulated) {
						ds_grid_multiply_region(searchGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(searchGrid), gridSpaceRatio);
					}
					if(filterGridPopulated) {
						ds_grid_multiply_region(filterGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(filterGrid), gridSpaceRatio);
					}
					if (string_length(string_digits(prevCenterDisplayRow)) == string_length(prevCenterDisplayRow)) {
						scr_jumpToLine("", prevCenterDisplayRow);
					}
					// reset the ratio
					prevGridSpaceVertical = gridSpaceVertical;
					if(arrowSpeed > arrowSpeedMin) {
						arrowSpeed *= gridSpaceRatio;	
					}
				}
				alarm[4] = 15;
			}
		}
	}
}

gridSpaceHorizontal = clamp(gridSpaceHorizontal, gridSpaceHorizontalMin, gridSpaceHorizontalMax);
gridSpaceVertical = clamp(gridSpaceVertical, gridSpaceVerticalMin, gridSpaceVerticalMax);

/*
if (keyboard_check_pressed(ord("Q"))) {
	displayRowAscending = !displayRowAscending;
	ds_grid_sort(currentActiveLineGrid, lineGrid_colDisplayRow, displayRowAscending);
	scr_refreshLineGridDisplayRow(obj_control.lineGrid);
}
*/

if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("Q")) ) {
	
	
/*
	if (!allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
		
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	obj_dialogueBox.questionWindowActive = true;
	
	}

				
*/


	audio_stop_all();
	
	scr_userSettingsIniFile();
	
	
	if (!allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
		
		if (os_type == os_macosx) {

			with (obj_fileLoader) {
				scr_saveREZ(false);
			}
		
		}
		else {
			if (show_question("Would you like to save before exiting?")) {
				with (obj_fileLoader) {
					scr_saveREZ(false);
				}
			}
		}
	}
		global.tutorial = false;
		keyboard_string = "";
		room_goto(rm_openingScreen);
}

if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("E")) && shortcutsEnabled) {
	lineGridShuffle = !lineGridShuffle;
	if (lineGridShuffle) {
		scr_shuffleDisplayRows();
		scr_refreshLineGridDisplayRow(obj_control.lineGrid);
	}
	else {
		with(obj_panelPane) {
			functionSort_performSort = true;
		}
	}
}

currentCenterDisplayRow = max(currentCenterDisplayRow, 0);
currentCenterDisplayRow = min(currentCenterDisplayRow, ds_grid_height(currentActiveLineGrid) - 1);



// hide participant names
if (!gridView) {
	if (keyboard_check(vk_control) and keyboard_check_pressed(ord("H"))) {
		scr_hideSpeakerName();
	}
}



// Check for mouse over of the Panel Pane
// It's gotta stop the drag but not require the user to click into the main screen first
if ((window_get_cursor() != cr_size_ns) && !mouse_check_button(mb_left)) {
	mouseoverPanelPane = false;
	mouseoverScrollBar = false;
	mouseoverDialogueBox = false;
}
for (var i = 0; i < instance_number(obj_panelPane); i++) {
	var panelPaneInst = instance_find(obj_panelPane, i);
	var toolPaneInst = instance_find(obj_toolPane, 0);
	
	if (point_in_rectangle(mouse_x, mouse_y, panelPaneInst.x, panelPaneInst.y, panelPaneInst.x + panelPaneInst.windowWidth, panelPaneInst.y + panelPaneInst.windowHeight)) {
		mouseoverPanelPane = true;
	}

	if (point_in_rectangle(mouse_x, mouse_y, toolPaneInst.x, toolPaneInst.y, toolPaneInst.x + toolPaneInst.windowWidth, toolPaneInst.y + toolPaneInst.windowHeight)) {
		mouseoverPanelPane = true;
	}
	//check for mouse over search pane
	if (obj_control.dialogueBoxActive && point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 - 250, camera_get_view_height(view_camera[0])/2 - 125 + 30, camera_get_view_width(view_camera[0]) /2 + 250, camera_get_view_height(view_camera[0])/2 + 125)){
		mouseoverPanelPane = true;		
	}
	
	if (panelPaneInst.currentFunction == panelPaneInst.functionHelp) {
		if (!panelPaneInst.functionHelp_collapsed) {
			if (point_in_rectangle(mouse_x, mouse_y, panelPaneInst.functionHelp_helpWindowRectX1, panelPaneInst.functionHelp_helpWindowRectY1, panelPaneInst.functionHelp_helpWindowRectX2, panelPaneInst.functionHelp_helpWindowRectY2)) {
				mouseoverPanelPane = true;
			}
		}
	}
}

if (instance_exists(obj_audioUI)) {
	if (obj_audioUI.visible) {
		if (point_in_rectangle(mouse_x, mouse_y, obj_audioUI.x, obj_audioUI.y, obj_audioUI.x + obj_audioUI.windowWidth, obj_audioUI.y + obj_audioUI.windowHeight)) {
			mouseoverPanelPane = true;
		}
	}
}
if (instance_exists(obj_stackShow)) {
	if (point_in_rectangle(mouse_x, mouse_y, obj_stackShow.windowX1, obj_stackShow.windowY1, obj_stackShow.windowX2, obj_stackShow.windowY2)) {
		mouseoverPanelPane = true;	
	}
}
if (instance_exists(obj_customTagPane)) {
	if (point_in_rectangle(mouse_x, mouse_y, obj_customTagPane.x, obj_customTagPane.y, obj_customTagPane.x + obj_customTagPane.windowWidth, obj_customTagPane.y + obj_customTagPane.windowHeight)) {
		mouseoverPanelPane = true;	
	}
}



if not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) or not (currentActiveLineGrid == lineGrid) {
	//newWordHoverUnitID = -1;
	//newWordHoverWordSeq = -1;
	//newWordHoverWordID = -1;
}


if (instance_exists(obj_dropDown)) {
	ableToCreateDropDown = false;
}
if (not instance_exists(obj_dropDown) and not ableToCreateDropDownAlarmSet) {
	alarm[0] = 2;
	ableToCreateDropDownAlarmSet = true;
}


if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("S"))){
	obj_panelPane.showTracker = !obj_panelPane.showTracker;
}


scr_fontSizeControl();

if(!updatedSpeakerLabel){
	with(obj_alarm){
			alarm[7] = 5;
	}
	updatedSpeakerLabel = true;
}
