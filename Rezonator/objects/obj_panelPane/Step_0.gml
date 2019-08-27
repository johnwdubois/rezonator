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
		break;
	case functionSort:
		if not (functionSort_initialSort) {
			if (ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
				
				var minUnitStart = ds_grid_get_min(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, 0, obj_control.lineGrid_colUnitStart, ds_grid_height(obj_control.lineGrid));
				var maxUnitStart = ds_grid_get_max(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, 0, obj_control.lineGrid_colUnitStart, ds_grid_height(obj_control.lineGrid));
				if (minUnitStart == maxUnitStart) {
					var sortGridLineGrid = ds_grid_get(functionSort_gridGrid, functionSort_gridGrid_colSortGrid, 0);
					ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colCol, 1, obj_control.lineGrid_colUnitID);
				}
				
				functionSort_initialSort = true;
				functionSort_performSort = true;
				scr_setSpeakerLabelColWidth();
				
				with(obj_fileLoader){
					alarm[3] = 3;
				}
			}
		}
		break;
	case functionAudio:
		break;
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
else {
	holdDown = 0;
}

if (keyboard_check(vk_up)) {
	holdUp++;	
}
else {
	holdUp = 0;
}

if (keyboard_check_pressed(ord("N")) and keyboard_check(vk_control)) {
	showNav = not showNav;	
}