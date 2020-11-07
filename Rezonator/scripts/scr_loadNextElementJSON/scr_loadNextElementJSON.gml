/*
	scr_loadNextElementJSON(currentElement);
	
	Last Updated: 2020-01-01
	
	Called from: obj_fileLoader
	
	Purpose: Load elements of data from a JSON file, presumably a REZ file, into the Unit/Word/Line grid
	
	Mechanism: Retrieve elements of data depending on the element's header string. Once all elements of a line
	are retieved, load them into a new line of the grids.
	
	Author: Terry DuBois
*/
function scr_loadNextElementJSON(currentElement) {
	
	var wordList = scr_getJSONWordsList(currentElement);



	unitIDCounter++;
	currentUnitID = unitIDCounter;
			
		
	ds_grid_resize(obj_control.unitGrid, obj_control.unitGridWidth, ds_grid_height(obj_control.unitGrid) + 1);
	var currentRowUnitGrid = ds_grid_height(obj_control.unitGrid) - 1;
		
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitID, currentRowUnitGrid, currentUnitID);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, currentRowUnitGrid, max(currentUtteranceID, 1));
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, currentRowUnitGrid, currentDiscoID);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colpID, currentRowUnitGrid, currentUnitpID);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentRowUnitGrid, currentUnitParticipantName);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentRowUnitGrid, currentUnitStart);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentRowUnitGrid, currentUnitEnd);

	if (ds_list_find_index(obj_control.participantList, currentUnitpID) == -1) {
		ds_list_add(participantsInCurrentDiscoList, currentUnitpID);
		ds_list_add(obj_control.participantList, currentUnitpID);
		var participantColor = ds_list_find_value(global.participantColorList, ds_list_size(obj_control.participantList) - 1);
		ds_list_add(obj_control.participantColorList, participantColor);
		
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentRowUnitGrid, participantColor);
	}
	else {
		var colorIndex = ds_list_find_index(obj_control.participantList, currentUnitpID);
		var participantColor = ds_list_find_value(obj_control.participantColorList, colorIndex);
		
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentRowUnitGrid, participantColor);
	}






	var lineGridWordIDList = ds_list_create();

	var wordListSize = ds_list_size(wordList);
	for (var i = 0; i < wordListSize; i++) {
	
		wordIDCounter++;
		var wordToken = ds_list_find_value(wordList, i);
		var wordTranscript = wordToken;
	
		ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
		var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;
			
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordIDCounter);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, currentRowWordGrid, currentUtteranceID);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, i);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, wordToken);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, wordTranscript);
	
		ds_list_add(lineGridWordIDList, wordIDCounter);
		scr_loadDynamicWordGridIndividual(ds_grid_height(obj_control.wordGrid) - 1);
	}





	var currentLineY = currentUnitID * obj_control.gridSpaceVertical;
		
	ds_grid_resize(obj_control.lineGrid, obj_control.lineGridWidth, ds_grid_height(obj_control.lineGrid) + 1);
	var currentRowLineGrid = ds_grid_height(obj_control.lineGrid) - 1;
		
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, currentRowLineGrid, currentRowLineGrid);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, currentRowLineGrid, lineGridWordIDList);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, currentRowLineGrid, 0);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitID, currentRowLineGrid, currentUnitID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, currentRowLineGrid, currentLineY);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, currentRowLineGrid, currentLineY);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDiscoID, currentRowLineGrid, currentDiscoID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, currentRowLineGrid, max(currentUtteranceID, 1));
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colAlignedWordID, currentRowLineGrid, ds_list_find_value(lineGridWordIDList, 0));
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, currentRowLineGrid, currentUnitStart);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitEnd, currentRowLineGrid, currentUnitEnd);
			
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentRowUnitGrid, lineGridWordIDList);

	// add row to unitInStackGrid
	
	var unitInStackGridCurrentRow = ds_grid_height(obj_chain.unitInStackGrid);
	ds_grid_resize(obj_chain.unitInStackGrid, obj_chain.unitInStackGridWidth, unitInStackGridCurrentRow + 1);
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colUnitID, unitInStackGridCurrentRow, currentUnitID);
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitInStackGridCurrentRow, -1);
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, unitInStackGridCurrentRow, -1);


}
