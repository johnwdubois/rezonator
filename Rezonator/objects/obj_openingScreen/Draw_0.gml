/*
	obj_openingScreen: Draw
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Control the layout and functionality of the opening screen
	
	Mechanism: Draw the text, import window, and send the user to the main screen once ready
	
	Author: Terry DuBois
*/

scr_colorThemeControl();

importWindowWidth = camera_get_view_width(view_camera[0]) / 2;
importWindowHeight = camera_get_view_height(view_camera[0]) / 5;
importWindowX1 = camera_get_view_width(view_camera[0]) * 0.25;
importWindowY1 = camera_get_view_height(view_camera[0]) * 0.4;
importWindowX2 = importWindowX1 + importWindowWidth;
importWindowY2 = importWindowY1 + importWindowHeight;

scr_windowCameraAdjust();

draw_set_alpha(1);
draw_sprite(spr_logo, 0, camera_get_view_width(view_camera[0]) / 2, camera_get_view_height(view_camera[0]) / 4);
draw_set_font(fnt_debug);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);
var versionString = string(game_display_name);
versionString = string_delete(versionString, 1, string_length("Rezonator"));
versionString = "Version" + versionString;
draw_text((camera_get_view_width(view_camera[0]) / 2) + (sprite_get_width(spr_logo) / 2), (camera_get_view_height(view_camera[0]) / 4) + (sprite_get_height(spr_logo) / 2), versionString);


if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("D"))) {
	showDevVars = !showDevVars;
}
if (showDevVars) {
	var workingDirStr = "Working Dir: " + string(working_directory);
	var programDirStr = "Program Dir: " + string(program_directory);
	draw_set_halign(fa_left);
	draw_text((camera_get_view_width(view_camera[0]) / 2) + (sprite_get_width(spr_logo) / 2) - 500, (camera_get_view_height(view_camera[0]) / 4) + (sprite_get_height(spr_logo) / 2) + 30, workingDirStr);
	draw_text((camera_get_view_width(view_camera[0]) / 2) + (sprite_get_width(spr_logo) / 2) - 500, (camera_get_view_height(view_camera[0]) / 4) + (sprite_get_height(spr_logo) / 2) + 50, programDirStr);
}

if not (global.newProject or global.openProject)
{
	scr_newOrOpen();
}
else if (global.newProject and not global.openProject)
{
	scr_newProjectWindow();
}
else if (not global.newProject and global.openProject)
{
	room_goto(rm_mainScreen);
}

