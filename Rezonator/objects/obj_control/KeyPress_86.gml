///@description Main/Search/Grid Cycle
/*
	Purpose: Cycle between main screen and grid view, plus search screen if it exists
*/
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

if (searchGridActive) {
	searchGridActive = false;
	scr_disableFilter();
}
else {
	searchGridActive = true;
	scr_renderFilter2();
}


/*
// If we're not in grid view and there is a search, switch between the main and search screen
if (ds_grid_height(searchGrid) > 0 and !gridView) {
	// Main/filter to search
	if(currentActiveLineGrid == lineGrid) {
		scr_unFocusAllChains();
		
		// Which grid are we switching from?
		preSwitchLineGrid = currentActiveLineGrid; 
		searchGridActive = true;
		currentActiveLineGrid = searchGrid;
		
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

		// Exit the plain filter
		// Remember the user's place
		if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
			obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
		}
			
		// Switch to active grid
		obj_control.filterGridActive = false;
		obj_control.currentActiveLineGrid = obj_control.lineGrid

		
		with (obj_alarm) {
			alarm[1] = 5;
		}
	}
}
// Give the user another way to leave the filter view (when the searchGrid is inactive)
else if(currentActiveLineGrid == filterGrid) { 

	// Exit the plain filter
	// Remember the user's place
	if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
		obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
	}
			
	// Switch to active grid
	obj_control.filterGridActive = false;
	obj_control.currentActiveLineGrid = obj_control.lineGrid

	
	with (obj_alarm) {
		alarm[1] = 5;
	}
}
*/