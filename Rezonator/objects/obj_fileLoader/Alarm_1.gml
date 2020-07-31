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
	
	if(global.importType == global.importType_Default){
		scr_fillTokenImportGrid();
	}
	else if(global.importType == global.importType_CSV){
		scr_fillTokenImportGridCSV();
	}
	else if(global.importType == global.importType_CoNLLU){
		scr_fillTokenImportGridCoNLLU();
	}
	
	if(!obj_control.updatedSpeakerLabel){

	with(obj_alarm){
			alarm[7] = 2;
	}
	obj_control.updatedSpeakerLabel = true;
}
}

alarm[1] = 36000;

scr_saveREZ(true);