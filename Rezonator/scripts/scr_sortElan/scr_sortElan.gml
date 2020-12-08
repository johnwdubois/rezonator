// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_sortElan(){
	
	if (global.importType == global.importType_TabDelimited) {
		var unitStartCol = ds_list_find_index(global.importGridColNameList, global.unitImportUnitStartColName);
		var unitEndCol = ds_list_find_index(global.importGridColNameList, global.unitImportUnitEndColName);
		show_debug_message("scr_sortElan() ... unitStartCol: " + string(unitStartCol));
		
		// loop over all values in UnitStart col and convert them to numbers
		for (var i = 0; i < ds_grid_height(global.importGrid); i++) {
			var currentUnitStart = ds_grid_get(global.importGrid, unitStartCol, i);
			ds_grid_set(global.importGrid, unitStartCol, i, real(currentUnitStart));
			var currentUnitEnd = ds_grid_get(global.importGrid, unitEndCol, i);
			ds_grid_set(global.importGrid, unitEndCol, i, real(currentUnitEnd));
		}
		
		if (unitStartCol > -1) {
			//(global.importGrid, unitStartCol, true);
			scr_gridMultiColSort(global.importGrid, unitStartCol, true, unitEndCol, true);
		}
	}
}