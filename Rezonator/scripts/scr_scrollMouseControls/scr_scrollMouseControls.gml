

function scr_scrollMouseControls(distance) {
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainContents
	if (clickedIn) {
	
		// Scroll up with mouse/key
		if ((mouse_wheel_up() || keyboard_check(vk_up)) and (obj_panelPane.holdUp < 2 || obj_panelPane.holdUp > 30)) {
			if (obj_control.navWindowTaggingID == "") {
				scrollPlusYDest += distance;
			}
		}
	
		// Scroll down with mouse/key
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			if (obj_control.navWindowTaggingID == "") {
				scrollPlusYDest -= distance;
			}
		}
	
		// CTRL+UP and CTRL+DOWN
		if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
			scrollPlusYDest = 100;
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
			scrollPlusYDest = -999999999999;
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			scrollPlusYDest += (windowHeight);
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			scrollPlusYDest -= (windowHeight);
		}
	}

}