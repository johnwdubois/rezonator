var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var rowHeight = string_height("A") * 1.3;

// Ignore window
var ignoreWindowRectX1 = 40;
var ignoreWindowRectY1 = (camHeight / 2) - 100;
var ignoreWindowRectX2 = (camWidth / 2) + 50;
var ignoreWindowRectY2 = camHeight - 150;



windowWidth = clamp(ignoreWindowRectX2 - ignoreWindowRectX1, 48, 2000);
windowHeight = clamp(ignoreWindowRectY2 - ignoreWindowRectY1, 48, 1500);
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




// Draw Ignore window contents
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var mouseoverRow = -1;

var plusY = ignoreWindowRectY1 + rowHeight;
for (var i = 0; i < ds_list_size(global.importFileRipList); i++) {
	
	var rowX1 = ignoreWindowRectX1;
	var rowY1 = plusY;
	var rowX2 = ignoreWindowRectX2;
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
draw_text(ignoreWindowRectX1, floor(ignoreWindowRectY1 - string_height("0")), "Ignore");


draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(ignoreWindowRectX1, ignoreWindowRectY1, ignoreWindowRectX2, ignoreWindowRectY2, true);