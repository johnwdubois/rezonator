if (window_get_fullscreen())
{
	view_set_visible(0, true);
	view_set_visible(1, false);
	window_set_fullscreen(false);
}
else
{
	view_set_visible(0, false);
	view_set_visible(1, true);
	window_set_fullscreen(true);
}