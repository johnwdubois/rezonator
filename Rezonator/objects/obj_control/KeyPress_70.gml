///@description Activate Search
if (!shortcutsEnabled) {
	exit;
}

// Activates word searching using search grid
//if(currentActiveLineGrid == lineGrid) {
preSwitchDisplayRow = currentCenterDisplayRow;
//}
preSwitchLineGrid = currentActiveLineGrid;
preSwitchSearchDisplayRow = 0;
//have the input be here?
scr_searchForWord();