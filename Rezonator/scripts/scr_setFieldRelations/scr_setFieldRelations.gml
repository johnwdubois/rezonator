

function scr_setFieldRelations() {
	

	var strikeMaximum = max(1,floor( ds_grid_height(global.importGrid) * .02));

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
	
	global.fieldRelationHelperGridWidth = importGridColNameListSize-2;
	ds_grid_resize(global.fieldRelationHelperGrid, global.fieldRelationHelperGridWidth, importGridColNameListSize-2);
	

	// loop through the block grid
	var blockGridHeight = ds_grid_height(global.blockGrid);
	for (var i = 0; i < blockGridHeight; i++) {
		var currentBlockType = ds_grid_get(global.blockGrid, global.blockGrid_colBlockType, i);
		var currentBlockCategory = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, currentBlockType - 1);
		
		// loop through all of the blocks that are not headers
		if (currentBlockCategory == global.blockCategoryUnit) {
			
			var currentFieldList = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colFieldList, currentBlockType - 1);
			var currentFieldListSize = ds_list_size(currentFieldList);
			var currentTokenCountList = ds_grid_get(global.blockGrid, global.blockGrid_colTokenCountList, i);
			
			for (var j = 0; j < currentFieldListSize; j++) {
				var currentField = ds_list_find_value(currentFieldList, j);
				var rowInFieldRelationGrid = ds_grid_value_y(global.fieldRelationGrid, global.fieldRelationGrid_colField, 0, global.fieldRelationGrid_colField, ds_grid_height(global.fieldRelationGrid), currentField);
				var currentTokenCount = ds_list_find_value(currentTokenCountList,j);
				
				for (var k = 0; k < currentFieldListSize; k++) {

					
					var fieldToCheck = ds_list_find_value(currentFieldList, k);
					var oneToOneFieldList = ds_grid_get(global.fieldRelationGrid, global.fieldRelationGrid_colOneToOneFieldList, rowInFieldRelationGrid);
					var encounteredFieldList = ds_grid_get(global.fieldRelationGrid, global.fieldRelationGrid_colEncounteredFields, rowInFieldRelationGrid);
					var rowIndex = ds_list_find_index(global.importGridColNameList,fieldToCheck)-2;
					var colIndex = ds_list_find_index(global.importGridColNameList,currentField)-2;
					
					
					
					
					// is fieldToCheck in our 1-to-1 list?
					if (ds_list_find_index(oneToOneFieldList, fieldToCheck) > -1) {
						// we previously marked this as 1-to-1, let's verify and check again
						
							var fieldToCheckTokenCount = ds_list_find_value(currentTokenCountList,k);
							var strikeCounter = ds_grid_get(global.fieldRelationHelperGrid,colIndex, rowIndex);
							//check if token counts are the same and if they are add to one-to-one list
							if (currentTokenCount != fieldToCheckTokenCount ) {
								
								
								
							var indexInOneToOne = ds_list_find_index(oneToOneFieldList, fieldToCheck);
							ds_list_delete(oneToOneFieldList, indexInOneToOne);
	

							}
							else {
								strikeCounter++;
								ds_grid_set(global.fieldRelationHelperGrid,colIndex, rowIndex,strikeCounter)
							}
						
					}
					else {
						if (ds_list_find_index(encounteredFieldList, fieldToCheck) > -1) {
							// we have encountered this field before, and marked it as not 1-to-1
							
							var fieldToCheckTokenCount = ds_list_find_value(currentTokenCountList,k);
							var strikeCounter = ds_grid_get(global.fieldRelationHelperGrid,colIndex, rowIndex);
								
							
							//check if token counts are the same and if they are add to one-to-one list
							if (currentTokenCount == fieldToCheckTokenCount ) {
									strikeCounter++;
									ds_list_add(oneToOneFieldList, fieldToCheck);
									ds_grid_set(global.fieldRelationHelperGrid,colIndex, rowIndex, strikeCounter);
							}
							continue;
						}
						// check for the first time
						else {
							//add to encounter fields
							ds_list_add(encounteredFieldList, fieldToCheck);
			
						
							var fieldToCheckTokenCount = ds_list_find_value(currentTokenCountList,k);
							var strikeCounter = ds_grid_get(global.fieldRelationHelperGrid,colIndex, rowIndex);
							//check if token counts are the same and if they are add to one-to-one list
							if (currentTokenCount == fieldToCheckTokenCount ) {
								strikeCounter++;
								ds_list_add(oneToOneFieldList, fieldToCheck);
								show_debug_message("added: " + string(fieldToCheck) + "  to " + string(currentField)+ "'s oneToOneList fields list");
								ds_grid_set(global.fieldRelationHelperGrid,colIndex, rowIndex, strikeCounter);
							}
						}
					}
				
				}
			
			}
		}
	
	}


}