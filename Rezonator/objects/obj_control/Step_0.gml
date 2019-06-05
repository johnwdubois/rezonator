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
	
// Retrieve booleans for NavWindow.	
with (obj_panelPane) {
	if(currentFunction == functionChainList){
		var list = clickedIn;
	}
	if(currentFunction == functionChainContents){
		var contents = clickedIn;
	}
}

// Check if user is in the NavWindow. If not, allow key control on main screen.
if (list == false and contents == false) {
	if (keyboard_check(vk_down) or mouse_wheel_down()) {
		if (holdDownArrowKey == 0 or holdDownArrowKey > 30)
		{
			currentCenterDisplayRow++;
		}
		holdDownArrowKey++;
		if (mouse_wheel_down()) {
			holdDownArrowKey = 31;
		}
	}

	if (keyboard_check_released(vk_down) and !mouse_wheel_down()) {
		holdDownArrowKey = 0;
	}
	if (holdDownArrowKey > 0 and !mouse_wheel_down() and !keyboard_check(vk_down)) {
		holdDownArrowKey = 0;
	}


	if (keyboard_check(vk_up) or mouse_wheel_up()) {
		if (holdUpArrowKey == 0 or holdUpArrowKey > 30) {
			currentCenterDisplayRow--;
		}
		holdUpArrowKey++;
		if (mouse_wheel_up()) {
			holdUpArrowKey = 31;
		}
	}

	if (keyboard_check_released(vk_up) and !mouse_wheel_up()) {
		holdUpArrowKey = 0;
	}
	if (holdUpArrowKey > 0 and !mouse_wheel_up() and !keyboard_check(vk_up)) {
		holdUpArrowKey = 0;
	}

	if (keyboard_check_pressed(vk_pagedown)) {
		currentCenterDisplayRow += drawRange;
	}

	if (keyboard_check_pressed(vk_pageup)) {
		currentCenterDisplayRow -= drawRange;
	}
	// Sends user to the bottom of the main screen
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_down)) {
		currentCenterDisplayRow = ds_grid_height(currentActiveLineGrid) - 1;
		
		for (var i = (currentCenterDisplayRow - drawRangeEnd); i < currentCenterDisplayRow; i++) {
			if (i < 0 or i >= ds_grid_height(lineGrid)) {
				break;
			}
			
			var currentLineDestY = (ds_grid_get(currentActiveLineGrid, lineGrid_colDisplayRow, i) - currentCenterDisplayRow) * gridSpaceVertical + (room_height / 2);
			ds_grid_set(currentActiveLineGrid, lineGrid_colPixelY, i, currentLineDestY);
		}
	}
	// Sends user to the top of the main screen
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_up)) {
		currentCenterDisplayRow = 0;
		
		for (var i = currentCenterDisplayRow; i < drawRange + 10; i++) {
			if (i >= ds_grid_height(lineGrid)) {
				break;
			}
			
			var currentLineDestY = (ds_grid_get(currentActiveLineGrid, lineGrid_colDisplayRow, i) - currentCenterDisplayRow) * gridSpaceVertical + (room_height / 2);
			ds_grid_set(currentActiveLineGrid, lineGrid_colPixelY, i, currentLineDestY);
		}
	}
}

	// Adjust the font size
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_subtract)
	or (keyboard_check(vk_control) and keyboard_check_direct(189)) and canPressPlus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
		}
		else {
			gridSpaceHorizontal -= 20;
		}
		canPressPlus = false;
		alarm[3] = 15;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_add)
	or (keyboard_check(vk_control) and keyboard_check_direct(187)) and canPressMinus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}
		}
		else {
			gridSpaceHorizontal += 20;
		}
		canPressMinus = false;
		alarm[4] = 15;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_numpad0)
	or keyboard_check(vk_control) and keyboard_check_pressed(ord("0"))) {
		gridSpaceHorizontal = 100;
	}

	if (keyboard_check_pressed(vk_right) and not keyboard_check(vk_control)) {
		wordLeftMarginDest -= gridSpaceHorizontal;
	}
	if (keyboard_check_pressed(vk_right) and keyboard_check(vk_control)
	or keyboard_check_pressed(vk_end)) {
		scr_jumpToEnd(false);
	}
	
	if (keyboard_check_pressed(ord("Y")) and keyboard_check(vk_control)) {
		scr_createPlaceChains();
	}

	if (keyboard_check_pressed(vk_left) and not keyboard_check(vk_control)) {
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
	
	if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("D"))) {
		showDevVars = !showDevVars;
	}
	
	
	// replace word
	if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("X"))) {
		if (hoverWordID > -1 and hoverWordID < ds_grid_height(wordGrid)) {
			scr_replaceWord(hoverWordID);
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


if (shortcutsEnabled) {
	if (keyboard_check(vk_shift) and !keyboard_check(vk_control)) {
		if (keyboard_check_direct(187) and canPressPlus) {
			canPressPlus = false;
			gridSpaceVertical += 10;
			alarm[3] = 15;
		}

		if (keyboard_check_direct(189) and canPressMinus) {
			canPressMinus = false;
			gridSpaceVertical -= 10;
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
mouseoverPanelPane = false;
for (var i = 0; i < instance_number(obj_panelPane); i++) {
	var panelPaneInst = instance_find(obj_panelPane, i);
	if (point_in_rectangle(mouse_x, mouse_y, panelPaneInst.x, panelPaneInst.y, panelPaneInst.x + panelPaneInst.windowWidth, panelPaneInst.y + panelPaneInst.windowHeight)) {
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
	newWordHoverUnitID = -1;
	newWordHoverWordSeq = -1;
	newWordHoverWordID = -1;
}


if (instance_exists(obj_dropDown)) {
	ableToCreateDropDown = false;
}
if (not instance_exists(obj_dropDown) and not ableToCreateDropDownAlarmSet) {
	alarm[0] = 2;
	ableToCreateDropDownAlarmSet = true;
}

scr_fontSizeControl();