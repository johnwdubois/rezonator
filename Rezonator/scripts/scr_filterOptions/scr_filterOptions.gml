function scr_filterOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_filter": // toggles the filter view on and off
		
	
			if (obj_control.filterGridActive) {
				if (obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
					obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
				}
			
				// Switch to active grid
				obj_control.filterGridActive = false;
				obj_control.currentActiveLineGrid = obj_control.lineGrid;
			}
			else {
			
				obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
				// If filter is unactive. activate it
				with (obj_control) {
					scr_renderFilter2();
				}
			}
			// Add to moveCounter
			obj_control.moveCounter++;
			with (obj_dropDown) {
				instance_destroy();
			}
			break;
	
		case "menu_filter-context":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_above", "menu_between", "menu_below");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing*2), dropDownOptionList, global.optionListTypeContext);
			}
			break;
	
		case "menu_pick": // add all of a certain chain type to filter
		
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_resonance", "menu_track", "menu_stack");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing), dropDownOptionList, global.optionListTypeAddToFilter);
			}
			break;
		case "menu_clear": // add all of a certain chain type to filter	
			scr_setValueForAllChains("resonance", "filter", false);
			scr_setValueForAllChains("trail", "filter", false);
			scr_setValueForAllChains("stack", "filter", false);
			scr_updateFilteredChainLists();
			
			if (obj_control.filterGridActive) {
				if(obj_control.currentCenterDisplayRow >= 0) { // Make sure the current center display row is within bounds
					// Keep the focus on previous currentCenterDisplayRow
					with (obj_control) {
						alarm[5] = 3;
					}
				}
				obj_control.filterGridActive = false;
				obj_control.currentActiveLineGrid = obj_control.lineGrid;
			}
			with (obj_dropDown) {
				instance_destroy();
			}
			break;
		default:
			break;
	}


}
