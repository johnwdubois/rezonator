/// @description Create Turn Stacks

// So I gotta loop through the tokenImport grid, checking for units to collect into the list, and checking for new turns to swap lists
// It works!! But that stack bug is getting in the way...

if(obj_toolPane.currentMode == obj_toolPane.modeRead) {
	obj_toolPane.currentMode = obj_toolPane.modeTrack;	
}

obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabStackBrush;
			
// unfocus chains of all type
scr_unFocusAllChains();
			
//refocus chains related to currently selected tab
with(obj_panelPane) {
	scr_reFocusOldChains();
}

currentStackerFuntion = stackerFunctionTurn;

alarm[5] = 2;