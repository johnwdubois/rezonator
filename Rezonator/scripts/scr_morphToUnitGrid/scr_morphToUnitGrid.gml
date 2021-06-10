function scr_morphToUnitGrid() {
	
	show_debug_message("scr_morphToUnitGrid() START ... " + scr_printTime());
	
	var currentWordIDList = ds_list_create();
	var participantList = ds_list_create();


	var prevParticipant = "";
	var morphGridHeight = ds_grid_height(obj_control.morphGrid);
	for (var i = 0; i < morphGridHeight; i++) {
	
		var currentParticipant = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colParticipant, i);
		if (string_length(currentParticipant) < 1 && string_length(prevParticipant) > 0) {
			currentParticipant = prevParticipant;
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, i, currentParticipant);
		}
		
		var currentParticipantID = ds_list_find_index(participantList, currentParticipant);
		if (currentParticipantID == -1) {
			ds_list_add(participantList, currentParticipant)
			currentParticipantID = ds_list_size(participantList) - 1;
		}
		
		prevParticipant = currentParticipant;
	}

	var participantColorList = ds_list_create();
	var participantListSize = ds_list_size(participantList);
	for (var i = 0; i < participantListSize; i++) {
		var hue = (255 / ds_list_size(participantList) * i);
		var color = make_color_hsv(hue, random_range(150, 200),  random_range(150, 200));
		ds_list_add(participantColorList, color);
	}

	ds_grid_resize(obj_control.wordGrid, ds_grid_width(obj_control.wordGrid), 0);
	ds_grid_resize(obj_control.dynamicWordGrid, ds_grid_width(obj_control.dynamicWordGrid), 0);

	for (var i = 0; i < morphGridHeight; i++) {
		var currentUnitID = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colUnitID, i);
		var newUnit = false;
		if (i == morphGridHeight - 1
		or currentUnitID != ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colUnitID, i + 1)) {
			newUnit = true;
		}
		var currentWordID = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colWordID, i);
		ds_list_add(currentWordIDList, currentWordID);

	
		var currentParticipant = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colParticipant, i);
		var currentParticipantID = ds_list_find_index(participantList, currentParticipant);
		var currentParticipantColor = ds_list_find_value(participantColorList, clamp(currentParticipantID, 0, ds_list_size(participantColorList) - 1));
	
		var currentUnitStart = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colUnitStart, i);
		var currentUnitEnd = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colUnitEnd, i);
	
		if (newUnit) {
			var currentWordIDListNewUnit = ds_list_create();
			ds_list_copy(currentWordIDListNewUnit, currentWordIDList);
			ds_list_clear(currentWordIDList);
			//show_message(scr_getStringOfList(currentWordIDListNewUnit));
		
		
			ds_grid_resize(obj_control.unitGrid, global.unitGridWidth, ds_grid_height(obj_control.unitGrid) + 1);
			var currentRowUnitGrid = ds_grid_height(obj_control.unitGrid) - 1;
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitID, currentRowUnitGrid, currentUnitID);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, currentRowUnitGrid, currentUnitID);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentRowUnitGrid, currentWordIDListNewUnit);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, currentRowUnitGrid, 0);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colpID, currentRowUnitGrid, currentParticipantID);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentRowUnitGrid, currentParticipant);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentRowUnitGrid, currentUnitStart);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentRowUnitGrid, currentUnitEnd);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentRowUnitGrid, currentParticipantColor);
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colDiscoColor, currentRowUnitGrid, c_ltgray);
		
			// add new rows to wordGrid and dynamicWordGrid
			var currentWordIDListNewUnitSize = ds_list_size(currentWordIDListNewUnit);
			for (var j = 0; j < currentWordIDListNewUnitSize; j++) {
				var currentWordIDNewWord = ds_list_find_value(currentWordIDListNewUnit, j);
				//show_message(string(currentWordIDNewWord ))
				var currentMorph = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colMorph, currentWordIDNewWord - 1);
				var currentGloss = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid_colGloss, currentWordIDNewWord - 1);
			
				//show_message(string(currentMorph));
				
				ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
				var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;
			
				ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, currentWordIDNewWord);
				ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWID, currentRowWordGrid, currentWordIDNewWord);
				ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
				ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, currentRowWordGrid, currentUnitID);
				ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, j);
				ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, currentMorph);
				ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, currentGloss);
			
				//scr_loadDynamicWordGridIndividual(currentRowWordGrid);
				
			}
	
	
		}	
	}



	ds_list_copy(obj_control.participantList, participantList);
	ds_list_destroy(participantList);
	ds_list_destroy(currentWordIDList);
	
	show_debug_message("scr_morphToUnitGrid() END ... " + scr_printTime());


}
