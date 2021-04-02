// Check for user inputs to switch between chain tools
if (!obj_control.gridView and !obj_control.dialogueBoxActive and !instance_exists(obj_dialogueBox) and !instance_exists(obj_dropDown) and obj_control.mouseoverTagShortcut == "") {
	if (keyboard_check_pressed(ord("R")) and not keyboard_check(vk_control)) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolRezBrush;
	}
	else if (keyboard_check_pressed(ord("T")) and not keyboard_check(vk_control)) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolTrackBrush;
	}
}

global.toolPaneWidth = windowWidth;

originalWindowHeight = obj_menuBar.menuHeight;