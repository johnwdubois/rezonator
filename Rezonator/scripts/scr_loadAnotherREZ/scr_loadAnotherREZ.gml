/*
	scr_loadAnotherRez(originalGrid, map, gridStr);
	
	Last Updated: 2020-01-01
	
	Called from: obj_fileLoader
	
	Purpose: Extract data from an individual map
	
	Mechanism: Reconstruct Rezonator's critical grids line by line by changing the structure of the tempGrid 
	
	Author: Terry DuBois
*/

var originalGrid = argument0;
var map = argument1;
var gridStr = argument2;
var tempGrid = ds_grid_create(0, 0);


if (originalGrid != global.importGrid || originalGrid != global.importCSVGrid ) {
	ds_grid_resize(tempGrid, ds_grid_width(originalGrid), 0);
}

if (originalGrid == global.importGrid) {
	if (global.importGridWidth >= 0){
		if(global.importGridWidth == undefined){
			global.importGridWidth = 0;
		}
		ds_grid_resize(tempGrid, global.importGridWidth, 0);
	}
}
	
if (originalGrid == global.importCSVGrid) {

	if (global.importCSVGridWidth >= 0){
		
		if(global.importCSVGridWidth == undefined){
			global.importCSVGridWidth = 0;
		}
		ds_grid_resize(tempGrid, global.importCSVGridWidth, 0);
	
	}

}




scr_loadREZGridReset(tempGrid, map, gridStr);



// now we've gotten the new grid, but we may need to change its values
var originalGridHeight = ds_grid_height(originalGrid);
var tempGridHeight = ds_grid_height(tempGrid);
var tempGridWidth = ds_grid_width(tempGrid);

if (originalGridHeight > 0) {
	
	for (var i = 0; i < tempGridHeight; i++) {
		for (var j = 0; j < tempGridWidth; j++) {
			
			var currentCellValue = ds_grid_get(tempGrid, j, i);
		
			
			if (originalGrid == obj_control.wordGrid) {
				
				if (j == obj_control.wordGrid_colWordID) {
					currentCellValue = originalWordGridHeight + 1 + i;
				}
				else if (j == obj_control.wordGrid_colUnitID) {
					currentCellValue = originalUnitGridHeight + currentCellValue;
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
				
				else if (j == obj_control.unitGrid_colWordIDList) {
					
					var currentCellValueSize = ds_list_size(currentCellValue);
					for (var k = 0; k < currentCellValueSize; k++) {
						var currentWordID = ds_list_find_value(currentCellValue, k);
						ds_list_replace(currentCellValue, k, currentWordID + originalWordGridHeight);
					}
				}
				
			}
			else if (originalGrid == obj_control.lineGrid) {
				if (j == obj_control.lineGrid_colUnitID) {
					currentCellValue = originalLineGridHeight + 1 + i;
				}
				else if (j == obj_control.lineGrid_colDisplayRow) {
					currentCellValue = originalLineGridHeight + 1 + i;
				}
				
				else if (j == obj_control.lineGrid_colWordIDList) {
					
					var currentCellValueSize = ds_list_size(currentCellValue);
					for (var k = 0; k < currentCellValueSize; k++) {
						var currentWordID = ds_list_find_value(currentCellValue, k);
						ds_list_replace(currentCellValue, k, currentWordID + originalWordGridHeight);
					}
				}
				
			}
			
			
			ds_grid_set(tempGrid, j, i, currentCellValue);
		}
	}
}



if (originalGrid == obj_control.dynamicWordGrid) {
	for (var i = 0; i < tempGridHeight; i++) {
		var currentReplaceWord = ds_grid_get(tempGrid, obj_control.dynamicWordGrid_colReplaceWord, i);
		if (typeof(currentReplaceWord) != "string") {
			ds_grid_set(tempGrid, obj_control.dynamicWordGrid_colReplaceWord, i, "");
		}
		
		
	}
	
	// if we can't find a single aligned word in the new grid, this is a glitch and we can set them all to aligned
	var alignedWord = ds_grid_value_y(tempGrid, obj_control.dynamicWordGrid_colAligned, 0, obj_control.dynamicWordGrid_colAligned, ds_grid_height(tempGrid), true);
	if (alignedWord < 0) {
		scr_setAllValuesInCol(tempGrid, obj_control.dynamicWordGrid_colAligned, true);
	}
}

if (ds_grid_height(obj_control.wordGrid) > 0 and ds_grid_height(obj_control.unitGrid) > 0) {
	with (obj_fileLoader) {
		alarm[4] = 10;
	}
}

if (originalGrid != global.importGrid || originalGrid != global.importCSVGrid ) {
	ds_grid_resize(originalGrid, ds_grid_width(originalGrid), originalGridHeight + ds_grid_height(tempGrid));
}
if (originalGrid == global.importGrid) {
	if (global.importGridWidth >= 0){
		ds_grid_resize(originalGrid, global.importGridWidth, originalGridHeight + ds_grid_height(tempGrid));
	}
}

if (originalGrid == global.importCSVGrid) {
	if (global.importCSVGridWidth >= 0){
		ds_grid_resize(originalGrid, global.importCSVGridWidth, originalGridHeight + ds_grid_height(tempGrid));
	}
}

ds_grid_set_grid_region(originalGrid, tempGrid, 0, 0, ds_grid_width(tempGrid), ds_grid_height(tempGrid), 0, originalGridHeight);
ds_grid_destroy(tempGrid);




var unitInStackGridHeight = ds_grid_height(obj_chain.unitInStackGrid);
for (var i = 0; i < unitInStackGridHeight; i++) {
	
	var currentCellString = scr_drawGridViewerGetItemString(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, i);
	
	if (real(string_digits(currentCellString)) > 0) {
		if (ds_grid_height(obj_chain.stackChainGrid) < 1) {
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, i, -1);
		}
	}
}
