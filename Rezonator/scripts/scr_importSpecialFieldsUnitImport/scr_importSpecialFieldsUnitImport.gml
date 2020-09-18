function scr_importSpecialFieldsUnitImport() {
	show_debug_message("scr_importSpecialFieldsUnitImport()");

	// import special fields for unitImportGrid
	if (!global.importedSpecialFields && ds_grid_height(global.unitImportGrid) > 0) {
		global.importedSpecialFields = true;
	
		var unitStartCol = ds_list_find_index(global.unitImportColNameList, global.unitImportUnitStartColName);
		var unitEndCol = ds_list_find_index(global.unitImportColNameList, global.unitImportUnitEndColName);
	
		var unitImportGridHeight = ds_grid_height(global.unitImportGrid);
		for (var i = 0; i < unitImportGridHeight; i++) {
			if (unitStartCol >= 0) {
				var currentUnitStart = ds_grid_get(global.unitImportGrid, unitStartCol, i);
				ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, i, currentUnitStart);
			}
			if (unitEndCol >= 0) {
				var currentUnitEnd = ds_grid_get(global.unitImportGrid, unitEndCol, i);
				ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, i, currentUnitEnd);
			}
		}
	}


}
