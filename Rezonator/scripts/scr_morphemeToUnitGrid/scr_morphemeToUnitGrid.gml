var currentWordIDList = ds_list_create();
var previousParticipant = "";
var participantCount = -1;

for (var i = 0; i < ds_grid_height(obj_control.morphemeGrid); i++) {
	var currentUnitID = ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitID, i);
	var newUnit = false;
	if (i == ds_grid_height(obj_control.morphemeGrid) - 1
	or currentUnitID != ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitID, i + 1)) {
		newUnit = true;
	}
	var currentWordID = ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid_colWordID, i);
	ds_list_add(currentWordIDList, currentWordID);
	
	var currentParticipant = ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid_colParticipant, i);
	if (currentParticipant != previousParticipant) {
		previousParticipant = currentParticipant;
		participantCount++;
	}
	
	var currentUnitStart = ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitStart, i);
	var currentUnitEnd = ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitEnd, i);
	
	if (newUnit) {
		var currentWordIDListNewUnit = ds_list_create();
		ds_list_copy(currentWordIDListNewUnit, currentWordIDList);
		ds_list_clear(currentWordIDList);
		
		ds_grid_resize(obj_control.unitGrid, global.unitGridWidth, ds_grid_height(obj_control.unitGrid) + 1);
		var currentRowUnitGrid = ds_grid_height(obj_control.unitGrid) - 1;
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitID, currentRowUnitGrid, currentUnitID);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, currentRowUnitGrid, currentUnitID);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentRowUnitGrid, currentWordIDListNewUnit);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, currentRowUnitGrid, 0);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colpID, currentRowUnitGrid, participantCount);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentRowUnitGrid, currentParticipant);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentRowUnitGrid, currentUnitStart);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentRowUnitGrid, currentUnitEnd);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentRowUnitGrid,  make_color_rgb(58, 191, 240));
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, currentRowUnitGrid, 0);
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colDiscoColor, currentRowUnitGrid, c_ltgray);
		
		// add new rows to wordGrid and dynamicWordGrid
		for (var j = 0; j < ds_list_size(currentWordIDListNewUnit); j++) {
			var currentWordIDNewWord = ds_list_find_value(currentWordIDListNewUnit, j);
			var currentMph = ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid_colMph, currentWordIDNewWord - 1);
			
			ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
			var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;
			
			ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, currentWordIDNewWord);
			ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
			ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, currentRowWordGrid, currentUnitID);
			ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, j);
			ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, currentMph);
			ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, currentMph);
			
			scr_loadDynamicWordGridIndividual(currentRowWordGrid);
		}
		
		// add row to lineGrid
		var currentLineY = currentUnitID * obj_control.gridSpaceVertical;
		
		ds_grid_resize(obj_control.lineGrid, obj_control.lineGridWidth, ds_grid_height(obj_control.lineGrid) + 1);
		var currentRowLineGrid = ds_grid_height(obj_control.lineGrid) - 1;
		
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, currentRowLineGrid, currentRowLineGrid);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, currentRowLineGrid, currentWordIDListNewUnit);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, currentRowLineGrid, 0);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitID, currentRowLineGrid, currentUnitID);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, currentRowLineGrid, currentLineY);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, currentRowLineGrid, currentLineY);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDiscoID, currentRowLineGrid, 0);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, currentRowLineGrid, currentUnitID);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colAlignedWordID, currentRowLineGrid, ds_list_find_value(currentWordIDListNewUnit, 0));
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, currentRowLineGrid, currentUnitStart);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitEnd, currentRowLineGrid, currentUnitEnd);
	
	
		// add row to unitInStackGrid
		var unitInStackGridCurrentRow = ds_grid_height(obj_chain.unitInStackGrid);
		ds_grid_resize(obj_chain.unitInStackGrid, obj_chain.unitInStackGridWidth, unitInStackGridCurrentRow + 1);
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colUnitID, unitInStackGridCurrentRow, currentUnitID);
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitInStackGridCurrentRow, -1);
	}	
}

ds_list_destroy(currentWordIDList);