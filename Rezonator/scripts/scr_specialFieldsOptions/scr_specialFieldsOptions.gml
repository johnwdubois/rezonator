function scr_specialFieldsOptions(optionSelected) {
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);



	switch (optionSelected)
	{
		case "unit_start":
			global.unitImportUnitStartColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "unit_start") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "unit_start");
			global.unitImportUnitStartColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "participant":
			global.unitImportSpeakerColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "participant") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "participant");
			global.unitImportSpeakerColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
		break;
		case "unit_end":
		global.unitImportUnitEndColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "unit_end") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "unit_end");
			global.unitImportUnitEndColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "option_translation":
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "option_translation") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "option_translation");
			break;
		case "msg_transcript":
		global.tokenImportTranscriptColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "msg_transcript") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "msg_transcript");
			global.tokenImportTranscriptColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;

		
		case "unit_delim":
		global.unitDelimField = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "unit_delim") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "unit_delim");
			global.unitDelimField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "turn_delim":
		global.unitImportTurnDelimColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "turn_delim") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "turn_delim");
			global.unitImportTurnDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "psent_delim":
		global.unitImportTurnDelimColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "psent_delim") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "psent_delim");
			global.unitImportTurnDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "option_word-delimiter":
		global.wordDelimField = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "option_word-delimiter") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "option_word-delimiter");
			if (global.importType == IMPORTTYPE_IGT) {
				obj_importMapping.wordDelimMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
				var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.wordDelimMarker)-2;
				var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
				obj_importMapping.currentWordThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
			}
			global.wordDelimField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
			
		case "option_display-token":
			global.tokenImportDisplayTokenColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "option_display-token") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "option_display-token");
			global.tokenImportDisplayTokenColName  = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			
			if (global.importType == IMPORTTYPE_IGT) {
				obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
				var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
				var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
				obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
			}
			break;
		case "tab_name_track":
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "tab_name_track") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "tab_name_track");
			break;
		case "menu_clear":
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "");
			break;
		default:
			break;
	}
	
	obj_importMapping.updatedErrorCol = false;

	with (obj_dropDown) {
		instance_destroy();
	}


}
