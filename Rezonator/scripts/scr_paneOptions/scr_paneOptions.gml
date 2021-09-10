function scr_paneOptions(optionSelected) {
	//paneOptions

	switch (optionSelected)
	{
		case "menu_main":
			if (obj_control.gridView) {
				obj_control.gridView = false;
				if (ds_grid_height(obj_control.searchGrid) > 0 ) {

				// Switch back to either main or filter grids
					if(obj_control.currentActiveLineGrid == obj_control.searchGrid) { 
						obj_control.searchGridActive = false;
		
						obj_control.currentActiveLineGrid = obj_control.lineGrid;
						obj_toolPane.currentMode = obj_toolPane.setModeMain;
						obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;//currentCenterDisplayRow;
		
						//currentCenterDisplayRow = preSwitchDisplayRow;
						obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
		
						//wordLeftMarginDest = 170;
						with (obj_alarm) {
							alarm[0] = 5;
						}
					}
				}
			}
			// If we're not in grid view and there is a search, switch between the main and search screen
			else if (ds_grid_height(obj_control.searchGrid) > 0 and !obj_control.gridView) {

				// Switch back to either main or filter grids
				if(obj_control.currentActiveLineGrid == obj_control.searchGrid) { 
					// Switch back to the main screen from the Search Screen
					scr_searchToMain();
				}
				// Give the user another way to leave the filter view
				else if(obj_control.currentActiveLineGrid == obj_control.filterGrid) { 

					// Exit the plain filter
					// Remember the user's place
					if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
						obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
					}
			
					// Switch to active grid
					obj_control.filterGridActive = false;
					obj_control.currentActiveLineGrid = obj_control.lineGrid

				}
			}
			instance_destroy();
		break;
		case "menu_search":
		
			if (ds_grid_height(obj_control.searchGrid) > 0 and !obj_control.gridView) {
				// Main/filter to search
				if(obj_control.currentActiveLineGrid == obj_control.lineGrid) {// or currentActiveLineGrid == filterGrid) {
					scr_chainDeselect();
					
					// Which grid are we switching from?
					obj_control.preSwitchLineGrid = obj_control.currentActiveLineGrid; 
					obj_control.searchGridActive = true;
					obj_control.currentActiveLineGrid = obj_control.searchGrid;
					obj_toolPane.currentMode = obj_toolPane.setModeSearch;
					
					// Which row are we switching from?
					obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
					obj_control.highlightedSearchRow = 0;
					obj_control.scrollPlusYDest  = obj_control.preSwitchSearchDisplayRow;
		
					obj_control.wordLeftMarginDest = window_get_width() / 2;
				}
			}
			instance_destroy();

		break;
		case "menu_nav": // Show/hide Nav Window
		
			
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_left", "menu_right", "menu_nav", "menu_tools", "menu_all");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(x + windowWidth, y, dropDownOptionList, global.optionListTypeNav);
			}

			break;
		
		break;
		case "menu_grid": // show grid view
			obj_control.gridView = !obj_control.gridView;
			instance_destroy();
		break;
		case "Dev": // show grid view
			obj_control.showDevVars = !obj_control.showDevVars;
			obj_control.showFPS = !obj_control.showFPS;
			instance_destroy();
		break;
	}


}
