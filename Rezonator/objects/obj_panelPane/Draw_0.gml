/*
	Purpose: Create the visuals of the panel pane

*/

if (obj_control.gridView and currentFunction != functionHelp) {
	exit;
}
if (obj_control.hideAll) {
	exit;
}

scr_panelPaneDrawBranch();


// Checks mouseover for all panelPane windows
var mouseover = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);

if (device_mouse_check_button_released(0, mb_left) and mouseover
and !obj_control.gridView and currentFunction != functionChainList and currentFunction != functionChainContents) {
	with (obj_chain) {
		scr_chainDeselect();
	}
}