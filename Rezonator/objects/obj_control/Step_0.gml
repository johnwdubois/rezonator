/*
	Purpose: Check for user key inputs and navigate accordingly, update the center display row based on positioning, change the font size, and check for panel pane mouse over
*/

#macro vk_rcommand 91
#macro vk_lcommand 92

if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) {
	// set display unit list if it does not exist
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	if (scr_isNumericAndExists(discourseSubMap, ds_type_map)) {
		 var docDisplayUnitList = discourseSubMap[? "displayUnitList"];
		 
		 if(ds_list_size(docDisplayUnitList) > 1){
			displayUnitList = docDisplayUnitList;
		 }
		 else{
			 displayUnitList = discourseSubMap[? "unitList"];
			 discourseSubMap[? "displayUnitList"] = discourseSubMap[? "unitList"];
		 }
	}
}


shortcutsEnabled = true;
cameraBottomLine = camera_get_view_height(view_get_camera(0));

global.delayInput = max(global.delayInput - 1, 0);

if (hideAll) {
	gridView = false;
}

// handle double click timer
if (doubleClickTimer > -1) {
	if (doubleClickTimer < 20) {
		doubleClickTimer++;
	}
	else {
		doubleClickTimer = -1;
	}
}




ctrlHold = false;
if(os_type == os_macosx){
	if ( keyboard_check(vk_rcommand) or keyboard_check(vk_lcommand)) {
		ctrlHold = true;
	}
}
else {
	if (keyboard_check(vk_control)) {
		ctrlHold = true;
	}
}
if (keyboard_check_released(vk_rcommand) || keyboard_check_released(vk_lcommand)) {
	keyboard_key_release(vk_up);
	keyboard_key_release(vk_down);
	keyboard_key_release(vk_lshift);
	keyboard_key_release(vk_lalt);
	keyboard_key_release(vk_lcontrol);
}


// Mechanism to update center display row
if (!gridView) {
	if (ds_grid_height(currentActiveLineGrid) > 0) {
		/*var firstLinePixelY = (room_height / 2) - (currentCenterDisplayRow * gridSpaceVertical);
		if (firstLinePixelY > 150 + gridSpaceVertical) {
			currentCenterDisplayRow++;
		}
		
		
		var lastLinePixelY = (room_height / 2) + ((ds_grid_height(currentActiveLineGrid) - currentCenterDisplayRow) * gridSpaceVertical);
		if (lastLinePixelY < camera_get_view_height(camera_get_active()) - 30
		and currentCenterDisplayRow + drawRange >= ds_grid_height(currentActiveLineGrid)) {
			currentCenterDisplayRow--;
		}
		currentCenterDisplayRow = min(currentCenterDisplayRow, ds_grid_height(currentActiveLineGrid) - 1);
		currentCenterDisplayRow = max(currentCenterDisplayRow, 0);*/
		currentCenterDisplayRow = scr_currentTopLine();
	}
	
	
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


scrollPlusX = lerp(scrollPlusX, scrollPlusXDest, 0.4);


// Check if user is in the NavWindow. If not, allow key control on main screen.
if (!clickedInChainList and !clickedInChainContents and not mouseoverHelpPane and !instance_exists(obj_dropDown)) {

	
	var scrollSpeed = 0;
	// Single press of arrow keys now moves screen by one line
	if ((keyboard_check(vk_down) or mouse_wheel_down())) {
		if(holdDownArrowKey == 0 and not mouse_wheel_down()) {

			scrollSpeed = -gridSpaceVertical;
			/*
			if(obj_control.currentActiveLineGrid == obj_control.searchGrid and obj_panelPane.functionChainList_lineGridRowFocused < ds_grid_height(obj_control.searchGrid) - 1) {
				obj_panelPane.functionChainList_lineGridRowFocused++;
				var currentLineUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
				var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
				obj_panelPane.functionChainContents_BGColor = lineColor;
				ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
				ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
				obj_panelPane.functionChainContents_lineGridRowFocused = -1;	
			}
			*/
		}
		if (holdDownArrowKey > 15) {
			scrollSpeed = (-min(arrowSpeed, 25)) * holdArrowMod;
			if (mouse_wheel_down()) {
				scrollSpeed = -(min(arrowSpeed, 25) * 2);
			}
			/*
			if((holdDownArrowKey % (4 - holdArrowMod) == 0) and obj_control.currentActiveLineGrid == obj_control.searchGrid and obj_panelPane.functionChainList_lineGridRowFocused < ds_grid_height(obj_control.searchGrid) - 1) {
				obj_panelPane.functionChainList_lineGridRowFocused++;
				var currentLineUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
				var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
				obj_panelPane.functionChainContents_BGColor = lineColor;
				ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
				ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
				obj_panelPane.functionChainContents_lineGridRowFocused = -1;	
			}
			*/
		}
		else if(mouse_wheel_down()) {
			scrollSpeed = -(min(arrowSpeed, 25) * 1.5);
			/*if(obj_control.currentActiveLineGrid == obj_control.searchGrid and obj_panelPane.functionChainList_lineGridRowFocused < ds_grid_height(obj_control.searchGrid) - 1) {
				obj_panelPane.functionChainList_lineGridRowFocused++;
				var currentLineUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
				var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
				obj_panelPane.functionChainContents_BGColor = lineColor;
				ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
				ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
				obj_panelPane.functionChainContents_lineGridRowFocused = -1;	
			}*/
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
			/*
			if(obj_control.currentActiveLineGrid == obj_control.searchGrid and obj_panelPane.functionChainList_lineGridRowFocused > 0) {
				obj_panelPane.functionChainList_lineGridRowFocused--;
				var currentLineUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
				var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
				obj_panelPane.functionChainContents_BGColor = lineColor;
				ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
				ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
				obj_panelPane.functionChainContents_lineGridRowFocused = -1;	
			}
			*/
		}
		if (holdUpArrowKey > 15) {
			scrollSpeed = min(arrowSpeed, 25) * holdArrowMod;
			if (mouse_wheel_up()) {
				scrollSpeed = (min(arrowSpeed, 25) * 2);
			}
			/*
			if((holdUpArrowKey % (4 - holdArrowMod) == 0) and obj_control.currentActiveLineGrid == obj_control.searchGrid and obj_panelPane.functionChainList_lineGridRowFocused > 0) {
				obj_panelPane.functionChainList_lineGridRowFocused--;
				var currentLineUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
				var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
				obj_panelPane.functionChainContents_BGColor = lineColor;
				ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
				ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
				obj_panelPane.functionChainContents_lineGridRowFocused = -1;	
			}
			*/
		}
		else if(mouse_wheel_up()) {
			scrollSpeed = (min(arrowSpeed, 25) *1.5);
			/*if(obj_control.currentActiveLineGrid == obj_control.searchGrid and obj_panelPane.functionChainList_lineGridRowFocused > 0) {
				obj_panelPane.functionChainList_lineGridRowFocused--;
				var currentLineUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
				var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
				obj_panelPane.functionChainContents_BGColor = lineColor;
				ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
				ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
				obj_panelPane.functionChainContents_lineGridRowFocused = -1;	
			}*/
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
				scrollSpeed -= camera_get_view_height(view_get_camera(0)) - wordTopMargin - (gridSpaceVertical);//(((camera_get_view_height(camera_get_active()) - instance_find(obj_panelPane,0).windowHeight)) - obj_menuBar.menuHeight) * 0.9;//* 0.8;
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
				scrollSpeed += camera_get_view_height(view_get_camera(0)) - wordTopMargin - (gridSpaceVertical);//(((camera_get_view_height(camera_get_active()) - instance_find(obj_panelPane,0).windowHeight)) - obj_menuBar.menuHeight) * 0.9;//* 0.8;
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
		//	scrollPlusYDest -= (camera_get_view_height(camera_get_active()) * 0.8);
		//	//show_message(string(camera_get_view_height(camera_get_active())));
		//}
		//if (keyboard_check_pressed(vk_pageup)) {
		//	scrollPlusYDest += (camera_get_view_height(camera_get_active())* 0.8);
		//}
	
		// Sends user to the bottom of the main screen
		if ((ctrlHold and (keyboard_check_pressed(vk_down) or keyboard_check_pressed(vk_end))) or (keyboard_check(vk_alt) and (keyboard_check_pressed(vk_down) or keyboard_check_pressed(vk_end)))) {
			scrollPlusYDest = -999999999999;
		}
		// Sends user to the top of the main screen
		else if ((ctrlHold and (keyboard_check_pressed(vk_up) or keyboard_check_pressed(vk_home))) or (keyboard_check(vk_alt) and (keyboard_check_pressed(vk_up)  or keyboard_check_pressed(vk_home)))) {
			scrollPlusYDest = 100;
		}
		
		if (keyboard_check_pressed(vk_right) and not keyboard_check(vk_control) and not dialogueBoxActive) {
			//show_message("right");
			if(drawLineState == lineState_ltr){
				scrollPlusXDest -= gridSpaceHorizontal;
			}
			else{
				scrollPlusXDest += gridSpaceHorizontal;
			}
		}
		if ((keyboard_check_pressed(vk_right) and keyboard_check(vk_control))
		or (keyboard_check_pressed(vk_end) and not keyboard_check(vk_control))
		or (keyboard_check_pressed(vk_right) and keyboard_check(vk_alt))) {
			scr_homeEnd(false);
		}


		if (keyboard_check_pressed(vk_left) and not keyboard_check(vk_control) and not dialogueBoxActive) {
			if(drawLineState == lineState_ltr){
				scrollPlusXDest += gridSpaceHorizontal;
			}
			else{
				scrollPlusXDest -= gridSpaceHorizontal;
			}
			//show_message("left");
		}
		if ((keyboard_check_pressed(vk_left) and keyboard_check(vk_control))
		or (keyboard_check_pressed(vk_home) and not keyboard_check(vk_control))
		or (keyboard_check_pressed(vk_left) and keyboard_check(vk_alt)) ) {
			scr_homeEnd(true);
		}
	}
}
	
	if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("D"))) {
		showDevVars = !showDevVars;
		showFPS = !showFPS;
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

var searchGridPopulated = ds_grid_height(searchGrid);
var filterGridPopulated = ds_grid_height(filterGrid);


// Culprit
if (shortcutsEnabled) {
	if(os_type == os_macosx){
		if (keyboard_check(vk_shift) and !keyboard_check(vk_control)) {
			if (keyboard_check(24) and canPressPlus) {
				
				canPressPlus = false;
				if(gridSpaceVertical < gridSpaceVerticalMax) {
					gridSpaceVertical += 10;
					// Don't go above the max
					gridSpaceVertical = min(gridSpaceVertical, gridSpaceVerticalMax);
					lineSpacing += 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);
					
					// reset the ratio
					prevGridSpaceVertical = gridSpaceVertical;
					if(arrowSpeed < arrowSpeedMax) {
						arrowSpeed++;	
					}
				}
				alarm[3] = 15;
			}

			if (keyboard_check(109) and canPressMinus) {
			
				canPressMinus = false;
				if(gridSpaceVertical > gridSpaceVerticalMin) {
					gridSpaceVertical -= 10;
					// Don't go below the min
					gridSpaceVertical = max(gridSpaceVertical, gridSpaceVerticalMin);
					lineSpacing -= 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);
			
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

				canPressPlus = false;
				if(gridSpaceVertical < gridSpaceVerticalMax) {
					gridSpaceVertical += 10;
					// Don't go above the max
					gridSpaceVertical = min(gridSpaceVertical, gridSpaceVerticalMax);
					lineSpacing += 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);

					// reset the ratio
					prevGridSpaceVertical = gridSpaceVertical;
					if(arrowSpeed < arrowSpeedMax) {
						arrowSpeed *= gridSpaceRatio;	
					}
				}
				alarm[3] = 15;
				
			}

			if (keyboard_check_direct(189) and canPressMinus) {
				canPressMinus = false;
				if(gridSpaceVertical > gridSpaceVerticalMin) {
					gridSpaceVertical -= 10;
					// Don't go below the min
					gridSpaceVertical = max(gridSpaceVertical, gridSpaceVerticalMin);
					lineSpacing -= 4;
					gridSpaceRatio = (gridSpaceVertical/prevGridSpaceVertical);
			
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



if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("Q")) ) {


	audio_stop_all();
	scr_saveINI();
	
	if (!allSaved) {
		
		if (os_type == os_macosx) {

			with (obj_fileLoader) {
				scr_saveREZ(false);
			}
		
		}
		else {
			if (show_question(scr_get_translation("msg_warning_save-prompt"))) {
				with (obj_fileLoader) {
					scr_saveREZ(false);
				}
			}
		}
	}
	keyboard_string = "";
	room_goto(rm_openingScreen);
}


currentCenterDisplayRow = max(currentCenterDisplayRow, 0);
currentCenterDisplayRow = min(currentCenterDisplayRow, ds_grid_height(currentActiveLineGrid) - 1);



// hide participant names
if (!gridView) {
	if (keyboard_check(vk_control) and keyboard_check_pressed(ord("H"))) {
		scr_showSpeakerName(!obj_control.showSpeakerName);
	}
}

// Check for mouse over of the Panel Pane
// It's gotta stop the drag but not require the user to click into the main screen first
if ((window_get_cursor() != cr_size_ns) && !mouse_check_button(mb_left)) {
	mouseoverPanelPane = false;
	mouseoverScrollBar = false;
	mouseoverDialogueBox = false;
}

// set mouseoverPanelPane
if (obj_panelPane.showNav) {
	for (var i = 0; i < instance_number(obj_panelPane); i++) {
		
		// get current pane
		var panelPaneInst = instance_find(obj_panelPane, i);
		var isLeft = (panelPaneInst.currentFunction == panelPaneInst.functionChainList);
		var isRight = (panelPaneInst.currentFunction == panelPaneInst.functionChainContents);
		var isTabs = (panelPaneInst.currentFunction == panelPaneInst.functionTabs);
		
		// don't set mouseover to be true if this pane is hidden!
		if ((isLeft && obj_panelPane.showNavLeft) || (isRight && obj_panelPane.showNavRight) || isTabs) {
			// check if mouse is in range
			if (point_in_rectangle(mouse_x, mouse_y, panelPaneInst.x, panelPaneInst.y, panelPaneInst.x + panelPaneInst.windowWidth, panelPaneInst.y + panelPaneInst.windowHeight)) {
				mouseoverPanelPane = true;
			}
		}
		
		// check for mouse over search pane
		if (obj_control.dialogueBoxActive && point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(camera_get_active()) /2 - 250, camera_get_view_height(camera_get_active())/2 - 125 + 30, camera_get_view_width(camera_get_active()) /2 + 250, camera_get_view_height(camera_get_active())/2 + 125)){
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
}

// make sure mouseoverpanelpane accounts for the menu bar as well!
if (instance_exists(obj_menuBar)) {
	if (obj_menuBar.mouseoverMenuBar) {
		mouseoverPanelPane = true;
	}
}

// also make sure mouseoverpanelpane accounts for the toolpane
if (instance_exists(obj_toolPane)) {
	if (point_in_rectangle(mouse_x, mouse_y, obj_toolPane.x, obj_toolPane.y, obj_toolPane.x + obj_toolPane.windowWidth, obj_toolPane.y + obj_toolPane.windowHeight)) {
		mouseoverPanelPane = true;
	}
}





if (instance_exists(obj_audioUI)) {
	if (obj_audioUI.visible) {
		if (point_in_rectangle(mouse_x, mouse_y, obj_audioUI.x, obj_audioUI.y, obj_audioUI.x + obj_audioUI.windowWidth, obj_audioUI.y + obj_audioUI.windowHeight)) {
			mouseoverPanelPane = true;
		}
	}
}


if (not obj_audioUI.mouseOverAudioUI and not mouseoverPanelPane and not instance_exists(obj_dropDown) and not instance_exists(obj_dialogueBox)) {
	mouseOverUI = false;
}
else {
	mouseOverUI = true;
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


// quick filter
if (keyboard_check_pressed(ord("P")) and !keyboard_check(vk_control) and !keyboard_check(vk_lshift) and !keyboard_check(vk_rshift)
and shortcutsEnabled and mouseoverTagShortcut == "" and currentActiveLineGrid != searchGrid and !instance_exists(obj_dropDown) and !instance_exists(obj_dialogueBox)) {
	
	// If filter is active, deactivate it
	if (obj_control.quickFilterGridActive) {
			
		// Switch to active grid
		obj_control.quickFilterGridActive = false;
		if (obj_control.filterGridActive) {
			obj_control.currentActiveLineGrid = obj_control.filterGrid;
		}
		else if (obj_control.searchGridActive) {
			obj_control.currentActiveLineGrid = obj_control.searchGrid;
		}
		else {
			scr_disableFilter();
		}

	}
	else if (obj_chain.currentFocusedChainID != "" || quickPickedChainID != "") {
			
		obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
		obj_control.quickPickedChainID = obj_chain.currentFocusedChainID;
		
		// activate quick filter!
		scr_renderFilter2();
	}
}


if (keyboard_check_pressed(ord("Y")) and keyboard_check(vk_control)){
	with(obj_fileLoader){
		alarm[7] = 2;
	}
}


var fileCaptionString = string(game_display_name)
//display current file name in window caption
if(global.fileSaveName == "undefined" or is_undefined(global.fileSaveName)){
	fileCaptionString = string(game_display_name) + " - " + filename_name(global.importFilename);
}
else{
	fileCaptionString = string(game_display_name) + " - " + filename_name(global.fileSaveName);
}
var captionString = fileCaptionString;
if (!obj_control.allSaved) {
	captionString = fileCaptionString + "*"
}

window_set_caption(captionString);


scr_fontSizeControl();

