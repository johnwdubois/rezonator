/*
	Purpose: Call the camera adjuster, show the display columns and the developer variables

*/

scr_windowSetCursor(cr_default);

// color theme control
scr_colorThemeControl();

// adjust view to window size
scr_windowCameraAdjust();

if (gridView) {
	exit;
}

if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(camera_get_active()) - 20, 200, camera_get_view_width(camera_get_active()), max(200, camera_get_view_height(camera_get_active())))) {
	mouseoverPanelPane = true;
}



// Turns on a grid of lines
if (showDisplayCols) {
	draw_set_alpha(0.25);
	draw_set_color(c_black);
	
	for (var i = 0; i < 20; i++) {
		var displayColX = wordLeftMargin + (i * gridSpaceHorizontal);
		draw_line(displayColX, 0, displayColX, room_height);
		draw_text(displayColX, 160, string(i));
	}
}


if (global.canScroll) {
	mouseoverNeutralSpace = true;
}

scr_mouseRect();

if (!hideAll) {
	scr_drawLine2ElectricBoogaloo();
}







// Shows variables used for in game bugtesting
if (showDevVars) {
	
	// draw line in center of screen
	draw_set_color(c_ltgray);
	draw_line(0, 150 + (camera_get_view_height(camera_get_active()) - 150) / 2, camera_get_view_width(camera_get_active()), 150 + (camera_get_view_height(camera_get_active()) - 150) / 2);
	
	// draw dev variables on right side of screen
	scr_drawDevVars();
}

var scrollBarMarginTop = 230;
if (!obj_panelPane.showNav) {
	scrollBarMarginTop -= inst_panelPane_help.windowHeight;
	if (!obj_toolPane.showTool) {
		scrollBarMarginTop -= obj_toolPane.windowHeight;
	}
}


// draw scrollbar for main screen!!
var drawScrollBar = false;
if (currentView != mainView) {
	drawScrollBar = true;
	scr_gridViewDrawBackArrow();
}
else {
	if (!hideAll) {
		drawScrollBar = true;
	}
	mouseoverBackArrow = false;
}

var toolbarX = camera_get_view_width(camera_get_active()) - global.toolPaneWidth;
if (!obj_toolPane.showTool) {
	toolbarX = camera_get_view_width(camera_get_active());
}


var audioBarHeight = (obj_audioUI.visible) ? obj_audioUI.windowHeight : 0;

// draw scrollbar based off of displayUnitList
var discourseSubMap = global.nodeMap[? global.discourseNode];
if (scr_isNumericAndExists(discourseSubMap, ds_type_map)) {
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	if (scr_isNumericAndExists(displayUnitList, ds_type_list)) {
		if (drawScrollBar and not obj_control.mouseoverHelpPane) {
			scr_scrollBar(ds_list_size(displayUnitList), -1, gridSpaceVertical, wordTopMargin,
				global.colorThemeSelected1, global.colorThemeSelected2,
				global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, toolbarX, camera_get_view_height(camera_get_active()) - audioBarHeight);
		}
	}
}