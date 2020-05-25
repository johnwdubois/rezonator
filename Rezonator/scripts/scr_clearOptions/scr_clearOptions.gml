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
			
		//show_message("Coming Soon");
	break;
	case "Filter":// clear current picks
		show_message("Coming Soon");
	break;
	default:
	break;
	
}