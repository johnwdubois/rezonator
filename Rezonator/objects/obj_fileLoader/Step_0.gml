/*
	obj_fileLoader: Step
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Load words in XML doc into Rez as fast as possible
	
	Mechanism: Speed up or slow down the calling of functions depending on the FPS
	
	Author: Terry DuBois
*/

fileLoadRate = ceil(fps);

if (not inititalAutosave) {
	if (ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount and ds_grid_height(obj_control.unitGrid) > 0) {
		if (!file_exists(global.fileSaveName)) {
			alarm[1] = 1;
			inititalAutosave = true;
			ds_grid_copy(obj_control.lineGridBackup, obj_control.lineGrid);
		}
		else {
			alarm[1] = 36000;
			inititalAutosave = true;
		}
	}
}

var loadCSVRate = fileLoadRate / 8;
if (fps < 50) {
	loadCSVRate = 5;
	if (fps < 40) {
		loadCSVRate = 4;
		if (fps < 30) {
			loadCSVRate = 3;
		}
	}
}






