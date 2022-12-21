///@description Main/Search/Grid Cycle
/*
	Purpose: Cycle between main screen and grid view, plus search screen if it exists
*/

obj_control.quickPickedChainID = "";

var altShitft = keyboard_check(vk_alt) and keyboard_check(vk_shift);

if (altShitft and !gridView) {
	gridView = true;
}
else if (altShitft and gridView) {
	gridView = false;
}


if ((!shortcutsEnabled || dialogueBoxActive) or altShitft or (obj_panelPane.functionSearchList_searchSelected == "")) {
	exit;
}

if (obj_control.currentView == obj_control.searchView) {
	obj_control.currentView = obj_control.mainView;
	scr_disableFilter();
}
else {
	obj_control.currentView = obj_control.searchView;
	scr_renderFilter2();
}