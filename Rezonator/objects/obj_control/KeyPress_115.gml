if (window_get_fullscreen())
{
	camera_set_view_size(view_camera[0], 1024, 768);
	view_set_wport(0, 1024);
	view_set_hport(0, 768);
	window_set_fullscreen(false);
}
else
{
	view_set_visible(0, false);
	view_set_visible(1, true);
	window_set_fullscreen(true);
}