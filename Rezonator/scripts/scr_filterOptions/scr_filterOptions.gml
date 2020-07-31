var optionSelected = argument0;

switch (optionSelected)
{
	case "Toggle": // toggles the filter view on and off
		
	
		if (obj_control.filterGridActive) {
			if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
				//obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList);
				//obj_control.prevCenterYDest = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow);
				obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
				// Keep the focus on previous currentCenterDisplayRow
				//with (obj_control) {
				//	alarm[5] = 1;
				//}
			}
			
			// Switch to active grid
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
		}
		else {
			
			obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
			// If filter is unactive. activate it
			with (obj_control) {
				scr_renderFilter();
			}
		}
		// Add to moveCounter
		obj_control.moveCounter ++;
		
		instance_destroy(obj_dropDown);
	break;
	
	case "Context":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Prior", "Tween", "Next");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing)  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 19;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	
	case "Add": // add all of a certain chain type to filter
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Rez Chains", "Track Chains", "Stacks");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*2)  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 34;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
		break;
	default:
		break;
}