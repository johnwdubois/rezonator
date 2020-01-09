if (ds_grid_height(global.importToolboxGrid) < 1) {
	exit;
}


// get importGrid columns
var unitCounter = 0;
var participantCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 3);
var morphCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 6);
var unitStartCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 1);
var unitEndCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 2);
var glossCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 7);

if (typeof(glossCol) != "number") {
	glossCol = -1;
}


// build morphGrid!
for (var i = 0; i < ds_grid_height(global.importToolboxGrid); i++) {
	
	var currentParticipant = string(ds_grid_get(global.importToolboxGrid, participantCol, i));
	var currentMorphFullStr = string(ds_grid_get(global.importToolboxGrid, morphCol, i));
	var currentMorphList = scr_splitStringToolbox(currentMorphFullStr);
	var currentGlossFullStr = "";
	if (glossCol >= 0) {
		currentGlossFullStr = string(ds_grid_get(global.importToolboxGrid, glossCol, i));
	}
	var currentGlossList = scr_splitStringToolbox(currentGlossFullStr);
	
	if (currentParticipant == 0) {
		continue;
	}
	
	var currentUnitStart = 0;
	var currentUnitEnd = 0;
	if (unitStartCol >= 0) {
		currentUnitStart = ds_grid_get(global.importToolboxGrid, unitStartCol, i);
	}
	if (unitEndCol >= 0) {
		currentUnitEnd = ds_grid_get(global.importToolboxGrid, unitEndCol, i);
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


scr_morphToUnitGrid();