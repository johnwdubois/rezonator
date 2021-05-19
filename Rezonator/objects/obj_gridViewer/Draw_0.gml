// Draws the scroll together button in grid view and handles funtionality, calls funtion to draw both grids

if (notRefreshed){
	alarm[0] = 1;
	alarm[1] = 1;
	notRefreshed = false;
}


if (!obj_control.gridView) {
	exit;
	notRefreshed = true
}
else{
	notRefreshed = false;
}
obj_control.hoverTokenID = "";

var scrollTogetherButtonX = 100;
var scrollTogetherButtonY = 100;
var mapViewerButtonRectX1 = scrollTogetherButtonX - 15;
var mapViewerButtonRectY1 = scrollTogetherButtonY - 15;
var mapViewerButtonRectX2 = scrollTogetherButtonX + 15;
var mapViewerButtonRectY2 = scrollTogetherButtonY + 15;

var mouseOverMapViewer = point_in_rectangle(mouse_x, mouse_y, mapViewerButtonRectX1, mapViewerButtonRectY1, mapViewerButtonRectX2, mapViewerButtonRectY2)
if (mouseOverMapViewer) {
	if(device_mouse_check_button_released(0,mb_left)){
		mapViewActive = !mapViewActive;
	}
}


var camViewWidth = camera_get_view_width(camera_get_active());
var camViewHeight = camera_get_view_height(camera_get_active());
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(0,0,camViewWidth,camViewHeight, false);
draw_set_color(global.colorThemeBorders);
//draw_rectangle(20,windowY,windowX,windowY + windowHeight, true);

draw_set_color(global.colorThemeText);
var checkBoxScale = 1* max(global.fontSize,3)/5;
scr_drawRectWidth(mapViewerButtonRectX1, mapViewerButtonRectY1, mapViewerButtonRectX2, mapViewerButtonRectY2, 3, true);
if(!mapViewActive) draw_sprite_ext(spr_checkmark, 0, mean(mapViewerButtonRectX1, mapViewerButtonRectX2), mean(mapViewerButtonRectY1, mapViewerButtonRectY2), checkBoxScale , checkBoxScale , 0, c_white, 1);


draw_text(mapViewerButtonRectX2 + 10, mean(mapViewerButtonRectY1, mapViewerButtonRectY2), (mapViewActive)? "MapView":"GridView");



draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

//for (var i = 0; i < currentGrids; i++) {
//	windowX[i] = ((window_get_width() / currentGrids) * i) + 20;
//	windowWidth[i] = (window_get_width() / currentGrids) - 20;
if(!obj_gridViewer.mapViewActive){
	scr_drawGridViewerClipped();
}
scr_gridViewDrawBackArrow();
//}