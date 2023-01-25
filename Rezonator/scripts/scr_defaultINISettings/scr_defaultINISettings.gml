function scr_defaultINISettings() {
	
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
	
	show_debug_message("scr_defaultINISettings, fontSize: " + string(global.fontSize));

}