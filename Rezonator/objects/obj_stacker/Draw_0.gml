/// @description Insert description here
// You can write your code in this editor
if (splitSave) {
	draw_set_alpha(1);
	draw_set_color(obj_toolPane.progressBarFrontColor);
	draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
	draw_set_color(c_white);
	draw_set_font(obj_toolPane.progressBarFont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), "Saving...");
	draw_set_font(fnt_dropDown);
}

if (keyboard_check(vk_control) && keyboard_check_pressed(vk_backspace)) {
	obj_control.activeStackType++;
}