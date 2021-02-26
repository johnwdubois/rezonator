/*
	Purpose: Draw the tool pane and all of its contents
*/
if (live_call()) return live_result;

var camWidth = camera_get_view_width(camera_get_active());
var camHeight = camera_get_view_height(camera_get_active());
var toolSprScale = clamp(camWidth / 2500, 0.6, 1);
var toolSprWidth = sprite_get_width(spr_toolsNew) * toolSprScale;

show_debug_message("toolSprScale:" + string(toolSprScale));

// toolpane positioning
global.toolPaneWidth = toolSprWidth * 2;
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


scr_drawToolPane(toolSprScale);



progressBarX = camera_get_view_width(camera_get_active()) - 100;
