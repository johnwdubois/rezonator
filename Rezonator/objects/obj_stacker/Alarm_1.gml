/// @description Create Random Stacks
// You can write your code in this editor
with (obj_toolPane) {
	currentMode = modeRez;
}
with (obj_panelPane) {
	functionChainList_currentTab = functionChainList_tabStackBrush;
}
			
scr_unFocusAllChains();
			
//refocus chains related to currently selected tab
with (obj_panelPane) {
	scr_reFocusOldChains();
}

endLine = ds_grid_height(obj_control.lineGrid) - 1;
randUnit = -1;
stackerRandomCurrentUnitList = ds_list_create();
ds_list_clear(stackerRandomCurrentUnitList);

show_debug_message("obj_stacker Alarm1 ... randLine1: " + string(randLine1) + ", randLine2: " + string(randLine2) + ", endLine: " + string(endLine));

currentStackerFuntion = stackerFunctionRandom;
alarm[5] = 2;