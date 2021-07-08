function scr_fillTokenImportGridCoNLLU() {
	// fill tokenImport with UnitID, WordID, token, and transcript information




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
	var discoMarkers =0;
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
	
	
	var displayTokenRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "Display Token");
	var displayTokenMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
	var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
		

	var transcriptMarkerStr = "";
	if(global.tokenImportTranscriptColName != "" or global.tokenImportTranscriptColName != undefined){
		transcriptMarkerStr = global.tokenImportTranscriptColName
	}
	var importGrid_colTranscript = ds_list_find_index(global.importGridColNameList, transcriptMarkerStr);
	
	var displayUnitRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Speaker");
	var displayUnitMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayUnitRow);
	var importGrid_colDisplayUnit = ds_list_find_index(global.importGridColNameList, displayUnitMarkerStr);
	
	
	
	

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

	var deliminaterCol = ds_list_find_index(global.importGridColNameList, global.unitDelimField);
	var curUID = 0;
	var prevUID = 0;
	var unitCounter = 0;



	// fill tokenImport with UnitID, WordID, token, and transcript information
	var tokenImportGridHeight = ds_grid_height(global.importGrid);
	for (var i = 0; i < tokenImportGridHeight; i++) {
	
		if(i > 0){
			curUID = ds_grid_get(global.importGrid, deliminaterCol, i);	
		}
		else if (i == 0) {
			prevUID = ds_grid_get(global.importGrid, deliminaterCol, i);
		}
	
		var delimTag = ds_grid_get(global.importGrid, deliminaterCol, i);
		if (delimTag != 0 && string(prevUID) != string(curUID)) {
		
			var participantName = ds_grid_get(global.importGrid, importGrid_colDisplayUnit, i);
			ds_grid_set(global.unitImportGrid, global.unitImport_colUnitID, unitCounter, unitCounter+1);
			ds_grid_set(global.unitImportGrid, global.unitImport_colParticipant, unitCounter, participantName);
			unitCounter++;
			prevUID = curUID;
		}			
	
		var currentUnitID = unitCounter;
		var currentWordID = i+1

		var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
		var currentWordToken = ds_grid_get(global.importGrid, importGrid_colDisplayToken, i);
		
		var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
		var currentWordTranscript = "";
		if(importGrid_colTranscript){
			currentWordTranscript = ds_grid_get(global.importGrid, importGrid_colTranscript, i);
		}
		if(currentWordToken != undefined){
	
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colUnitID, i, currentUnitID);
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colTokenID, i, currentWordID);
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordToken, i, currentWordToken);
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordTranscript, i, currentWordTranscript);
	
		}
	}







	var currentTokenImportCol = 4;
	var currentUnitImportCol = 2;
	var currentDiscoImportCol = 0;

	// actually fill in all the cells of tokenImportGrid and unitImportGrid
	for (var i = 0; i < customLabelGridHeight; i++) {
		curUID = 0;
		prevUID = 0;
		unitCounter = 1;


		var importGridCol = -1;
		var currentMarker = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colMarker, i);
		var currentLevel = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLevel, i);

		if (string(currentMarker) == "0" or is_undefined(currentMarker)) {
			continue;
		}
	
		// add the name of this marker to one of our lists
		if (currentLevel == global.levelToken) {
			ds_list_add(global.tokenImportColNameList, string(currentMarker));
		}
		else if (currentLevel == global.levelUnit) {
			ds_list_add(global.unitImportColNameList, string(currentMarker));
		}
		else if (currentLevel == global.levelDiscourse) {
			ds_list_add(global.discoImportColNameList, string(currentMarker));
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
					var currentLineTokenList = scr_splitStringImport(currentLine, " ", false);
					var currentLineTokenListSize = ds_list_size(currentLineTokenList);

					if(currentLineTokenListSize == 0){
						currentLineTokenListSize = 1;
					}
					for (var k = 0; k < currentLineTokenListSize; k++) {
						if(ds_list_find_value(currentLineTokenList, k) == undefined){
							ds_list_add(currentLineTokenList, "");
						}
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
				
				
					// Iterate on unit counter when a new cluster is found
					if(j > 0){
						curUID = ds_grid_get(global.importGrid, deliminaterCol, j);	
					}
					else if (j == 0) {
						prevUID = ds_grid_get(global.importGrid, deliminaterCol, j);
						var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
						ds_grid_set(global.unitImportGrid, currentUnitImportCol, unitCounter-1, currentLine);
						unitCounter++;
					}
	
					if(curUID != 0 && string(prevUID) != string(curUID)){
						var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
						ds_grid_set(global.unitImportGrid, currentUnitImportCol, unitCounter-1, currentLine);
						unitCounter++;
						prevUID = curUID;
					}			

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


}
