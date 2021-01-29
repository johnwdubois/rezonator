/// @description Create Sent Stacks


if(obj_toolPane.currentMode == obj_toolPane.modeRead) {
	obj_toolPane.currentMode = obj_toolPane.modeTrack;	
	if(obj_control.searchGridActive) {
		obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
	}
	else {
		obj_toolPane.setModeMain = obj_toolPane.modeTrack;
	}
}

obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabStackBrush;
			
// unfocus chains of all type
scr_unFocusAllChains();
			
//refocus chains related to currently selected tab
/*
with(obj_panelPane) {
	scr_reFocusOldChains();
}
*/
currentStackerFuntion = stackerFunctionSent;

alarm[5] = 2;