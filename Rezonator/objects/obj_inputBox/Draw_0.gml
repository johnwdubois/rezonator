if (instance_exists(obj_openingScreen)) {
	if (obj_openingScreen.showPreImportScreen) {
		windowFocused = false;
		exit;
	}
}
scr_inputBoxDraw();