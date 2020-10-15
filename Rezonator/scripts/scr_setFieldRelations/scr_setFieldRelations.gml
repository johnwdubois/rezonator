// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setFieldRelations(){
	
	show_debug_message("scr_setFieldRelations() ... START. Time is: " + scr_printTime());
	
	// make a new row in the fieldRelationGrid for every field
	var importGridColNameListSize = ds_list_size(global.importGridColNameList);
	ds_grid_resize(global.fieldRelationGrid, global.fieldRelationGridWidth, importGridColNameListSize);
	for (var i = 0; i < importGridColNameListSize; i++) {
		var currentField = ds_list_find_value(global.importGridColNameList, i);
		ds_grid_set(global.fieldRelationGrid, global.fieldRelationGrid_colField, i, currentField);
		var emptyList1 = ds_list_create();
		var emptyList2 = ds_list_create();
		ds_grid_set(global.fieldRelationGrid, global.fieldRelationGrid_colEncounteredFields, i, emptyList1);
		ds_grid_set(global.fieldRelationGrid, global.fieldRelationGrid_colOneToOneFieldList, i, emptyList2);
	}
	
	
	
	var blockGridHeight = ds_grid_height(global.blockGrid);
	for (var i = 0; i < blockGridHeight; i++) {
		var currentBlockType = ds_grid_get(global.blockGrid, global.blockGrid_colBlockType, i);
		var currentBlockCategory = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, currentBlockType - 1);
		
		if (currentBlockCategory == global.blockCategoryUnit) {
			
			var currentFieldList = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colFieldList, currentBlockType - 1);
			var currentFieldListSize = ds_list_size(currentFieldList);
			var currentLineList = ds_grid_get(global.blockGrid, global.blockGrid_colLineList, i);
			var currentTokenCountList = ds_grid_get(global.blockGrid, global.blockGrid_colTokenCountList, i);
			var currentLineListSize = ds_list_size(currentLineList);
			
			for (var j = 0; j < currentFieldListSize; j++) {
				var currentField = ds_list_find_value(currentFieldList, j);
				var rowInFieldRelationGrid = ds_grid_value_y(global.fieldRelationGrid, global.fieldRelationGrid_colField, 0, global.fieldRelationGrid_colField, ds_grid_height(global.fieldRelationGrid), currentField);
				
				for (var k = 0; k < currentFieldListSize; k++) {
					if (k == j) {
						continue;
					}
					
					var fieldToCheck = ds_list_find_value(currentFieldList, k);
					var oneToOneFieldList = ds_grid_get(global.fieldRelationGrid, global.fieldRelationGrid_colOneToOneFieldList, rowInFieldRelationGrid);
					var encounteredFieldList = ds_grid_get(global.fieldRelationGrid, global.fieldRelationGrid_colEncounteredFields, rowInFieldRelationGrid);
					
					// is fieldToCheck in our 1-to-1 list?
					if (ds_list_find_index(oneToOneFieldList, fieldToCheck) > -1) {
						// we previously marked this as 1-to-1, let's verify and check again
					}
					else {
						if (ds_list_find_index(encounteredFieldList, fieldToCheck) > -1) {
							// we have encountered this field before, and marked it as not 1-to-1
							continue;
						}
						else {
							// check for the first time
						}
					}
				}
				
			}
			
		}
	}
	
	
	
	
	
	show_debug_message("scr_setFieldRelations() ... END. Time is: " + scr_printTime());

}