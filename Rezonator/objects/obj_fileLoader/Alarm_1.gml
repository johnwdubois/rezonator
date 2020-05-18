///@description Autosave
/*
	obj_fileLoader: Alarm 1
	
	Last Updated: 2019-02-26
	
	Called from: itself (looping alarm)
	
	Purpose: Auto-save Rezonator
	
	Mechanism: Call saveRez();
	
	Author: Terry DuBois
*/

// if this is the first autosave, we will update the tokenImport and unitImport
if (ds_grid_height(global.tokenImportGrid) < ds_grid_height(obj_control.wordGrid)) {
	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(obj_control.wordGrid));
	ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, ds_grid_height(obj_control.unitGrid));
	scr_fillTokenImportGrid();
}

alarm[1] = 36000;

scr_saveREZ(true);