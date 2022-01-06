///@description Main/Search/Grid Cycle
/*
	Purpose: Cycle between main screen and grid view, plus search screen if it exists
*/
if (!shortcutsEnabled || dialogueBoxActive) {
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