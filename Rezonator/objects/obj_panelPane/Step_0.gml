/*
	obj_control: Step
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Keep panel pane running smoothly
	
	Mechanism: Ensure correct funtion is being used, keep time for double clicks and scrolling
	
	Author: Terry DuBois
*/

switch (currentFunction) {
	case functionChainList:
		with (obj_panelPane) {
			functionChainList_currentTab = other.functionChainList_currentTab;
		}
	case functionSort:
		if not (functionSort_initialSort) {
			if (ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
				functionSort_initialSort = true;
				functionSort_performSort = true;
				scr_setSpeakerLabelColWidth();
			}
		}
	default:
		break;
}

if (doubleClickTimer > -1) {
	if (doubleClickTimer < 20) {
		doubleClickTimer++;
	}
	else {
		doubleClickTimer = -1;
	}
}

if (keyboard_check(vk_down)) {
	holdDown++;	
}
if(keyboard_check_released(vk_down)) {
	holdDown = 0;
}
if (keyboard_check(vk_up)) {
	holdUp++;	
}
if(keyboard_check_released(vk_up)) {
	holdUp = 0;
}