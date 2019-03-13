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
else if(ds_grid_height(searchGrid) > 0 and !gridView) {
	// Main to search
	if(currentActiveLineGrid == lineGrid) { 
		searchGridActive = true;
		filterGridActive = false;
		currentActiveLineGrid = searchGrid;
		preSwitchDisplayRow = currentCenterDisplayRow;
		highlightedSearchRow = 0;
		currentCenterDisplayRow = preSwitchSearchDisplayRow;
		
		wordLeftMarginDest = window_get_width() / 2;
	}// Search to main
	else if(currentActiveLineGrid == searchGrid) { 
		searchGridActive = false;
		filterGridActive = false;
		currentActiveLineGrid = lineGrid;
		preSwitchSearchDisplayRow = currentCenterDisplayRow;
		currentCenterDisplayRow = preSwitchDisplayRow;
		wordLeftMarginDest = 170;
	}
}
