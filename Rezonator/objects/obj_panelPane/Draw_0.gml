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
if (currentFunction == functionTabs && !showNav) mouseover = false;

if (device_mouse_check_button_released(0, mb_left) and mouseover
and !obj_control.gridView and currentFunction != functionChainList and currentFunction != functionChainContents) {
	with (obj_chain) {
		scr_chainDeselect();
	}
}


// sync the left pane to the right pane when switching from 1-to-1 to 1-to-many
if (currentFunction == functionChainList) {
	if (chainViewOneToMany && scrollPlusY_RSync != -1) {
		scrollPlusYDest = scrollPlusY_RSync;
		scrollPlusY_RSync = -1;
	}
}
	
// sync the right pane to the left pane when switching from 1-to-many to 1-to-1
if (currentFunction == functionChainContents) {
	if (!chainViewOneToMany && scrollPlusY_LSync != -1) {
		scrollPlusYDest = scrollPlusY_LSync;
		scrollPlusY_LSync = -1;
	}
}