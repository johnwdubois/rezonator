// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_updateTagInfoErrorCol(){
	
	show_debug_message("scr_updateTagInfoErrorCol() ... START");
	
	// if there are any zeros in the schema column, change them to be level unknown
	var zeroRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, 0, global.tagInfoGrid_colLevelSchema, ds_grid_height(global.tagInfoGrid), 0);
	while (zeroRow > -1) {
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, zeroRow, global.levelUnknown);
		zeroRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, 0, global.tagInfoGrid_colLevelSchema, ds_grid_height(global.tagInfoGrid), 0);
	}
	
	
	var indexOfDisplayMarker = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
	var indexOfWordDelim = ds_list_find_index(global.importGridColNameList, obj_importMapping.wordDelimMarker)-2;
			
	obj_importMapping.canContinueToken1to1 = true;
	obj_importMapping.canContinueWord1to1 = true;
	show_debug_message("scr_updateTagInfoErrorCol() ... pre-loop, canContinueToken1to1: " + string(obj_importMapping.canContinueToken1to1) + " ... canContinueWord1to1: " + string(obj_importMapping.canContinueWord1to1));
			
	var tagGridHeight = ds_grid_height(global.tagInfoGrid);
	for(var i  = 0; i <= tagGridHeight; i++) {
		var TargetMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		var indexOfTargetMarker = ds_list_find_index(global.importGridColNameList, TargetMarker)-2;
		var levelOfField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
		
		show_debug_message("scr_updateTagInfoErrorCol() ... targetMarker: " + string(indexOfTargetMarker) + ", levelOfField: " + string(levelOfField));
				
		// set every field to have no error by default
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colError, i, false);
				
		if (levelOfField == global.levelToken) {
				
			if (global.importType == global.importType_IGT) {
				var targetThreshold = ds_grid_get(global.fieldRelationHelperGrid, indexOfTargetMarker, indexOfDisplayMarker);
				var targetThresholdError = (targetThreshold < obj_importMapping.currentTokenThreshold);
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colError, i, targetThresholdError);
					
				if (targetThresholdError) {
					obj_importMapping.canContinueToken1to1 = false;
				}
			}
					
			// if there is no Display Token, set error to true
			if (!obj_importMapping.canContinueDisplayToken) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colError, i, true);
			}
		}
		else if (levelOfField == global.levelWord) {
					
			if (global.importType == global.importType_IGT) {
				if (indexOfWordDelim > -1) {
					var targetThreshold = ds_grid_get(global.fieldRelationHelperGrid, indexOfTargetMarker, indexOfWordDelim);
					var targetThresholdError = (targetThreshold < obj_importMapping.currentWordThreshold);
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colError, i, targetThresholdError);
					
					if (targetThresholdError) {
						obj_importMapping.canContinueWord1to1 = false;
					}
				}
					
				// if there is no Word Delimiter, set error to true
				if (!obj_importMapping.canContinueWordDelimiter) {
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colError, i, true);
				}
			}
		}
		
		// check if there is an error with the special fields
		var specialFieldsError = false;
		var currentSpecialFields = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
		if (  (currentSpecialFields == "Unit Start" && levelOfField != global.levelUnit)
		   || (currentSpecialFields == "Unit End" && levelOfField != global.levelUnit)
		   || (currentSpecialFields == "Speaker" && levelOfField != global.levelUnit)
		   || (currentSpecialFields == "Unit Delimiter" && levelOfField != global.levelUnit)
		   || (currentSpecialFields == "Turn Delimiter" && levelOfField != global.levelUnit)
		   || (currentSpecialFields == "Translation" && levelOfField != global.levelUnit)
		   || (currentSpecialFields == "Display Token" && levelOfField != global.levelToken)
		   || (currentSpecialFields == "Transcript" && levelOfField != global.levelToken)
		   || (currentSpecialFields == "Word Delimiter" && levelOfField != global.levelWord)
		   ) {
			   specialFieldsError = true;
		   }
		// if there is an error with the special fields, remove the special field
		if (specialFieldsError) {
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, "");
		}
		
	}
	show_debug_message("scr_updateTagInfoErrorCol() ... post-loop, canContinueToken1to1: " + string(obj_importMapping.canContinueToken1to1) + " ... canContinueWord1to1: " + string(obj_importMapping.canContinueWord1to1));
}