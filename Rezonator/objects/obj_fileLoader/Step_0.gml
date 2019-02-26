/*
	obj_fileLoader: Step
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Load words in XML doc into Rez as fast as possible
	
	Mechanism: Speed up or slow down the calling of functions depending on the FPS
	
	Author: Terry DuBois
*/

fileLoadRate = ceil(fps);

for (var i = 0; i < fileLoadRate; i++) {
	if (discourseProcessing < 0 or discourseProcessing >= ds_grid_height(global.fileLineRipGrid)) {
		exit;
	}
	
	if (not instance_exists(obj_control)) {
		exit;
	}
	
	if (ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
		exit;
	}
	
	

	fileLineRipList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colFileLineRipList, discourseProcessing);
	currentDiscoID = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, discourseProcessing);






	currentElement = ds_list_find_value(fileLineRipList, fileLineRipListElement);
	scr_loadNextElement();


	if (fileLineRipListElement < ds_list_size(fileLineRipList) - 1) {
		fileLineRipListElement++;
	}
	else {
		fileLineRipListElement = 0;
		discourseProcessing++;
	}
}