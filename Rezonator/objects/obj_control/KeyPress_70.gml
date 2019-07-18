///@description Activate Search
if (!shortcutsEnabled || obj_panelPane.discoSelectionActive) {
	exit;
}

// Activates word searching using search grid
//if(currentActiveLineGrid == lineGrid) {
preSwitchDisplayRow = currentCenterDisplayRow;
//}
preSwitchLineGrid = currentActiveLineGrid;
preSwitchSearchDisplayRow = 0;

if (!obj_control.dialougeBoxActive) {
	keyboard_string = "";
	fPressed = true;
}


dialougeBoxActive = true;

//have the input be here?


//scr_searchForWord();