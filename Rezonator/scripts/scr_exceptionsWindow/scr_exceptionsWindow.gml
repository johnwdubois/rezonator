var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);


// Exceptions window
var exceptionsInfoWindowRectX1 = (camWidth * 0.666) + 20;
var exceptionsInfoWindowRectY1 = 80 + string_height("0");
var exceptionsInfoWindowRectX2 = camWidth - 40;
var exceptionsInfoWindowRectY2 = (camHeight / 2) - 180;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(exceptionsInfoWindowRectX1, exceptionsInfoWindowRectY1, exceptionsInfoWindowRectX2, exceptionsInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(exceptionsInfoWindowRectX1, exceptionsInfoWindowRectY1 - string_height("0"), "Exceptions");



// abbreviated surfaceStart()
windowWidth = clamp(exceptionsInfoWindowRectX2 - exceptionsInfoWindowRectX1, 48, 2000);
windowHeight = clamp(exceptionsInfoWindowRectY2 - exceptionsInfoWindowRectY1, 48, 1500);
clipWidth = windowWidth;
clipHeight = windowHeight;

x = exceptionsInfoWindowRectX1;
y = exceptionsInfoWindowRectY1;
windowX = x;
windowY = y;
clipX = x;
clipY = y;

if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}

scr_windowCameraAdjust();

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);






// draw all exception lines
var plusY = string_height("0");
draw_set_font(fnt_chainContents);;
for (var i = 0; i < ds_list_size(exceptionStringList); i++) {
	var currentExceptionString = ds_list_find_value(exceptionStringList, i);
	draw_text(floor(exceptionsInfoWindowRectX1 + 20) - clipX, floor(exceptionsInfoWindowRectY1 + plusY + scrollPlusY) - clipY, string(currentExceptionString));
	plusY += string_height("0");
}



scr_scrollBar(ds_list_size(exceptionStringList) + 1, -1, string_height("0"), 0,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
scrollPlusY = min(scrollPlusY, 0);

scr_surfaceEnd();