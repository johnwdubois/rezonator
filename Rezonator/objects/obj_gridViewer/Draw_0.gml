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



var camViewWidth = camera_get_view_width(camera_get_active());
var camViewHeight = camera_get_view_height(camera_get_active());
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(0,0,camViewWidth,camViewHeight, false);



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