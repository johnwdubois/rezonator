/// @description Export portion
// You can write your code in this editor
if (!shortcutsEnabled || dialougeBoxActive || obj_panelPane.discoSelectionActive) {
	exit;
}

if (!obj_control.dialougeBoxActive) {
	keyboard_string = "";
	ePressed = true;
}

dialougeBoxActive = true;

//scr_exportPortion();