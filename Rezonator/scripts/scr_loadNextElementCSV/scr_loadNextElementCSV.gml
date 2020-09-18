function scr_loadNextElementCSV() {
	/*
		scr_loadNextElementCSV();
	
		Last Updated: 2020-01-01
	
		Called from: obj_fileLoader
	
		Purpose: Load elements of data from a CSV file into the Unit/Word/Line grid
	
		Mechanism: Retrieve elements of data depending on the global.importCSVGrid. Once all elements of a line
		are retieved, load them into a new line of the grids.
	
		Author: Terry DuBois
	*/

	var currentUID = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUID, importCSVCurrentRow);
	if (string_digits(currentUID) == "") {
		with (obj_alarm) {
			alarm[4] = 0;
		}
	}
	if ((string_length(string_letters(currentUID)) > 0 and importCSVCurrentRow < 1 )) {
		importCSVCurrentRow++;
		exit;
	}
	currentUID = real(currentUID);

	unitIDCounter = max(unitIDCounter, 1);
	currentUnitID = max(currentUnitID, 1);
	wordIDCounter = max(wordIDCounter, 0);



	// new wordID
	wordIDCounter++;
	var currentWID = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colWID, importCSVCurrentRow);
	var currentPlace = real(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colPlace, importCSVCurrentRow));
	var currentWord = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colWord, importCSVCurrentRow);
	var currentText = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colText, importCSVCurrentRow);


	currentUtteranceID = currentUnitID;
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordIDCounter);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, currentRowWordGrid, currentUtteranceID);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, currentPlace);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, currentWord);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, currentText);

	scr_loadDynamicWordGridIndividualCSV(currentRowWordGrid);
	ds_list_add(importCSVWordIDList, wordIDCounter);






	if (currentUID != importCSVCurrentUID) {
	
		// new unit id
		importCSVCurrentUID = currentUID;
	
		currentUtteranceID = currentUnitID;
		currentDiscoID = string(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colDiscoID, importCSVCurrentRow));
		currentUnitpID = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colPID, importCSVCurrentRow);
		currentUnitParticipantName = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colSpeaker, importCSVCurrentRow);
		currentUnitStart = real(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUnitStart, importCSVCurrentRow));
		currentUnitEnd = real(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUnitEnd, importCSVCurrentRow));
	
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitID, currentRowUnitGrid, currentUnitID);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, currentRowUnitGrid, currentUtteranceID);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, currentRowUnitGrid, currentDiscoID);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colpID, currentRowUnitGrid, currentUnitpID);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentRowUnitGrid, currentUnitParticipantName);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentRowUnitGrid, currentUnitStart);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentRowUnitGrid, currentUnitEnd);
	
		var currentUnitWordIDList = ds_list_create();
		ds_list_copy(currentUnitWordIDList, importCSVWordIDList);
		ds_list_clear(importCSVWordIDList);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentRowUnitGrid, currentUnitWordIDList);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentRowUnitGrid, c_gray);
	
	
		currentRowUnitGrid++;
		unitIDCounter++;
		currentUnitID = unitIDCounter;
	
		loadLineGridSectionCounter++;
	}


	currentRowWordGrid++;
	importCSVCurrentRow++;


}
