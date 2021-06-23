 function scr_fillTokenImportGrid() {
	show_debug_message("scr_fillTokenImportGrid(), STARTING..." + scr_printTime());

	// fill tokenImport with UnitID, WordID, token, and transcript information
	var tokenImportGridHeight = ds_grid_height(obj_control.wordGrid);
	global.tokenImportGridWidth = 4;
	global.unitImportGridWidth = 2;
	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, tokenImportGridHeight);

	for (var i = 0; i < tokenImportGridHeight; i++) {
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, i);
		var currentWordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, i);
		var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
		var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
	
		ds_grid_set(global.tokenImportGrid, global.tokenImport_colUnitID, i, currentUnitID);
		ds_grid_set(global.tokenImportGrid, global.tokenImport_colTokenID, i, currentWordID);
		ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordToken, i, currentWordToken);
		ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordTranscript, i, currentWordTranscript);
	
	}

	// fill unitImport with UnitID information
	var unitGridHeight = ds_grid_height(obj_control.unitGrid);
	ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, unitGridHeight);

	var prevParticipant = "";
	for (var i = 0; i < unitGridHeight; i++) {
		//set unit ID
		var currentUnitID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitID, i);

		ds_grid_set(global.unitImportGrid, global.unitImport_colUnitID, i, currentUnitID);

		// if a new speaker has not been specified since previous speaker, set the speaker to be same as previous
		var currentParticipant = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, i));
		if (currentParticipant == "undefined" || string_length(currentParticipant) < 1 || scr_isStrOnlyWhitespace(currentParticipant)) {
			currentParticipant = prevParticipant;
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, i, currentParticipant);
		}
		else {
			prevParticipant = currentParticipant;
		}

		ds_grid_set(global.unitImportGrid, global.unitImport_colParticipant, i, currentParticipant);
	}






	// check if transcript info is available in wordGrid
	with (obj_control) {
		transcriptAvailable = false;
		var wordGridHeight = ds_grid_height(obj_control.wordGrid);
		for (var i = 0; i < wordGridHeight; i++) {
			if (ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i) != 0) {
				transcriptAvailable = true;
				break;
			}
		}
	}


	if (ds_list_size(global.tokenImportColNameList) < 4) {
		ds_list_add(global.tokenImportColNameList, "~UnitID", "~TokenID", "~text", "~transcript");
	}
	if (ds_list_size(global.unitImportColNameList) < 2) {
		ds_list_add(global.unitImportColNameList, "~UnitID", "~Participant");
	}



	scr_fillCustomLabelGrid();


	// check how many token level markers and unit level markers there are
	var customLabelGridHeight = ds_grid_height(global.customLabelGrid);
	var tokenMarkers = 0;
	var unitMarkers = 0;
	var discoMarkers = 0;
	for (var i = 0; i < customLabelGridHeight; i++) {
		var currentLevel = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLevel, i);
		if (currentLevel == global.levelToken) {
			tokenMarkers++;
		}
		else if (currentLevel == global.levelUnit) {
			unitMarkers++;
		}
		else if (currentLevel == global.levelDiscourse) {
			discoMarkers++;
		}
	}
	

	// grow tokenImportGrid and unitImportGrid to have the correct amount of columns
	global.tokenImportGridWidth = 4 + tokenMarkers;
	global.unitImportGridWidth = 2 + unitMarkers;
	global.discoImportGridWidth = discoMarkers;
	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(global.tokenImportGrid));
	ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, ds_grid_height(global.unitImportGrid));
	ds_grid_resize(global.discoImportGrid, global.discoImportGridWidth, 1);
	with (obj_gridViewer) {
		alarm[2] = 1;
	}

	var currentTokenImportCol = 4;
	var currentUnitImportCol = 2;
	var currentDiscoImportCol = 0;

	// actually fill in all the cells of tokenImportGrid and unitImportGrid
	for (var i = 0; i < customLabelGridHeight; i++) {

		var importGridCol = -1;
		var currentMarker = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colMarker, i);
		var currentLevel = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLevel, i);

		if (string(currentMarker) == "0" or is_undefined(currentMarker)) {
			continue;
		}
	
		// add the name of this marker to one of our lists
		if (currentLevel == global.levelToken) {
			ds_list_add(global.tokenImportColNameList, string_copy(currentMarker, 1, string_length(currentMarker)));
		}
		else if (currentLevel == global.levelUnit) {
			ds_list_add(global.unitImportColNameList, string_copy(currentMarker, 1, string_length(currentMarker)));
		}
		else if (currentLevel == global.levelDiscourse) {
			ds_list_add(global.discoImportColNameList, string_copy(currentMarker, 1, string_length(currentMarker)));
		}
	
		// find this marker's column in the importGrid
		var importGridCol = ds_list_find_index(global.importGridColNameList, currentMarker);
		if (importGridCol >= 0) {
		
			// if this marker is token level, fill in tokenImportGrid
			// if this marker is unit level, fill in unitImportGrid
			if (currentLevel == global.levelToken) {
			
				var tokenList = ds_list_create();
		
				var importGridHeight = ds_grid_height(global.importGrid);
				for (var j = 0; j < importGridHeight; j++) {
			
					var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
					var currentLineTokenList = scr_splitStringImport(currentLine, " ");
					var currentLineTokenListSize = ds_list_size(currentLineTokenList);

				
					for (var k = 0; k < currentLineTokenListSize; k++) {
						ds_list_add(tokenList, ds_list_find_value(currentLineTokenList, k));
					}
					ds_list_destroy(currentLineTokenList);
				}
		
				var tokenImportGridHeight = ds_grid_height(global.tokenImportGrid);
				for (var j = 0; j < tokenImportGridHeight; j++) {
				
					var currentToken = ds_list_find_value(tokenList, j);
					ds_grid_set(global.tokenImportGrid, currentTokenImportCol, j, currentToken);
				}
				currentTokenImportCol++;
			
			}
			else if (currentLevel == global.levelUnit) {
			
				var importGridHeight = ds_grid_height(global.importGrid);
				for (var j = 0; j < importGridHeight; j++) {
					var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
					ds_grid_set(global.unitImportGrid, currentUnitImportCol, j, currentLine);
				}
				currentUnitImportCol++;
			
			}
			else if(currentLevel == global.levelDiscourse){
			
				var unitCounter = 0;
				//hardcoded till multiple discourses
				var importGridHeight = 1;
				for (var j = 0; j < importGridHeight; j++) {

					var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
					ds_grid_set(global.discoImportGrid, currentDiscoImportCol, unitCounter, currentLine);

				}
				currentDiscoImportCol++;
			
		
			}
		}
	}

	show_debug_message("scr_fillTokenImportGrid(), ENDING..." + scr_printTime());


}
