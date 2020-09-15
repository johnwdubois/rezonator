// copy discoImport and unitImport to tokenImport for level heirarchy
if (!global.openedREZFile) {

	if (!global.discoGridCopied && ds_grid_height(global.discoImportGrid) > 0) {
		show_debug_message("scr_copyLevelMapping() ... copying discoImportGrid");
		global.discoGridCopied = true;
	
		var discoGridWidth = ds_grid_width(global.discoImportGrid);
		var unitGridHeight = ds_grid_height(global.unitImportGrid);
		var oldUnitGridWidth = global.unitImportGridWidth;
	
		global.unitImportGridWidth = global.unitImportGridWidth + discoGridWidth;
		ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, unitGridHeight);
	
		for(var i = 0; i < discoGridWidth; i++){
			var colName = ds_list_find_value(global.discoImportColNameList, i);
			ds_list_add(global.unitImportColNameList, colName);
			for(var j = 0; j < unitGridHeight; j++){

				var currentDiscoHeight = 0;
				var currentCellValue = ds_grid_get(global.discoImportGrid, i, currentDiscoHeight);
				ds_grid_set(global.unitImportGrid, oldUnitGridWidth, j, currentCellValue);
			
			}
			oldUnitGridWidth++
		}
		with(obj_gridViewer){
			scr_gridViewerDynamicWidth(global.unitImportGrid);
		}	
	}

	if (!global.unitGridCopied && ds_grid_height(global.unitImportGrid) > 0) {
		show_debug_message("scr_copyLevelMapping() ... copying unitImportGrid");
		global.unitGridCopied = true;
	
		var unitGridWidth = ds_grid_width(global.unitImportGrid);
		var tokenGridHeight = ds_grid_height(global.tokenImportGrid);
		var oldTokenGridWidth = global.tokenImportGridWidth;
		global.tokenImportGridWidth = global.tokenImportGridWidth + unitGridWidth-2;
		ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, tokenGridHeight);
	
		for(var i = 2; i < unitGridWidth; i++){
			var colName = ds_list_find_value(global.unitImportColNameList, i);
			ds_list_add(global.tokenImportColNameList, colName);
			for(var j = 0; j < tokenGridHeight; j++){
				var currentUID = ds_grid_get(global.tokenImportGrid, global.tokenImport_colUnitID, j);
				var currentCellValue = ds_grid_get(global.unitImportGrid, i, currentUID-1);
				ds_grid_set(global.tokenImportGrid,oldTokenGridWidth,j,currentCellValue);
			
			}
			oldTokenGridWidth++
		}
		with(obj_gridViewer){
			scr_gridViewerDynamicWidth(global.tokenImportGrid);
		}
	}
}