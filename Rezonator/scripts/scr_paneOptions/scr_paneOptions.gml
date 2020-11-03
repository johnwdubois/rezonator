function scr_paneOptions(argument0) {
	//paneOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Main":
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
					// Exit the stackShow
					if(obj_control.stackShowActive) {
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
			instance_destroy();
		break;
		case "Search":
		
			if (ds_grid_height(obj_control.searchGrid) > 0 and !obj_control.gridView) {
				// Main/filter to search
				if(obj_control.currentActiveLineGrid == obj_control.lineGrid) {// or currentActiveLineGrid == filterGrid) {
					scr_unFocusAllChains();
					
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
			//show_message("BUH 2");
		break;
		case "Nav": // Show/hide Nav Window
		
			
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Left", "Right", "Tools", "All");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				/*var dropDownInst = instance_create_depth(x + windowWidth , y+ optionSpacing, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = dropDownInst.optionListTypeNav;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;*/
				scr_createDropDown(x + windowWidth, y + optionSpacing, dropDownOptionList, obj_control.optionListTypeNav);
			}

			break;
		
		break;
		case "Grid": // show grid view
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
