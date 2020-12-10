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


// If we're not in grid view and there is a search, switch between the main and search screen
if (ds_grid_height(searchGrid) > 0 and !gridView) {
	// Main/filter to search
	if(currentActiveLineGrid == lineGrid) {
		scr_unFocusAllChains();
		
		// Which grid are we switching from?
		preSwitchLineGrid = currentActiveLineGrid; 
		searchGridActive = true;
		currentActiveLineGrid = searchGrid;
		obj_toolPane.currentMode = obj_toolPane.setModeSearch;
		
		// Which row are we switching from?
		preSwitchDisplayRow = obj_control.scrollPlusYDest;
		highlightedSearchRow = 0;
		obj_control.scrollPlusYDest  = preSwitchSearchDisplayRow;
		
		wordLeftMarginDest = window_get_width() / 2;
	}
	// Switch back to either main or filter grids
	else if(currentActiveLineGrid == searchGrid) { 
		// Switch back to the main screen from the Search Screen
		scr_searchToMain();
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


