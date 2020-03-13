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
	for (var i = 0; i < ds_grid_height(global.plainTextInfoGrid); i++) {
	
		var currentParticipant = string(global.givenSpeaker);
		var currentMorphFullStr = string(ds_grid_get(global.plainTextInfoGrid, morphCol, i));
		var currentMorphList = scr_splitStringImport(currentMorphFullStr);
		var currentGlossFullStr = "";
		
		currentGlossFullStr = string(ds_grid_get(global.importGrid, global.plainTextInfoGrid_colText, i));
		
		
	
		var currentUnitStart = 0;
		var currentUnitEnd = 0;


		unitCounter++;
	
		for (var j = 0; j < ds_list_size(currentMorphList); j++) {
		
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

else {
	
	// get importGrid columns
	var unitCounter = 0;
	var unitStartCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 0);
	var unitEndCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 1);
	var participantCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 2);
	var morphCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 3);
	var glossCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 4);

	if (typeof(glossCol) != "number") {
		glossCol = -1;
	}

	// build morphGrid!
	for (var i = 0; i < ds_grid_height(global.importGrid); i++) {
	
		var currentParticipant = string(ds_grid_get(global.importGrid, participantCol, i));
		var currentMorphFullStr = string(ds_grid_get(global.importGrid, morphCol, i));
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
	
		for (var j = 0; j < ds_list_size(currentMorphList); j++) {
		
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