/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_openingScreen)) {
	if (obj_openingScreen.showPreImportScreen) {
		clickedIn = false;
		exit;
	}
}
scr_inputBoxDraw();