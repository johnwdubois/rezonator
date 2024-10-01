if (widget_get_owner() == string(int64(0))) {
	// Set parent/owner window, (for libdlgmod):
	widget_set_owner(string(int64(window_handle())));
	// Maximize main window:
	window_zoom(window_handle());
}