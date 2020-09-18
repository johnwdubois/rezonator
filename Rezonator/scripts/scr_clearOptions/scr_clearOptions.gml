function scr_clearOptions(argument0) {
	//clearOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Search":// clear current search
					
					
			ds_grid_copy(obj_control.searchGrid, obj_control.emptySearchGrid);
			ds_grid_copy( obj_control.hitGrid,obj_control.emptyHitGrid);
			
			
			obj_control.searchGridActive = false;
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
			//obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;
			//obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
			with (obj_alarm) {
				alarm[0] = 5;
			}	
			//instance_destroy(obj_dropDown);
		break;
		case "Filter":// clear current picks
			ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.rezChainGrid), false);
			ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
			ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.trackChainGrid), false);
			//instance_destroy(obj_dropDown);
		break;
		default:
		break;
	
	}


}
