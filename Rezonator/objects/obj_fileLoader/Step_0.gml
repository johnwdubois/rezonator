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
		if (!file_exists_ns(global.fileSaveName)) {
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


if (loadingCSV) {
	
	/*
	//for (var i = 0; i < loadCSVRate; i++) {
	if (importCSVCurrentRow < ds_grid_height(obj_control.wordGrid)) {
		if (ds_grid_height(global.importCSVGrid) > 0 and importCSVCurrentRow < ds_grid_height(global.importCSVGrid)) {
			scr_loadNextElementCSV();
		}
	}
	//}
	
	if (loadLineGridSectionCounter >= 100) {
		scr_loadLineGridSection();
		loadLineGridSectionCounter = 0;
	}
	*/
	
}


// import special fields for unitImportGrid
if (!global.importedSpecialFields && ds_grid_height(global.unitImportGrid) > 0) {
	global.importedSpecialFields = true;
	
	var unitStartCol = ds_list_find_index(global.unitImportColNameList, global.unitImportUnitStartColName);
	var unitEndCol = ds_list_find_index(global.unitImportColNameList, global.unitImportUnitEndColName);
	
	var unitImportGridHeight = ds_grid_height(global.unitImportGrid);
	for (var i = 0; i < unitImportGridHeight; i++) {
		if (unitStartCol >= 0) {
			var currentUnitStart = ds_grid_get(global.unitImportGrid, unitStartCol, i);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, i, currentUnitStart);
		}
		if (unitEndCol >= 0) {
			var currentUnitEnd = ds_grid_get(global.unitImportGrid, unitEndCol, i);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, i, currentUnitEnd);
		}
	}
}



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
	currentDiscoColor = ds_list_find_value(global.discoColorList, clamp(0, ds_list_size(global.discoColorList) - 1, indexInDiscoColorList));

	currentElement = ds_list_find_value(fileLineRipList, fileLineRipListElement);
	scr_loadNextElement();


	if (fileLineRipListElement < ds_list_size(fileLineRipList) - 1) {
		fileLineRipListElement++;
	}
	else {
		fileLineRipListElement = 0;
		discourseProcessing++;
		
		if (indexInDiscoColorList < ds_list_size(global.discoColorList) - 1) {
			indexInDiscoColorList++;
		}
		else {
			indexInDiscoColorList = 0;
		}
	}
}

