function scr_fontSizeControlOpeningScreen() {
	// Adjust the font size in Opening Menu

	var keyboardCheckPlusKey = (os_type == os_macosx) ? keyboard_check_direct(24) : keyboard_check_direct(187);
	var keyboardCheckMinusKey = (os_type == os_macosx) ? keyboard_check_direct(109) : keyboard_check_direct(189);

	// font size decrease
	if (canPressMinus) {
		if (global.ctrlHold and keyboard_check_pressed(vk_subtract)
		or (global.ctrlHold and keyboardCheckMinusKey)) {
			if (keyboard_check(vk_shift)) {
				if (global.fontSize > 0) {
					global.fontSize--;
					if (room == rm_importScreen) {
						with (obj_importMapping) {
							canPressMinus = false;
							alarm[0] = 15;
						}
					}
					else {
						canPressMinus = false;
						alarm[0] = 15;
					}
				}
			}
		}
	}

	// font size increase
	if (canPressPlus) {
		if (global.ctrlHold and keyboard_check_pressed(vk_add)
		or (global.ctrlHold and keyboardCheckPlusKey)) {
			if (keyboard_check(vk_shift)) {
				if (global.fontSize < 5) {
					global.fontSize++;
					if (room == rm_importScreen) {
						with (obj_importMapping) {
							canPressPlus = false;
							alarm[1] = 15;
						}
					}
					else {
						canPressPlus = false;
						alarm[1] = 15;
					}
				}
			}
		}
	}

	scr_fontGlobalUpdate();


}
