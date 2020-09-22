///@description Main/Search/Grid Cycle
/*
	obj_control: Key Press - V
	
	Last Updated: 2019-02-12
	
	Called from: User pressing 'V' key
	
	Purpose: Cycle between main screen and grid view, plus search screen if it exists
	
	Mechanism: DevVars: Uses 3-way toggle logic to activate/deactivate grids and adjust the left margin accordingly
	
	Author: Georgio Klironomos, Terry DuBois
*/
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

// Check for gridView switch first
if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and !gridView) {
		gridView = true;
}
else if (gridView) {
	gridView = false;
}
// If we're not in grid view and there is a search, switch between the main and search screen
else if (ds_grid_height(searchGrid) > 0 and !gridView) {
	// Main/filter to search
	if(currentActiveLineGrid == lineGrid) {// or currentActiveLineGrid == filterGrid) {
		scr_unFocusAllChains();
		// Which grid are we switching from?
		preSwitchLineGrid = currentActiveLineGrid; 
		searchGridActive = true;
		currentActiveLineGrid = searchGrid;
		// Which row are we switching from?
		preSwitchDisplayRow = obj_control.scrollPlusYDest;//currentCenterDisplayRow; 
		highlightedSearchRow = 0;
		//currentCenterDisplayRow = preSwitchSearchDisplayRow;
		obj_control.scrollPlusYDest  = preSwitchSearchDisplayRow;
	//	var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, currentCenterDisplayRow);
		//obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
		
		wordLeftMarginDest = window_get_width() / 2;
	}
	// Switch back to either main or filter grids
	else if(currentActiveLineGrid == searchGrid) { 
		searchGridActive = false;
		
		// Check to see which grid we're switching back into
		if(preSwitchLineGrid == filterGrid) {
			scr_renderFilter(); // Thankfully this script does a lot of work for us
		}
		else {
			currentActiveLineGrid = lineGrid;
		}
		preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;//currentCenterDisplayRow;
		
		// Make sure we don't try to render a line that doesn't exist
		if(highlightedSearchRow > 0 && ds_grid_value_exists(preSwitchLineGrid, 0, 0, 0, ds_grid_height(preSwitchLineGrid), highlightedSearchRow)){
			var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, highlightedSearchRow);
			preSwitchDisplayRow = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
		}
		//currentCenterDisplayRow = preSwitchDisplayRow;
		obj_control.scrollPlusYDest = preSwitchDisplayRow;
		
		//wordLeftMarginDest = 170;
		with (obj_alarm) {
			alarm[0] = 5;
		}
	}
	// Give the user another way to leave the filter view
	else if(currentActiveLineGrid == filterGrid) { 
		// Exit the stackShow
		if(stackShowActive) {
			obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList)-1;
			scr_stackShow();
		}
		// Exit the plain filter
		else {
			// Remember the user's place
			if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
				obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
			}
			
			// Switch to active grid
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid
		}
		
		with (obj_alarm) {
			alarm[1] = 5;
		}
	}
}
// Give the user another way to leave the filter view (when the searchGrid is inactive)
else if(currentActiveLineGrid == filterGrid) { 
	// Exit the stackShow
	if(stackShowActive) {
		obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList)-1;
		scr_stackShow();
	}
	// Exit the plain filter
	else {
		// Remember the user's place
		if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
			obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
		}
			
		// Switch to active grid
		obj_control.filterGridActive = false;
		obj_control.currentActiveLineGrid = obj_control.lineGrid
	}
	
	with (obj_alarm) {
		alarm[1] = 5;
	}
}


