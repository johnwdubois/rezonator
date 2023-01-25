camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());


	
// File window
fileInfoWindowRectX1 = 40;
fileInfoWindowRectY1 = max(80 + string_height("0"), camHeight * 0.08);
fileInfoWindowRectX2 = (camWidth * 0.5) - 20;
fileInfoWindowRectY2 = (camHeight / 2) - 180;


//draw selecting tabs
scr_summaryTabs();


//draw background
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(fileInfoWindowRectX1, fileInfoWindowRectY1, fileInfoWindowRectX2, fileInfoWindowRectY2, false);

	
// abbreviated surfaceStart()
windowWidth = clamp(fileInfoWindowRectX2 - fileInfoWindowRectX1, 48, 2000);
windowHeight = clamp(fileInfoWindowRectY2 - fileInfoWindowRectY1, 48, 1500);
clipWidth = windowWidth;
clipHeight = windowHeight;

x = fileInfoWindowRectX1;
y = fileInfoWindowRectY1;
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


if (selectedTab == "menu_file") {
	scr_fileWindow();
}
else if (selectedTab == "menu_summary") {
	scr_summaryWindow();
}
else if (selectedTab == "label_exceptions") {
	scr_exceptionsWindow();
}

scr_surfaceEnd();

