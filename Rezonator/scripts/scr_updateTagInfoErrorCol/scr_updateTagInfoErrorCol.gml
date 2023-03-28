

function scr_updateTagInfoErrorCol() {
	
	show_debug_message("scr_updateTagInfoErrorCol() ... START");
	
	// if there are any zeros in the schema column, change them to be level unknown
	var zeroRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, 0, global.tagInfoGrid_colLevelSchema, ds_grid_height(global.tagInfoGrid), 0);
	while (zeroRow > -1) {
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, zeroRow, global.levelUnknown);
		zeroRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, 0, global.tagInfoGrid_colLevelSchema, ds_grid_height(global.tagInfoGrid), 0);
	}
	
	// check if unit delimiter is needed but not specified
	var unitDelimNeeded = false;
	if (global.importType == IMPORTTYPE_CONLLU || global.importType == IMPORTTYPE_WORD) {
		var unitDelimRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "unit_delim");
		if (unitDelimRow < 0) {
			unitDelimNeeded = true;
		}
		obj_importMapping.canContinueUnit = !unitDelimNeeded;
	}
	
	
	
	var indexOfDisplayMarker = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker) - 2;
	var indexOfWordDelim = ds_list_find_index(global.importGridColNameList, obj_importMapping.wordDelimMarker) - 2;
			
	obj_importMapping.canContinueToken1to1 = true;
	obj_importMapping.canContinueWord1to1 = true;
	show_debug_message("scr_updateTagInfoErrorCol() ... pre-loop, canContinueToken1to1: " + string(obj_importMapping.canContinueToken1to1) + " ... canContinueWord1to1: " + string(obj_importMapping.canContinueWord1to1));
			
	var tagGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var i  = 0; i <= tagGridHeight; i++) {
		var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		var currentFieldIndex = ds_list_find_index(global.importGridColNameList, currentField)-2;
		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
		
		show_debug_message("scr_updateTagInfoErrorCol() ... currentField: " + string(currentField) + ", currentFieldIndex: " + string(currentFieldIndex) + ", currentLevel: " + string(currentLevel));
				
		// set every field to have no error by default
		ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colError, i, false);
				
		if (currentLevel == global.levelToken) {
				
			if (global.importType == IMPORTTYPE_IGT) {
				var targetThreshold = ds_grid_get(global.fieldRelationHelperGrid, currentFieldIndex, indexOfDisplayMarker);
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
		else if (currentLevel == global.levelWord) {
					
			if (global.importType == IMPORTTYPE_IGT) {
				if (indexOfWordDelim > -1) {
					var targetThreshold = ds_grid_get(global.fieldRelationHelperGrid, currentFieldIndex, indexOfWordDelim);
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
		else if (currentLevel == global.levelUnit) {
			if (unitDelimNeeded) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colError, i, true);
			}
		}
		
		// check if there is an error with the special fields
		var specialFieldsError = false;
		var currentSpecialFields = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
		if (  (currentSpecialFields == "unit_start" && currentLevel != global.levelUnit)
		   || (currentSpecialFields == "unit_end" && currentLevel != global.levelUnit)
		   || (currentSpecialFields == "participant" && currentLevel != global.levelUnit)
		   || (currentSpecialFields == "unit_delim" && currentLevel != global.levelUnit)
		   || (currentSpecialFields == "turn_delim" && currentLevel != global.levelUnit)
		   || (currentSpecialFields == "psent_delim" && currentLevel != global.levelUnit)
		   || (currentSpecialFields == "option_translation" && currentLevel != global.levelUnit)
		   || (currentSpecialFields == "option_display-token" && currentLevel != global.levelToken)
		   || (currentSpecialFields == "msg_transcript" && currentLevel != global.levelToken)
		   || (currentSpecialFields == "option_word-delimiter" && currentLevel != global.levelWord)
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