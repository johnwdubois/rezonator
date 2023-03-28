function scr_sortElan() {
	
	// if this is an Elan formatted file, we will atempt to sort the importGrid by
	// the UnitStart and UnitEnd columns
	if (global.importType == IMPORTTYPE_ELAN) {
		var unitStartCol = ds_list_find_index(global.importGridColNameList, global.unitImportUnitStartColName);
		var unitEndCol = ds_list_find_index(global.importGridColNameList, global.unitImportUnitEndColName);
		show_debug_message("scr_sortElan() ... unitStartCol: " + string(unitStartCol) + ", unitEndCol: " + string(unitEndCol));
		
		var unitStartColFound = (unitStartCol >= 0);
		var unitEndColFound = (unitEndCol >= 0);
		
		// loop over all values in UnitStart col and convert them to numbers (if UnitStart/UnitEnd fields have been specified)
		for (var i = 0; i < ds_grid_height(global.importGrid); i++) {
			if (unitStartColFound) {
				var currentUnitStart = ds_grid_get(global.importGrid, unitStartCol, i);
				if (scr_isStrNumeric(currentUnitStart)) {
					ds_grid_set(global.importGrid, unitStartCol, i, real(currentUnitStart));
				}
			}
			if (unitEndColFound) {
				var currentUnitEnd = ds_grid_get(global.importGrid, unitEndCol, i);
				if (scr_isStrNumeric(currentUnitEnd)) {
					ds_grid_set(global.importGrid, unitEndCol, i, real(currentUnitEnd));
				}
			}
		}
		
		// check if we have found both unitStart and UnitEnd, just UnitStart, just UnitEnd, or neither
		// and then sort by the columns found
		if (unitStartColFound && unitEndColFound) {
			scr_gridMultiColSort(global.importGrid, unitStartCol, true, unitEndCol, true);
		}
		else if (unitStartColFound && !unitEndColFound) {
			ds_grid_sort(global.importGrid, unitStartCol, true);
		}
		else if (!unitStartColFound && unitEndColFound) {
			ds_grid_sort(global.importGrid, unitEndCol, true);
		}
	}
}