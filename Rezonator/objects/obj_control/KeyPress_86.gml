/*
	obj_control: Key Press - V
	
	Last Updated: 2019-02-12
	
	Called from: User pressing 'V' key
	
	Purpose: Cycle between main screen and grid view, plus search screen if it exists
	
	Mechanism: DevVars: Uses 3-way toggle logic to activate/deactivate grids and adjust the left margin accordingly
	
	Author: Georgio Klironomos, Terry DuBois
*/

if (ds_grid_height(searchGrid) > 0) {
	if(gridView and currentActiveLineGrid == lineGrid) {
		searchGridActive = true;
		filterGridActive = false;
		currentActiveLineGrid = searchGrid;
		currentCenterDisplayRow = 0;
		wordLeftMarginDest = room_width / 2;
		
		gridView = !gridView;
	}
	else if(not gridView and currentActiveLineGrid == searchGrid) {
		searchGridActive = false;
		filterGridActive = false;
		currentActiveLineGrid = lineGrid;
		wordLeftMarginDest = 170;
	}
	else {
		gridView = !gridView;
	}
}
else {
	gridView = !gridView;
}