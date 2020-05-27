if (keyboard_check(vk_control)) {
	if (justify == justifyLeft) {
		justify = justifyCenter;
	}
	else if (justify == justifyCenter) {
		justify = justifyRight;
	}
	else if (justify == justifyRight) {
		justify = justifyLeft;
	}
}