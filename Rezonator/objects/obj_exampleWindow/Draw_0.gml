var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

x = (camWidth * 0.52);
y = (camHeight * 0.06);
var windowX2 = camWidth * 0.98;
var windowY2 = camHeight * 0.41;
windowWidth = (windowX2 - x);
windowHeight = (windowY2 - y);

draw_set_color(global.colorThemeBG);
draw_rectangle(x, y, windowX2, windowY2, false);


