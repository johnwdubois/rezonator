function scr_defaultINISettings(){
	
	var displayWidth = display_get_width();
	var displayHeight = display_get_height();
	show_debug_message("scr_defaultINISettings, displayHeight: " + string(displayHeight));
	
	// check display size and set a default font size accordingly
	global.fontSize = 0;
	if (displayHeight < 1100) {
		global.fontSize = 0;
	}
	else if (displayHeight < 1312) {
		global.fontSize = 1;
	}
	else if (displayHeight < 1524) {
		global.fontSize = 2;
	}
	else if (displayHeight < 1736) {
		global.fontSize = 3;
	}
	else if (displayHeight < 1948) {
		global.fontSize = 4;
	}
	else {
		global.fontSize = 5;
	}
	
	// set the window to be at least 80% of the display by default
	var displayRatio = 0.8;
	if (window_get_width() < displayWidth * displayRatio && window_get_height() < displayHeight * displayRatio) {
		window_set_size(displayWidth * displayRatio, displayHeight * displayRatio);
	}
	
	// center the window within the display
	window_center();

}