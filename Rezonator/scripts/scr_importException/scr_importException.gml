var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var rowHeight = string_height("A") * 1.3;

// exception window
var exceptionWindowRectX1 = 40;
var exceptionWindowRectY1 = (camHeight / 2) - 100;
var exceptionWindowRectX2 = (camWidth / 2) + 50;
var exceptionWindowRectY2 = camHeight - 150;



windowWidth = clamp(exceptionWindowRectX2 - exceptionWindowRectX1, 48, 2000);
windowHeight = clamp(exceptionWindowRectY2 - exceptionWindowRectY1, 48, 1500);
clipWidth = windowWidth;
clipHeight = windowHeight;
	
windowX = x;
windowY = y;
clipX = x;
clipY = y;



// surface begin
if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}

scr_windowCameraAdjust();

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);




// Draw exception window contents
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var mouseoverRow = -1;

var plusY = exceptionWindowRectY1 + rowHeight;
for (var i = 0; i < ds_list_size(global.importFileRipList); i++) {
	
	var rowX1 = exceptionWindowRectX1;
	var rowY1 = plusY;
	var rowX2 = exceptionWindowRectX2;
	var rowY2 = plusY + rowHeight;
	
	var currentRowStr = string(ds_list_find_value(global.importFileRipList, i));
	draw_text(floor(rowX1 + 20) - clipX, floor(mean(rowY1, rowY2)) - clipY, currentRowStr);
	
	plusY += rowHeight;
	
}









// surface end
surface_reset_target();
draw_surface(clipSurface, clipX, clipY);




draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(exceptionWindowRectX1, floor(exceptionWindowRectY1 - string_height("0")), "exception");


draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(exceptionWindowRectX1, exceptionWindowRectY1, exceptionWindowRectX2, exceptionWindowRectY2, true);