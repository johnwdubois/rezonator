/*
	Purpose: Draw the tool pane and all of its contents
*/

var camWidth = camera_get_view_width(camera_get_active());
var camHeight = camera_get_view_height(camera_get_active());
var toolSprScale = 1;
var toolSprWidth = sprite_get_width(spr_toolsNew) * toolSprScale;

// toolpane positioning
global.toolPaneWidth = toolSprWidth * 1.85;
windowWidth = global.toolPaneWidth;
x = camera_get_view_width(camera_get_active()) - global.toolPaneWidth;
y = obj_control.wordTopMargin;

// don't draw if hideAll
if (obj_control.hideAll) {
	exit;
}

// draw toolpane BG and border
if (obj_panelPane.showNav && obj_toolPane.showTool) {
	draw_set_alpha(1);
	draw_set_color(global.colorThemeRezPurple);
	draw_rectangle(x, y, x + camWidth, y + camHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + camWidth, y + camHeight, true);
}


scr_drawToolPane();



progressBarX = camera_get_view_width(camera_get_active()) - 100;
