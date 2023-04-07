/// @description Create Group Stacks
// You can write your code in this editor


if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
	obj_toolPane.currentMode = obj_toolPane.modeTrack;
	if (obj_control.currentView == obj_control.searchView) {
		obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
	}
	else {
		obj_toolPane.setModeMain = obj_toolPane.modeTrack;
	}
}

obj_panelPane.functionChainList_currentTab = NAVTAB_STACK;
			
// unfocus chains of all type
scr_chainDeselect();
			
//refocus chains related to currently selected tab
/*
with (obj_panelPane) {
	scr_reFocusOldChains();
}
*/

currentStackerFuntion = stackerFunctionGroup;
alarm[5] = 2;