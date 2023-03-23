if (instance_exists(obj_openingScreen)) {
	if (global.project == "import") {
		windowFocused = false;
		exit;
	}
}
scr_inputBoxDraw();