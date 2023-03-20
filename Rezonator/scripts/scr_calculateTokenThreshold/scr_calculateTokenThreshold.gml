

function scr_calculateTokenThreshold() {
	
	if (global.importType == "import_type_interlinear") {
		var displayTokenRow = ds_grid_value_y(global.tagInfoGrid,global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "option_display-token");
		var wordDelimRow = ds_grid_value_y(global.tagInfoGrid,global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "option_word-delimiter");
			
		if (wordDelimRow != -1) {
			obj_importMapping.wordDelimMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, wordDelimRow);
			var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.wordDelimMarker)-2;
			var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
			obj_importMapping.currentWordThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
		}
		if (displayTokenRow != -1) {
				
			obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
			var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
			var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
			obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
		}
	}
	obj_importMapping.updatedErrorCol = false;
	
}