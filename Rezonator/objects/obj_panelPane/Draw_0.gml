/*
	Purpose: Create the visuals of the panel pane

*/

if (!obj_control.mouseoverPanelPane) {
	unitTagsHighlightRow = -1;
}
if (currentFunction != functionChainList) {
	if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (currentFunction == functionChainContents) {
			if (!obj_control.showUnitTags) {
				with (obj_panelPane) {
					unitTagsHighlightRow = -1;
				}
			}
		}
		else {
			with (obj_panelPane) {
				unitTagsHighlightRow = -1;
			}
		}
	}
}


if (obj_control.gridView and currentFunction != functionHelp) {
	exit;
}
if (obj_control.hideAll) {
	exit;
}


scr_panelPaneDrawBranch();



// draw pane border
if(obj_panelPane.showNav){

	draw_set_alpha(1);
	draw_set_color(global.colorThemeBorders);
	
	var showBorder = !((currentFunction == functionChainContents && !obj_panelPane.showNavRight)
					|| (currentFunction == functionHelp)
					|| ((currentFunction == functionChainList) && !obj_panelPane.showNavLeft));

	if (showBorder) {
		if (currentFunction == functionHelp) {
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
		}
		else {
			draw_line(x, y + windowHeight, x + windowWidth, y + windowHeight);
			
			var divideLineX = (currentFunction == functionChainList) ? x + windowWidth : x;
			draw_line(divideLineX, y + functionTabs_tabHeight, divideLineX, y + windowHeight);
		}
	}
}


// Checks mouseover for all panelPane windows
var mouseover = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);

if (device_mouse_check_button_released(0, mb_left) and mouseover
and !obj_control.gridView and currentFunction != functionChainList and currentFunction != functionChainContents) {
	with (obj_chain) {
		scr_chainDeselect();
	}
}