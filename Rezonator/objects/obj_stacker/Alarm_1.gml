/// @description Create Random Stacks
// You can write your code in this editor
with (obj_toolPane) {
	currentMode = modeRez;
	if (obj_control.currentView == obj_control.searchView) {
		obj_toolPane.setModeSearch = obj_toolPane.modeRez;
	}
	else {
		obj_toolPane.setModeMain = obj_toolPane.modeRez;
	}
}
with (obj_panelPane) {
	functionChainList_currentTab = NAVTAB_STACK;
}
			
scr_chainDeselect();
			
//refocus chains related to currently selected tab
/*
with (obj_panelPane) {
	scr_reFocusOldChains();
}
*/

// Got to fix this somehow...
//obj_fileLoader.subLineGridBeginning = string_digits(ds_list_find_value(obj_control.listOfNumbers, 0));
//obj_fileLoader.subLineGridEnd 
endLine = ds_grid_height(obj_control.lineGrid) - 1;
randUnit = -1;
stackerRandomCurrentUnitList = ds_list_create();
ds_list_clear(stackerRandomCurrentUnitList);

show_debug_message("obj_stacker Alarm1 ... randLine1: " + string(randLine1) + ", randLine2: " + string(randLine2) + ", endLine: " + string(endLine));

currentStackerFuntion = stackerFunctionRandom;
alarm[5] = 2;