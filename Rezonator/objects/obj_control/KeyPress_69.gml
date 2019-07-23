/// @description Export portion
// You can write your code in this editor
if (!shortcutsEnabled || dialogueBoxActive || obj_panelPane.discoSelectionActive) {
	exit;
}

if (!obj_control.dialogueBoxActive) {
	keyboard_string = "";
	ePressed = true;
}

dialogueBoxActive = true;

//scr_exportPortion();