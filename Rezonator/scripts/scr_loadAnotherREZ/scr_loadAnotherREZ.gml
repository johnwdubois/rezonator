var originalGrid = argument0;
var map = argument1;
var gridStr = argument2;

var tempGrid = ds_grid_create(ds_grid_width(originalGrid), 0);
				
scr_loadREZGridReset(tempGrid, map, gridStr);


// now we've gotten the new grid, but we may need to change its values
var originalGridHeight = ds_grid_height(originalGrid);

if (originalGridHeight > 0) {
	
	for (var i = 0; i < ds_grid_height(tempGrid); i++) {
		for (var j = 0; j < ds_grid_width(tempGrid); j++) {
			
			var currentCellValue = ds_grid_get(tempGrid, j, i);
			
			if (originalGrid == obj_control.wordGrid) {
				
				if (j == obj_control.wordGrid_colWordID) {
					currentCellValue = originalWordGridHeight + 1 + i;
				}
				else if (j == obj_control.wordGrid_colUnitID) {
					currentCellValue = originalUnitGridHeight + 1 + i;
				}
			}
			else if (originalGrid == obj_control.dynamicWordGrid) {
				
				if (j == obj_control.dynamicWordGrid_colWordID) {
					currentCellValue = originalWordGridHeight + 1 + i;
				}
			}
			else if (originalGrid == obj_control.unitGrid) {
				if (j == obj_control.unitGrid_colUnitID) {
					currentCellValue = originalUnitGridHeight + 1 + i;
				}
				/*
				else if (j == obj_control.unitGrid_colWordIDList) {
					
					for (var k = 0; k < ds_list_size(currentCellValue); k++) {
						var currentWordID = ds_list_find_value(currentCellValue, k);
						ds_list_replace(currentCellValue, k, currentWordID + 1 + originalWordGridHeight);
					}
				}
				*/
			}
			else if (originalGrid == obj_control.lineGrid) {
				if (j == obj_control.lineGrid_colUnitID) {
					currentCellValue = originalLineGridHeight + 1 + i;
				}
				else if (j == obj_control.lineGrid_colDisplayRow) {
					currentCellValue = originalLineGridHeight + 1 + i;
				}
				/*
				else if (j == obj_control.lineGrid_colWordIDList) {
					
					for (var k = 0; k < ds_list_size(currentCellValue); k++) {
						var currentWordID = ds_list_find_value(currentCellValue, k);
						ds_list_replace(currentCellValue, k, currentWordID + 1 + originalWordGridHeight);
					}
				}
				*/
			}
			
			ds_grid_set(tempGrid, j, i, currentCellValue);
		}
	}
}




				

ds_grid_resize(originalGrid, ds_grid_width(originalGrid), originalGridHeight + ds_grid_height(tempGrid));
ds_grid_set_grid_region(originalGrid, tempGrid, 0, 0, ds_grid_width(tempGrid), ds_grid_height(tempGrid), 0, originalGridHeight);
ds_grid_destroy(tempGrid);