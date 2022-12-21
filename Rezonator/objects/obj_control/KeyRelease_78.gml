if (!shortcutsEnabled) exit;
if (instance_exists(obj_dialogueBox) || instance_exists(obj_dropDown)) exit;

var showNavOriginal = obj_panelPane.showNav;

with (obj_panelPane) {
	showNav = !showNavOriginal;
	showNavLeft = showNav;
	showNavRight = showNav;
}