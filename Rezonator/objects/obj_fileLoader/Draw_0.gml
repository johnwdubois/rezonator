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

		ableToHotkey = false;
		var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
		instLoading.loadSprite = spr_saving;
		with(obj_fileLoader){
			alarm[0] = 1;
		}

}
else if (keyboard_check(vk_control) and keyboard_check_pressed(ord("O")) and ableToHotkey) {
	ableToHotkey = false;
	//scr_loadREZ();
}
if (not keyboard_check(vk_control) and not ableToHotkey) {
	ableToHotkey = true;
}