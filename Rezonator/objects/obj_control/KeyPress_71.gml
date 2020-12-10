///@description GoToLine / gridview
// Check for gridView switch first
if (keyboard_check(vk_control) and !gridView) {
		gridView = true;
}
else if (gridView) {
	gridView = false;
}
else {
	scr_jumpToLineCalled();
}