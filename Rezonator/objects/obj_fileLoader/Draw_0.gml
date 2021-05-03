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

if(drawAutosaveText){
	var camWidth = camera_get_view_width(view_camera[0]);
	var camHeight = camera_get_view_height(view_camera[0]);
	var savingText = "Rezonator is autosaving in 5 seconds ...";
	var textWidth = string_width(savingText);
	var textHeight = string_height(savingText);
	var textBuffer = 20;

	var savingRecX1 = 23*camWidth/32 - textWidth/2 - textBuffer;
	var savingRecX2 = savingRecX1 + textWidth + textBuffer;
	var savingRecY1 = camHeight-2*camHeight/32 - textBuffer;
	var savingRecY2 = savingRecY1-textHeight + textBuffer;
	draw_set_color(c_red);
	draw_text_transformed(savingRecX1,savingRecY1,savingText,1.2,1.2,0);
	//draw_roundrect(savingRecX1,savingRecY1,savingRecX2,savingRecY2,false);

}