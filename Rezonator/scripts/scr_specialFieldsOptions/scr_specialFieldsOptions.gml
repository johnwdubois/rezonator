var optionSelected = argument0;
var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);

switch (optionSelected)
{
	case "UnitStart":
		global.unitImportUnitStartColName = "";
		for (var i = 0; i < tagInfoGridHeight; i++) {
			if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "UnitStart") {
				ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
			}
		}
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "UnitStart");
		global.unitImportUnitStartColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
		break;
	case "UnitEnd":
	global.unitImportUnitEndColName = "";
		for (var i = 0; i < tagInfoGridHeight; i++) {
			if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "UnitEnd") {
				ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
			}
		}
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "UnitEnd");
		global.unitImportUnitEndColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
		break;
		
	case "UnitDelim":
	global.unitImportUnitDelimColName = "";
		for (var i = 0; i < tagInfoGridHeight; i++) {
			if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "UnitDelim") {
				ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
			}
		}
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "UnitDelim");
		global.unitImportUnitDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
		break;
	case "TurnDelim":
	global.unitImportTurnDelimColName = "";
		for (var i = 0; i < tagInfoGridHeight; i++) {
			if (ds_grid_get(global.tagInfoGrid, obj_importMapping.colToChange, i) == "TurnDelim") {
				ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, i, 0);
			}
		}
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, "TurnDelim");
		global.unitImportTurnDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, obj_importMapping.rowToChange);
		break;
	default:
		break;
}

with (obj_dropDown) {
	instance_destroy();
}