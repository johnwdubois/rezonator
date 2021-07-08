function scr_specialFieldsOptions(optionSelected) {
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);

	switch (optionSelected)
	{
		case "Unit Start":
			global.unitImportUnitStartColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Unit Start") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Unit Start");
			global.unitImportUnitStartColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "Speaker":
			global.unitImportSpeakerColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Speaker") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Speaker");
			global.unitImportSpeakerColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
		break;
		case "Unit End":
		global.unitImportUnitEndColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Unit End") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Unit End");
			global.unitImportUnitEndColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "Translation":
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Translation") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Translation");
			break;
		case "Transcript":
		global.tokenImportTranscriptColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Transcript") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Transcript");
			global.tokenImportTranscriptColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;

		
		case "Unit Delimiter":
		global.unitDelimField = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Unit Delimiter") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Unit Delimiter");
			global.unitDelimField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "Turn Delimiter":
		global.unitImportTurnDelimColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Turn Delimiter") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Turn Delimiter");
			global.unitImportTurnDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
		case "Word Delimiter":
		global.wordDelimField = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Word Delimiter") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Word Delimiter");
			if (global.importType == global.importType_IGT) {
				obj_importMapping.wordDelimMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
				var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.wordDelimMarker)-2;
				var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
				obj_importMapping.currentWordThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
			}
			global.wordDelimField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			break;
			
		case "Display Token":
			global.tokenImportDisplayTokenColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Display Token") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Display Token");
			global.tokenImportDisplayTokenColName  = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			
			if (global.importType == global.importType_IGT) {
				obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
				var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
				var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
				obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
			}
			break;
		default:
			break;
	}
	
	obj_importMapping.updatedErrorCol = false;

	with (obj_dropDown) {
		instance_destroy();
	}


}
