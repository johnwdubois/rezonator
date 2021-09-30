///@description Main/Search/Grid Cycle
/*
	Purpose: Cycle between main screen and grid view, plus search screen if it exists
*/
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

if (searchGridActive) {
	searchGridActive = false;
	scr_disableFilter();
}
else {
	searchGridActive = true;
	scr_renderFilter2();
}