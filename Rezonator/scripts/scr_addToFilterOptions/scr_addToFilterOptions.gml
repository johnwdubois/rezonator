function scr_addToFilterOptions(optionSelected) {

	switch (optionSelected)
	{
		case "Rez": // toggles the filter view on and off
		var grid = obj_chain.rezChainGrid;
		if (ds_grid_value_exists(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)) {
				if (ds_grid_value_exists(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), false)) {
					ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true);
				}
				else {
					ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), false);
				}
			}
			else {
				ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true);
			}
				
				
			if (obj_control.filterGridActive) {
					
				with (obj_control) {
					scr_renderFilter();
				}
					
				if (not ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)
				and not ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)
				and not ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)) {
					
					with (obj_control) {
						searchGridActive = false;
						filterGridActive = false;
						currentActiveLineGrid = lineGrid;
						obj_toolPane.currentMode = obj_toolPane.setModeMain;
						wordLeftMarginDest = 170; // Make sure the margin is placed correctly

						with (obj_alarm) {
							alarm[1] = 5;
						}
					}
				}
			}
		
		
		break;
	
		case "Track":
	
		var grid = obj_chain.trackChainGrid;
		if (ds_grid_value_exists(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)) {
				if (ds_grid_value_exists(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), false)) {
					ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true);
				}
				else {
					ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), false);
				}
			}
			else {
				ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true);
			}
				
				
			if (obj_control.filterGridActive) {
					
				with (obj_control) {
					scr_renderFilter();
				}
					
				if (not ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)
				and not ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)
				and not ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)) {
					
					with (obj_control) {
						searchGridActive = false;
						filterGridActive = false;
						currentActiveLineGrid = lineGrid;
						obj_toolPane.currentMode = obj_toolPane.setModeMain;
						wordLeftMarginDest = 170; // Make sure the margin is placed correctly

						with (obj_alarm) {
							alarm[1] = 5;
						}
					}
				}
			}
		

		break;

		case "Stack": // add all of a certain chain type to filter
		var grid = obj_chain.stackChainGrid;
		if (ds_grid_value_exists(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)) {
				if (ds_grid_value_exists(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), false)) {
					ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true);
				}
				else {
					ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), false);
				}
			}
			else {
				ds_grid_set_region(grid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true);
			}
				
				
			if (obj_control.filterGridActive) {
					
				with (obj_control) {
					scr_renderFilter();
				}
					
				if (not ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)
				and not ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)
				and not ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(grid), true)) {
					
					with (obj_control) {
						searchGridActive = false;
						filterGridActive = false;
						currentActiveLineGrid = lineGrid;
						obj_toolPane.currentMode = obj_toolPane.setModeMain;
						wordLeftMarginDest = 170; // Make sure the margin is placed correctly

						with (obj_alarm) {
							alarm[1] = 5;
						}
					}
				}
			}
		

	
	
		break;
	
		default:
		break;
	}


}
