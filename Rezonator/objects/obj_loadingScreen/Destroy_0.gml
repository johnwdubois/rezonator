///destroy autosave warning
// You can write your code in this editor

with (obj_fileLoader) drawAutosaveText = false;

if (room == rm_openingScreen) {
	// set the window to be at least 80% of the display by default
	var displayRatio = 0.8;
	if (window_get_width() < display_get_width() * displayRatio && window_get_height() < display_get_height() * displayRatio) {
		window_set_size(display_get_width() * displayRatio, display_get_height() * displayRatio);
	}
	
	// center the window within the display
	if (os_type == os_windows) window_center();
	
	with (obj_openingScreen) runFontSizeTest = true;
}