view_set_xport(0, 0);
view_set_yport(0, 0);
view_set_wport(0, window_get_width());
view_set_hport(0, window_get_height());
var cam = camera_create_view(0, 0, window_get_width(), window_get_height(), 0, -1, 5, 5, -1, -1);
view_set_camera(0, cam);

draw_set_alpha(1);

draw_text(0, 200, "window_get_width(): " + string(window_get_width()));
draw_text(0, 240, "window_get_height(): " + string(window_get_height()));