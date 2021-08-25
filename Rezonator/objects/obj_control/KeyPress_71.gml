///@description GoToLine / gridview
// Check for gridView switch first
if (global.ctrlHold and !gridView) {
		gridView = true;
}
else if (gridView) {
	gridView = false;
}
else {
	scr_jumpToLineCalled();
}