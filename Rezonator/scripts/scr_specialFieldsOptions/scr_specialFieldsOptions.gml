function scr_specialFieldsOptions(argument0) {
	var optionSelected = argument0;
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
			global.unitImportUnitStartColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Speaker") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Speaker");
			global.unitImportUnitStartColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
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
		
		case "Unit Delimiter":
		global.unitImportUnitDelimColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Unit Delimiter") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Unit Delimiter");
			global.unitImportUnitDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
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
		case "Display Token":
			global.unitImportUnitStartColName = "";
			for (var i = 0; i < tagInfoGridHeight; i++) {
				if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "Display Token") {
					ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
				}
			}
			
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "Display Token");
			obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
			var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
			var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
			obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
			obj_importMapping.updatedErrorCol = false;
			global.unitImportUnitStartColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
		break;
		default:
			break;
	}

	with (obj_dropDown) {
		instance_destroy();
	}


}
