/*
	scr_loadNextElementCSV();
	
	Last Updated: 2020-01-01
	
	Called from: obj_fileLoader
	
	Purpose: Load elements of data from a CSV file into the Unit/Word/Line grid
	
	Mechanism: Retrieve elements of data depending on the global.importCSVGrid. Once all elements of a line
	are retieved, load them into a new line of the grids.
	
	Author: Terry DuBois
*/

if (not obj_control.initialValidFileCheck) {
	//show_message("here");
	with (obj_alarm) {
		alarm[4] = 10;
	}
}
if (importCSVCurrentRow < 1) {
	var totalUnitAmount = 0;
	var currentUID = "";
	for (var i = 0; i < ds_grid_height(global.importCSVGrid); i++) {
		if (ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUID, i) != currentUID) {
			currentUID = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUID, i);
			totalUnitAmount++;
		}
	}
	global.totalUnitAmount = totalUnitAmount;
	//show_message("total unit amount: " + string(global.totalUnitAmount));
	
	
	//ds_grid_resize(obj_control.unitGrid, obj_control.unitGridWidth, global.totalUnitAmount);
	//currentRowUnitGrid = -1;
	
	//show_message("resizing wordGrid...");
	//ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(global.importCSVGrid));
	//currentRowWordGrid = -1;
}

var currentUID = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUID, importCSVCurrentRow);
if(string_digits(currentUID) == "") {
	with (obj_alarm) {
		alarm[4] = 0;
	}
}
if ((string_length(string_letters(currentUID)) > 0 and importCSVCurrentRow < 1 )) {
	importCSVCurrentRow++;
	exit;
}
currentUID = real(currentUID);

unitIDCounter = max(unitIDCounter, 0);
currentUnitID = max(currentUnitID, 0);
wordIDCounter = max(wordIDCounter, 0);



// new wordID
wordIDCounter++;
var currentWID = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colWID, importCSVCurrentRow);
var currentPlace = real(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colPlace, importCSVCurrentRow));
var currentWord = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colWord, importCSVCurrentRow);
var currentText = ds_grid_get(global.importCSVGrid, global.importCSVGrid_colText, importCSVCurrentRow);

ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;
//currentRowWordGrid++;

currentUtteranceID = currentUID;
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordIDCounter);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, currentRowWordGrid, currentUtteranceID);
//show_message(string(currentUtteranceID));
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, currentPlace);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, currentWord);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, currentText);

scr_loadDynamicWordGridIndividual(currentRowWordGrid);
ds_list_add(importCSVWordIDList, wordIDCounter);






if (currentUID != importCSVCurrentUID) {
	// new unit id
	
	importCSVCurrentUID = currentUID;
	
	ds_grid_resize(obj_control.unitGrid, obj_control.unitGridWidth, ds_grid_height(obj_control.unitGrid) + 1);
	var currentRowUnitGrid = ds_grid_height(obj_control.unitGrid) - 1;
	//currentRowUnitGrid++;
	
	unitIDCounter++;
	currentUnitID = unitIDCounter;
	
	currentUtteranceID = currentUID;
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
	
	
	
	
	// new row in lineGrid
	var currentLineY = room_height + obj_control.gridSpaceVertical;
		
	ds_grid_resize(obj_control.lineGrid, obj_control.lineGridWidth, ds_grid_height(obj_control.lineGrid) + 1);
	var currentRowLineGrid = ds_grid_height(obj_control.lineGrid) - 1;
		
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, currentRowLineGrid, currentRowLineGrid);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, currentRowLineGrid, currentUnitWordIDList);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, currentRowLineGrid, 0);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitID, currentRowLineGrid, currentUnitID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, currentRowLineGrid, currentLineY);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDiscoID, currentRowLineGrid, currentDiscoID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, currentRowLineGrid, currentUtteranceID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colAlignedWordID, currentRowLineGrid, ds_list_find_value(currentUnitWordIDList, 0));
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, currentRowLineGrid, currentUnitStart);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitEnd, currentRowLineGrid, currentUnitEnd);
	
	
	// add row to unitInStackGrid
	
	var unitInStackGridCurrentRow = ds_grid_height(obj_chain.unitInStackGrid);
	ds_grid_resize(obj_chain.unitInStackGrid, obj_chain.unitInStackGridWidth, unitInStackGridCurrentRow + 1);
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colUnitID, unitInStackGridCurrentRow, currentUnitID);
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitInStackGridCurrentRow, -1);
}

importCSVCurrentRow++;