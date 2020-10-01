// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_searchToMain(){
	obj_control.searchGridActive = false;
	var currentFocusLineSearch = scr_currentCenterLine() - 2;
	//show_message(currentFocusLineSearch);
	var currentFocusUnitID = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, currentFocusLineSearch);
	var currentFocusLine = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentFocusUnitID) + 1;
						
						
	// Check to see which grid we're switching back into
	if(obj_control.preSwitchLineGrid == obj_control.filterGrid) {
		scr_renderFilter(); // Thankfully this script does a lot of work for us
	}
	else {
		obj_control.currentActiveLineGrid = obj_control.lineGrid;
	}
	obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;//currentCenterDisplayRow;
		
	// Make sure we don't try to render a line that doesn't exist
	if(obj_control.highlightedSearchRow > 0 && ds_grid_value_exists(obj_control.preSwitchLineGrid, 0, 0, 0, ds_grid_height(obj_control.preSwitchLineGrid), obj_control.highlightedSearchRow)){
		var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, obj_control.highlightedSearchRow);
		show_debug_message(linePixelY);
		obj_control.preSwitchDisplayRow = -linePixelY + (obj_control.gridSpaceVertical / 2);
		show_debug_message(obj_control.preSwitchDisplayRow);
	}
	else {
		var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, currentFocusLine - 1);
		//show_message(linePixelY);
		obj_control.preSwitchDisplayRow = -linePixelY + (obj_control.gridSpaceVertical / 2);
	}
	//currentCenterDisplayRow = preSwitchDisplayRow;
	obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
		
	//wordLeftMarginDest = 170;
	with (obj_alarm) {
		alarm[0] = 5;
	}
}