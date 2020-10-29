///@description End Chain Use
// End chain adding/use
//if (obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabLine and (obj_panelPane.functionChainList_lineGridRowFocused > 0 and obj_panelPane.functionChainList_lineGridRowFocused < ds_grid_height(obj_control.lineGrid))) {
scr_chainDeselect();

scr_refreshVizLinkGrid();
//}

// Well we can't have both of these at the same time
/*
if (obj_control.gridView) {
	obj_control.gridView = false;
}
// If we're not in grid view and there is a search, switch between the main and search screen
else if (ds_grid_height(obj_control.searchGrid) > 0 and !obj_control.gridView) {
	with(obj_control) {
		// Switch back to either main or filter grids
		if(currentActiveLineGrid == searchGrid) { 
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
}
else if(obj_control.currentActiveLineGrid == obj_control.filterGrid) { 
	with(obj_control) {
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
*/