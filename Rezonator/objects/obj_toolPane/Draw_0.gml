/*
	Purpose: Draw the tool pane and all of its contents
*/



var camWidth = camera_get_view_width(camera_get_active());
var camHeight = camera_get_view_height(camera_get_active());
var toolbarHeight = camHeight - y;
var _toolSpriteScale = (toolbarHeight / 10) / 100;
toolSpriteScale = clamp(_toolSpriteScale, 0.25, 1);
var toolSprWidth = sprite_get_width(spr_toolsNew) * toolSpriteScale;


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
if (obj_toolPane.showTool) {
	draw_set_alpha(1);
	draw_set_color(make_color_rgb(125, 125, 128));
	draw_rectangle(x, y, camWidth,camHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, camWidth,camHeight, true);
	mouseOverToolPane = point_in_rectangle(mouse_x,mouse_y, x, y, camWidth,camHeight);

	scr_drawToolPane();
}


