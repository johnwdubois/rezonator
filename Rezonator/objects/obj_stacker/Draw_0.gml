/// @description Insert description here
// You can write your code in this editor


if (keyboard_check(vk_control) && keyboard_check_pressed(vk_backspace)) {
	obj_control.activeStackType++;
}

if (showEndNoteWindow) {
	scr_drawEndNoteWindow();
}

if (confirmStackCreate) {
	scr_drawConfirmStackCreate();
}