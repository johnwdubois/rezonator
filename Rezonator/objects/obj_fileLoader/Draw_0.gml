/*
	obj_fileLoader: Draw
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Help Rez load files without interruptions
	
	Mechanism: Prevent hot keys and other functionality from operating before file has completely loaded
	
	Author: Terry DuBois
*/

if (global.openProject and ds_grid_height(obj_control.wordGrid) < 1) {
	scr_loadREZ();
}

if (keyboard_check(vk_control) and keyboard_check_pressed(ord("S")) and ableToHotkey) {
	//if (ds_grid_height(obj_control.unitGrid) < global.totalUnitAmount) {
	//	show_message("Please let Rezonator finish importing files before saving.");
	//}
	//else {
		draw_set_alpha(1);
		draw_set_color(obj_toolPane.progressBarFrontColor);
		draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
		draw_set_color(c_white);
		draw_set_font(obj_toolPane.progressBarFont);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), "Saving...");
		
		ableToHotkey = false;
		alarm[0] = 1;
	//}
}
else if (keyboard_check(vk_control) and keyboard_check_pressed(ord("O")) and ableToHotkey) {
	ableToHotkey = false;
	scr_loadREZ();
}
if (not keyboard_check(vk_control) and not ableToHotkey) {
	ableToHotkey = true;
}