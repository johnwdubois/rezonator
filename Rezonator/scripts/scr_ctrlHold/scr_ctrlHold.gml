function scr_ctrlHold() {
	
	global.ctrlHold = false;
	if (os_type == os_macosx) {
		if (keyboard_check(vk_rcommand) or keyboard_check(vk_lcommand)) global.ctrlHold = true;
	}
	else {
		if (keyboard_check(vk_control)) global.ctrlHold = true;
	}
	
}