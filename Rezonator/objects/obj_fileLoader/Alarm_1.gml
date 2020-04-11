///@description Autosave
/*
	obj_fileLoader: Alarm 1
	
	Last Updated: 2019-02-26
	
	Called from: itself (looping alarm)
	
	Purpose: Auto-save Rezonator
	
	Mechanism: Call saveRez();
	
	Author: Terry DuBois
*/

if (ds_grid_height(global.labelWordGrid) < ds_grid_height(obj_control.wordGrid)) {
	ds_grid_resize(global.labelWordGrid, global.labelWordGridWidth, ds_grid_height(obj_control.wordGrid));
	scr_fillLabelWordGrid();
	
}

alarm[1] = 36000;

scr_saveREZ(true);