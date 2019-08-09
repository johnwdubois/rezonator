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
if (instance_exists(obj_input_text)) {
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

// Check if user is in the NavWindow. If not, allow key control on main screen.
if (!clickedInChainList and !clickedInChainContents) {
	
	var scrollSpeed = 0;
	if (keyboard_check(vk_down) or mouse_wheel_down()) {
		if (holdDownArrowKey == 0 or holdDownArrowKey > 30) {
			scrollSpeed = -8;
			if (mouse_wheel_down()) {
				scrollSpeed = -16;
			}
		}
		holdDownArrowKey++;
		if (mouse_wheel_down()) {
			holdDownArrowKey = 31;
		}
	}
	if (keyboard_check(vk_up) or mouse_wheel_up()) {
		if (holdUpArrowKey == 0 or holdUpArrowKey > 30) {
			scrollSpeed = 8;
			if (mouse_wheel_up()) {
				scrollSpeed = 16;
			}
		}
		holdUpArrowKey++;
		if (mouse_wheel_up()) {
			holdUpArrowKey = 31;
		}
	}
	
	if (instance_exists(obj_dialogueBox)) {
		holdUpArrowKey = 0;
		holdDownArrowKey = 0;
		scrollSpeed = 0;
	}
	
	scrollPlusYDest += scrollSpeed;


	if (keyboard_check_released(vk_down) and !mouse_wheel_down()) {
		holdDownArrowKey = 0;
	}
	if (holdDownArrowKey > 0 and !mouse_wheel_down() and !keyboard_check(vk_down)) {
		holdDownArrowKey = 0;
	}
	if (keyboard_check_released(vk_up) and !mouse_wheel_up()) {
		holdUpArrowKey = 0;
	}
	if (holdUpArrowKey > 0 and !mouse_wheel_up() and !keyboard_check(vk_up)) {
		holdUpArrowKey = 0;
	}


	if (not instance_exists(obj_dialogueBox)) {
		// Scroll a full page up or down
		if (keyboard_check_pressed(vk_pagedown)) {
			scrollPlusYDest -= (camera_get_view_height(view_camera[0]) * 0.8);
			//show_message(string(camera_get_view_height(view_camera[0])));
		}
		if (keyboard_check_pressed(vk_pageup)) {
			scrollPlusYDest += (camera_get_view_height(view_camera[0])* 0.8);
		}
	
		// Sends user to the bottom of the main screen
		if (keyboard_check(vk_control) and keyboard_check_pressed(vk_down)) {
			scrollPlusYDest = -999999999999;
		}
		// Sends user to the top of the main screen
		else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_up)) {
			scrollPlusYDest = 100;
		}
	}
}


	if (not instance_exists(obj_dialogueBox)) {		
		if (keyboard_check_pressed(vk_right) and not keyboard_check(vk_control) and not dialogueBoxActive) {
			wordLeftMarginDest -= gridSpaceHorizontal;
		}
		if (keyboard_check_pressed(vk_right) and keyboard_check(vk_control)
		or keyboard_check_pressed(vk_end)) {
			scr_jumpToEnd(false);
		}
	
		if (keyboard_check_pressed(ord("Y")) and keyboard_check(vk_control)) {
			scr_createPlaceChains();
		}

		if (keyboard_check_pressed(vk_left) and not keyboard_check(vk_control) and not dialogueBoxActive) {
			wordLeftMarginDest += gridSpaceHorizontal;
		}
		if (keyboard_check_pressed(vk_left) and keyboard_check(vk_control)
		or keyboard_check_pressed(vk_home)) {
			if (searchGridActive) {
				scr_jumpToEnd(true);
			}
			else {
				wordLeftMarginDest = speakerLabelMargin + speakerLabelMarginBuffer;
			}
		}
	}
	
	if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("D"))) {
		showDevVars = !showDevVars;
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

if (wordLeftMargin < wordLeftMarginDest) {
	wordLeftMargin += abs(wordLeftMargin - wordLeftMarginDest) / 6;
}
else if (wordLeftMargin > wordLeftMarginDest) {
	wordLeftMargin -= abs(wordLeftMargin - wordLeftMarginDest) / 6;
}

var searchGridPopulated = ds_grid_height(searchGrid);
var filterGridPopulated = ds_grid_height(filterGrid);


// Culprit
if (shortcutsEnabled) {
	if (keyboard_check(vk_shift) and !keyboard_check(vk_control)) {
		if (keyboard_check_direct(187) and canPressPlus) {
			canPressPlus = false;
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
			// reset the ratio
			prevGridSpaceVertical = gridSpaceVertical;
			alarm[3] = 15;
		}

		if (keyboard_check_direct(189) and canPressMinus) {
			canPressMinus = false;
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
			// reset the ratio
			prevGridSpaceVertical = gridSpaceVertical;
			alarm[4] = 15;
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


// Check for mouse over of the Panel Pane
// It's gotta stop the drag but not require the user to click into the main screen first
if(window_get_cursor() != cr_size_ns) {// && !mouse_check_button_pressed(mb_left)) {
	mouseoverPanelPane = false;
	mouseoverScrollBar = false;
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

if (ds_grid_height(unitGrid) == global.totalUnitAmount and ds_grid_height(obj_chain.unitInStackGrid) == 0) {
	with (obj_chain) {
		scr_loadUnitInStackGrid();
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


if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("Q"))){
	obj_panelPane.showTracker = !obj_panelPane.showTracker;
}




scr_fontSizeControl();