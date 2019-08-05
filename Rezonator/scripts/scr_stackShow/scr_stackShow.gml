/*
	scr_stackShow();
	
	Last Updated: 2019-07-24
	
	Called from: obj_dialogueBox
	
	Purpose: Cycle through showing off user selected stacks one at a time.
	
	Mechanism: loop through the stackShowList, filtering on one stack only, 
				and hop back to the main screen once we reach the end of the list.
	
	Author: Georgio Klironomos
*/

// If we are still within the bounds of the list
if(ds_list_size(obj_control.stackShowList) > 0 && obj_control.currentStackShowListPosition != (ds_list_size(obj_control.stackShowList))) {
	obj_control.stackShowActive = true;
	// If we are not on the first element of the list, then unfilter the previous stack
	if(obj_control.currentStackShowListPosition > 0) {
		var prevStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition - 1);
		var prevStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), prevStackID);
		ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, prevStackRow, false);
	}
	
	// Filter the current stack
	var currentStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition);
	var currentStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentStackID);
	ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, currentStackRow, true);
			
	// Render the filter in the mainscreen
	with (obj_control) {
		scr_renderFilter();
	}
	
	// Increment our position in the list
	if(obj_control.currentStackShowListPosition > 1 and obj_control.stackShowBackwards){
		obj_control.currentStackShowListPosition--;
	}
	else{
		obj_control.currentStackShowListPosition++;
	}
	
}
// If we are at the end of the list, then hop out of the filter
else if(obj_control.currentStackShowListPosition == (ds_list_size(obj_control.stackShowList))) {
	obj_control.stackShowActive = false;
	obj_toolPane.tracksOnlyStackShow = false;
	with(obj_panelPane){
		alarm[5] = -1;
	}
	obj_panelPane.timerMins = 0;
	obj_panelPane.timerSecs = 0;
	//Set currentStackShowListPosition to -1
	obj_control.currentStackShowListPosition = -1;
	
	//Clear stackShowList
	ds_list_clear(obj_control.stackShowList);
	
	// Exit the filter
	ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
	
	// Switch to active grid
	//obj_dialogueBox.stackShowWindowActive = false;
	obj_control.filterGridActive = false;
	obj_control.currentActiveLineGrid = obj_control.lineGrid;
	obj_control.scrollPlusYDest = obj_control.prevCenterDisplayRow;
}