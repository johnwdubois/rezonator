if (ds_grid_height(global.importGrid) < 1) {
	exit;
}

if (global.plainText) {
	
	
	//ds_grid_set(obj_importMapping.plainTextInfoGrid, obj_importMapping.plainTextInfoGrid_colText, j, currentExample);
		
	//ds_grid_set(obj_importMapping.plainTextInfoGrid, obj_importMapping.plainTextInfoGrid_colGroup, j, currentExample);
	// get importGrid columns
	var unitCounter = 0;
	//var participantCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 3);
	var morphCol = global.plainTextInfoGrid_colText;
	
	/*
	if (typeof(glossCol) != "number") {
		glossCol = -1;
	}
	*/

	// build morphGrid!
	var plainTextInfoGridHeight = ds_grid_height(global.plainTextInfoGrid);
	for (var i = 0; i < plainTextInfoGridHeight; i++) {
	
		var currentParticipant = string(global.givenSpeaker);
		var currentMorphFullStr = string(ds_grid_get(global.plainTextInfoGrid, morphCol, i));
		var currentMorphList = scr_splitStringImport(currentMorphFullStr);
		var currentGlossFullStr = "";
		
		currentGlossFullStr = string(ds_grid_get(global.importGrid, global.plainTextInfoGrid_colText, i));
		
		
	
		var currentUnitStart = 0;
		var currentUnitEnd = 0;


		unitCounter++;
		
		var currentMorphListSize = ds_list_size(currentMorphList);
		for (var j = 0; j < currentMorphListSize; j++) {
		
			ds_grid_resize(obj_control.morphGrid, obj_control.morphGridWidth, ds_grid_height(obj_control.morphGrid) + 1);
		
			var currentMorph = ds_list_find_value(currentMorphList, j);

		
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitID, ds_grid_height(obj_control.morphGrid) - 1, unitCounter);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colWordID, ds_grid_height(obj_control.morphGrid) - 1, ds_grid_height(obj_control.morphGrid));
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMorph, ds_grid_height(obj_control.morphGrid) - 1, currentMorph);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, ds_grid_height(obj_control.morphGrid) - 1, currentParticipant);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitStart, ds_grid_height(obj_control.morphGrid) - 1, currentUnitStart);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitEnd, ds_grid_height(obj_control.morphGrid) - 1, currentUnitEnd);
			//ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colGloss, ds_grid_height(obj_control.morphGrid) - 1, currentGloss);
		}
	}


}

else if (global.importType == global.importType_CoNLLU){


	
	// get importGrid columns
	var unitCounter = 1;
	var unitStartCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 0);
	var unitEndCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 1);
	var participantCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 2);
	var morphCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 3);
	var glossCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 4);
	
	
	var prevUID = 0;
	var curUID = 0;
	
	
	var displayTokenRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken, 0, global.tagInfoGrid_colDisplayToken, ds_grid_height(global.tagInfoGrid), true);
	var displayTokenMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
	var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
	
	var displayUnitRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit, 0, global.tagInfoGrid_colDisplayUnit, ds_grid_height(global.tagInfoGrid), true);
	var displayUnitMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayUnitRow);
	var importGrid_colDisplayUnit = ds_list_find_index(global.importGridColNameList, displayUnitMarkerStr);
	
	
	//hardcoded for now
	var deliminaterCol = ds_list_find_index(global.importGridColNameList, global.unitImportUnitDelimColName);


	
	

	if (typeof(glossCol) != "number") {
		glossCol = -1;
	}

	// build morphGrid!
	var importGridHeight = ds_grid_height(global.importGrid);
	for (var i = 0; i < importGridHeight; i++) {
	
		var currentParticipant = string(ds_grid_get(global.importGrid, importGrid_colDisplayUnit, i));
		var currentMorphFullStr = string(ds_grid_get(global.importGrid, importGrid_colDisplayToken, i));
		var currentMorphList = scr_splitStringImport(currentMorphFullStr);
		var currentGlossFullStr = "";
		if (glossCol >= 0) {
			currentGlossFullStr = string(ds_grid_get(global.importGrid, glossCol, i));
		}
		var currentGlossList = scr_splitStringImport(currentGlossFullStr);
	
		/*if (currentParticipant == 0) {
			continue;
		}*/
	
		var currentUnitStart = 0;
		var currentUnitEnd = 0;
		if (unitStartCol >= 0) {
			currentUnitStart = ds_grid_get(global.importGrid, unitStartCol, i);
		}
		if (unitEndCol >= 0) {
			currentUnitEnd = ds_grid_get(global.importGrid, unitEndCol, i);
		}
	
		// Iterate on unit counter when a new cluster is found
		if(i > 0){
			curUID = ds_grid_get(global.importGrid, deliminaterCol, i);	
		}
		else if (i == 0) {
			prevUID = ds_grid_get(global.importGrid, deliminaterCol, i);	
		}
	
		if(curUID != 0 && string(prevUID) != string(curUID)){

			unitCounter++;
			prevUID = curUID;
		}
			
		var currentMorphListSize = ds_list_size(currentMorphList);
		for (var j = 0; j < currentMorphListSize; j++) {
		
			ds_grid_resize(obj_control.morphGrid, obj_control.morphGridWidth, ds_grid_height(obj_control.morphGrid) + 1);
		
			var currentMorph = ds_list_find_value(currentMorphList, j);
			var currentGloss = 0;
			if (glossCol >= 0) {
				currentGloss = ds_list_find_value(currentGlossList, j);
			}
		
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitID, ds_grid_height(obj_control.morphGrid) - 1, unitCounter);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colWordID, ds_grid_height(obj_control.morphGrid) - 1, ds_grid_height(obj_control.morphGrid));
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMorph, ds_grid_height(obj_control.morphGrid) - 1, currentMorph);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, ds_grid_height(obj_control.morphGrid) - 1, currentParticipant);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitStart, ds_grid_height(obj_control.morphGrid) - 1, currentUnitStart);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitEnd, ds_grid_height(obj_control.morphGrid) - 1, currentUnitEnd);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colGloss, ds_grid_height(obj_control.morphGrid) - 1, currentGloss);
			
		}
	}
}

else if (global.importType == global.importType_CSV){


	
	// get importGrid columns
	var unitCounter = 1;
	var unitStartCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 0);
	var unitEndCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 1);
	var participantCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 2);
	var morphCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 3);
	var glossCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 4);
	
	
	var prevUID = 0;
	var curUID = 0;
	
	
	var displayTokenRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken, 0, global.tagInfoGrid_colDisplayToken, ds_grid_height(global.tagInfoGrid), true);
	var displayTokenMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
	var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
	
	var displayUnitRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit, 0, global.tagInfoGrid_colDisplayUnit, ds_grid_height(global.tagInfoGrid), true);
	var displayUnitMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayUnitRow);
	var importGrid_colDisplayUnit = ds_list_find_index(global.importGridColNameList, displayUnitMarkerStr);
	
	
	//hardcoded for now
	var deliminaterCol = ds_list_find_index(global.importGridColNameList, global.unitImportUnitDelimColName);
	
	

	if (typeof(glossCol) != "number") {
		glossCol = -1;
	}

	// build morphGrid!
	var importGridHeight = ds_grid_height(global.importGrid);
	for (var i = 0; i < importGridHeight; i++) {
	
		var currentParticipant = string(ds_grid_get(global.importGrid, importGrid_colDisplayUnit, i));
		var currentMorphFullStr = string(ds_grid_get(global.importGrid, importGrid_colDisplayToken, i));
		var currentMorphList = scr_splitStringImport(currentMorphFullStr);
		var currentGlossFullStr = "";
		if (glossCol >= 0) {
			currentGlossFullStr = string(ds_grid_get(global.importGrid, glossCol, i));
		}
		var currentGlossList = scr_splitStringImport(currentGlossFullStr);
	
		if (currentParticipant == 0) {
			continue;
		}
	
		var currentUnitStart = 0;
		var currentUnitEnd = 0;
		if (unitStartCol >= 0) {
			currentUnitStart = ds_grid_get(global.importGrid, unitStartCol, i);
		}
		if (unitEndCol >= 0) {
			currentUnitEnd = ds_grid_get(global.importGrid, unitEndCol, i);
		}
		
		if(i > 0){
		var prevUID = ds_grid_get(global.importGrid, deliminaterCol, i-1);
			var curUID = ds_grid_get(global.importGrid, deliminaterCol, i);	
		}
	
		if(prevUID != curUID){

		unitCounter++;
		}
			
		var currentMorphListSize = ds_list_size(currentMorphList);
		for (var j = 0; j < currentMorphListSize; j++) {
		
			ds_grid_resize(obj_control.morphGrid, obj_control.morphGridWidth, ds_grid_height(obj_control.morphGrid) + 1);
		
			var currentMorph = ds_list_find_value(currentMorphList, j);
			var currentGloss = 0;
			if (glossCol >= 0) {
				currentGloss = ds_list_find_value(currentGlossList, j);
			}
		
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitID, ds_grid_height(obj_control.morphGrid) - 1, unitCounter);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colWordID, ds_grid_height(obj_control.morphGrid) - 1, ds_grid_height(obj_control.morphGrid));
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMorph, ds_grid_height(obj_control.morphGrid) - 1, currentMorph);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, ds_grid_height(obj_control.morphGrid) - 1, currentParticipant);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitStart, ds_grid_height(obj_control.morphGrid) - 1, currentUnitStart);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitEnd, ds_grid_height(obj_control.morphGrid) - 1, currentUnitEnd);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colGloss, ds_grid_height(obj_control.morphGrid) - 1, currentGloss);
			
		}
	}
}

else{
	
	// get importGrid columns
	var unitCounter = 0;
	var unitStartCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 0);
	var unitEndCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 1);
	var participantCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 2);
	var morphCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 3);
	var glossCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 4);
	
	
	
	
	
	var displayTokenRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken, 0, global.tagInfoGrid_colDisplayToken, ds_grid_height(global.tagInfoGrid), true);
	var displayTokenMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
	var importGrid_colDisplayToken = ds_list_find_index(global.importGridColNameList, displayTokenMarkerStr);
	
	var displayUnitRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit, 0, global.tagInfoGrid_colDisplayUnit, ds_grid_height(global.tagInfoGrid), true);
	var displayUnitMarkerStr = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayUnitRow);
	var importGrid_colDisplayUnit = ds_list_find_index(global.importGridColNameList, displayUnitMarkerStr);
	
	
	
	
	
	

	if (typeof(glossCol) != "number") {
		glossCol = -1;
	}

	// build morphGrid!
	var importGridHeight = ds_grid_height(global.importGrid);
	for (var i = 0; i < importGridHeight; i++) {
	
		var currentParticipant = string(ds_grid_get(global.importGrid, importGrid_colDisplayUnit, i));
		var currentMorphFullStr = string(ds_grid_get(global.importGrid, importGrid_colDisplayToken, i));
		var currentMorphList = scr_splitStringImport(currentMorphFullStr);
		var currentGlossFullStr = "";
		if (glossCol >= 0) {
			currentGlossFullStr = string(ds_grid_get(global.importGrid, glossCol, i));
		}
		var currentGlossList = scr_splitStringImport(currentGlossFullStr);
	
		if (currentParticipant == 0) {
			continue;
		}
	
		var currentUnitStart = 0;
		var currentUnitEnd = 0;
		if (unitStartCol >= 0) {
			currentUnitStart = ds_grid_get(global.importGrid, unitStartCol, i);
		}
		if (unitEndCol >= 0) {
			currentUnitEnd = ds_grid_get(global.importGrid, unitEndCol, i);
		}
	
		unitCounter++;
		
		var currentMorphListSize = ds_list_size(currentMorphList);
		for (var j = 0; j < currentMorphListSize; j++) {
		
			ds_grid_resize(obj_control.morphGrid, obj_control.morphGridWidth, ds_grid_height(obj_control.morphGrid) + 1);
		
			var currentMorph = ds_list_find_value(currentMorphList, j);
			var currentGloss = 0;
			if (glossCol >= 0) {
				currentGloss = ds_list_find_value(currentGlossList, j);
			}
		
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitID, ds_grid_height(obj_control.morphGrid) - 1, unitCounter);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colWordID, ds_grid_height(obj_control.morphGrid) - 1, ds_grid_height(obj_control.morphGrid));
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMorph, ds_grid_height(obj_control.morphGrid) - 1, currentMorph);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, ds_grid_height(obj_control.morphGrid) - 1, currentParticipant);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitStart, ds_grid_height(obj_control.morphGrid) - 1, currentUnitStart);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitEnd, ds_grid_height(obj_control.morphGrid) - 1, currentUnitEnd);
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colGloss, ds_grid_height(obj_control.morphGrid) - 1, currentGloss);
			
		}
	}
}
scr_morphToUnitGrid();