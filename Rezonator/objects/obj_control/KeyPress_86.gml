///@description Main/Search/Grid Cycle
/*
	obj_control: Key Press - V
	
	Last Updated: 2019-02-12
	
	Called from: User pressing 'V' key
	
	Purpose: Cycle between main screen and grid view, plus search screen if it exists
	
	Mechanism: DevVars: Uses 3-way toggle logic to activate/deactivate grids and adjust the left margin accordingly
	
	Author: Georgio Klironomos, Terry DuBois
*/
if (!shortcutsEnabled) {
	exit;
}

// Check for gridView switch first
if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and !gridView) {
		gridView = true;
}
else if(gridView) {
	gridView = false;
}// If we're not in grid view and there is a search, switch between the main and search screen
else if (ds_grid_height(searchGrid) > 0 and !gridView) {
	// Main/filter to search
	if(currentActiveLineGrid == lineGrid or currentActiveLineGrid == filterGrid) { 
		preSwitchLineGrid = currentActiveLineGrid; // Which grid are we switching from?
		searchGridActive = true;
		currentActiveLineGrid = searchGrid;
		preSwitchDisplayRow = currentCenterDisplayRow; // Which row are we switching from?
		highlightedSearchRow = 0;
		currentCenterDisplayRow = preSwitchSearchDisplayRow;
		
		wordLeftMarginDest = window_get_width() / 2;
	}// Switch back to either main or filter grids
	else if(currentActiveLineGrid == searchGrid) { 
		searchGridActive = false;
		// Check to see which grid we're switching back into
		if(preSwitchLineGrid == filterGrid) {
			scr_renderFilter(); // Thankfully this script does a lot of work for us
		}
		else {
			currentActiveLineGrid = lineGrid;
		}
		preSwitchSearchDisplayRow = currentCenterDisplayRow;
		if(highlightedSearchRow > 0 && ds_grid_value_exists(preSwitchLineGrid, 0, 0, 0, ds_grid_height(preSwitchLineGrid), highlightedSearchRow)){
			preSwitchDisplayRow = highlightedSearchRow; // Make sure we don't try to render a line that doesn't exist
		}
		currentCenterDisplayRow = preSwitchDisplayRow;
		wordLeftMarginDest = 170;
	}
}
