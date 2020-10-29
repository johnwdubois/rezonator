function scr_fillTokenImportGridCSV() {
	show_debug_message("scr_fillTokenImportGridCSV(), STARTING..." + scr_printTime());

	// fill tokenImport with UnitID, WordID, token, and transcript information
	var tokenImportGridHeight = ds_grid_height(global.tokenImportGrid);
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

	show_debug_message("scr_fillTokenImportGridCSV(), FINISHED LOOP 1" + scr_printTime());

	// fill unitImport with UnitID information
	var unitImportGridHeight = ds_grid_height(global.unitImportGrid);
	var unitGridHeight = ds_grid_height(obj_control.unitGrid);
	ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, unitGridHeight);


	for (var i = 0; i < unitGridHeight; i++) {
		//set unit ID
		var currentUnitID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitID, i);

		ds_grid_set(global.unitImportGrid, global.unitImport_colUnitID, i, currentUnitID);
	

		var currentParticipant = ds_grid_get(obj_control.unitGrid,obj_control.unitGrid_colParticipantName,i);

		ds_grid_set(global.unitImportGrid, global.unitImport_colParticipant, i, currentParticipant);
	}

	show_debug_message("scr_fillTokenImportGridCSV(), FINISHED LOOP 2" + scr_printTime());






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

	// set custom label names for token and transcript columns
	if (ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, 3) != -1) {
		var labelName = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colTier, 3);
		ds_list_set(global.tokenImportColNameList, 2, labelName);
	}
	if (ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, 4) != -1) {
		var labelName = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colTier, 4);
		ds_list_set(global.tokenImportColNameList, 3, labelName);
	}

	show_debug_message("scr_fillCustomLabelGrid(), STARTING... " + scr_printTime());
	scr_fillCustomLabelGrid();
	show_debug_message("scr_fillCustomLabelGrid(), ENDING... " + scr_printTime());


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

	show_debug_message("scr_fillTokenImportGridCSV(), FINISHED LOOP 3" + scr_printTime());
	
	
		var displayTokenRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Display Token");
		var displayTokenMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
		var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
	
		var displayUnitRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Speaker");
		var displayUnitMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayUnitRow);
		var importGrid_colDisplayUnit = ds_list_find_index(global.importGridColNameList, displayUnitMarkerStr);
	
	
	
	

	// grow tokenImportGrid and unitImportGrid to have the correct amount of columns
	//show_message("ds_list_size(global.tokenImportColNameList): " + string(ds_list_size(global.tokenImportColNameList)) +
	//"global.tokenImportColNameList: " + scr_getStringOfList(global.tokenImportColNameList) + ", 4 + tokenMarkers = " + string(4 + tokenMarkers));
	if (ds_list_size(global.tokenImportColNameList) == 4 + tokenMarkers) {
		global.tokenImportGridWidth = ds_list_size(global.tokenImportColNameList);
	}
	else {
		global.tokenImportGridWidth = 4 + tokenMarkers;
	}
	global.unitImportGridWidth = 2 + unitMarkers;
	global.discoImportGridWidth = discoMarkers;
	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(global.tokenImportGrid));
	ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, ds_grid_height(global.unitImportGrid));
	ds_grid_resize(global.discoImportGrid, global.discoImportGridWidth, 1);
	with (obj_gridViewer) {
		alarm[2] = 1;
	}

	//show_message("global.tokenImportGridWidth: " + string(ds_grid_width(global.tokenImportGrid)));

	var deliminaterCol = ds_list_find_index(global.importGridColNameList, global.unitImportUnitDelimColName);




	var displayTokenRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Display Token");
	var displayTokenMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);



	// fill tokenImport with UnitID, WordID, token, and transcript information
	var prevUnitID = -1;
	var unitCounter = 0;
	var tokenImportGridHeight = ds_grid_height(obj_control.morphGrid);
	for (var i = 0; i < tokenImportGridHeight; i++) {
	
		if (i > 0) {
			currentUnitID = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colUnitID, i);	
		}
		else if (i == 0) {
			prevUnitID = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colUnitID, i);
		}
	
		//hardcoded till ui is built
		var currentUnitID = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colUnitID , i);
		var currentWordID = i+1
	
		if (prevUnitID != currentUnitID) {
			ds_grid_set(global.unitImportGrid, global.unitImport_colUnitID, unitCounter, unitCounter + 1);
			var particiantName = ds_grid_get(global.importGrid, importGrid_colDisplayUnit, i);
			ds_grid_set(global.unitImportGrid, global.unitImport_colParticipant, unitCounter, particiantName);
		
			unitCounter++;
			prevUnitID = unitCounter;
		}

		var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
		var currentWordToken = ds_grid_get(global.importGrid, importGrid_colDisplayToken, i);
		var currentWordTranscript = "";

		if(currentWordToken != undefined){
	
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colUnitID, i, currentUnitID);
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colTokenID, i, currentWordID);
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordToken, i, currentWordToken);
			ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordTranscript, i, currentWordTranscript);
	
		}
	}

	show_debug_message("scr_fillTokenImportGridCSV(), FINISHED LOOP 4" + scr_printTime());



	var currentTokenImportCol = 4;
	var currentUnitImportCol = 2;
	var currentDiscoImportCol = 0;

	// actually fill in all the cells of tokenImportGrid and unitImportGrid
	for (var i = 0; i < customLabelGridHeight; i++) {
	
		show_debug_message("scr_fillTokenImportGridCSV(), LOOP 5, i: " + string(i) + ", customLabelGridHeight: " + string(customLabelGridHeight) + "..." + scr_printTime());

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
					var currentLineTokenList = scr_splitStringImport(currentLine);
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

				var unitCounter = 0;
				var importGridHeight = ds_grid_height(global.importGrid);
				for (var j = 0; j < importGridHeight; j++) {
				
					if(j > 0){
						var prevUID = ds_grid_get(global.importGrid, deliminaterCol, j-1);
						var curUID = ds_grid_get(global.importGrid, deliminaterCol, j);	
					}
	
					if( j == 0 || prevUID != curUID){
						var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
						ds_grid_set(global.unitImportGrid, currentUnitImportCol, unitCounter, currentLine);
						unitCounter ++;
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

	show_debug_message("scr_fillTokenImportGridCSV(), FINISHED LOOP 5" + scr_printTime());
	show_debug_message("scr_fillTokenImportGridCSV(), ENDING..." + scr_printTime());


}
