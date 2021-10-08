
scr_colorThemeControl();

importWindowWidth = camera_get_view_width(camera_get_active()) / 2;
importWindowHeight = camera_get_view_height(camera_get_active()) / 5;
importWindowX1 = camera_get_view_width(camera_get_active()) * 0.25;
importWindowY1 = camera_get_view_height(camera_get_active()) * 0.4;
importWindowX2 = importWindowX1 + importWindowWidth;
importWindowY2 = importWindowY1 + importWindowHeight;





if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("D"))) {
	showDevVars = !showDevVars;
}
if (obj_openingScreen.showDevVars) {
	var workingDirStr = "Working Dir: " + string(working_directory);
	var programDirStr = "Program Dir: " + string(program_directory);
	var currentDirStr = "Current Dir: " + string(global.currentDirString);
	draw_set_halign(fa_left);
	draw_text((camera_get_view_width(camera_get_active()) / 2) + (sprite_get_width(spr_logo) / 2) - 500, (camera_get_view_height(camera_get_active()) / 4) + (sprite_get_height(spr_logo) / 2) + 30, workingDirStr);
	draw_text((camera_get_view_width(camera_get_active()) / 2) + (sprite_get_width(spr_logo) / 2) - 500, (camera_get_view_height(camera_get_active()) / 4) + (sprite_get_height(spr_logo) / 2) + 50, programDirStr);
	draw_text((camera_get_view_width(camera_get_active()) / 2) + (sprite_get_width(spr_logo) / 2) - 500, (camera_get_view_height(camera_get_active()) / 4) + (sprite_get_height(spr_logo) / 2) + 100, currentDirStr);
	
	draw_text(20, 20, "global.fontSize: " + string(global.fontSize));
}



if(!global.fontsLoaded){
	if(!global.loadingScreenCreated){
		var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
		instLoading.loadSprite = spr_loading;
		global.loadingScreenCreated = true;
	}
}


showPreImportScreen = (global.newProject and not global.openProject);
if (showPreImportScreen) {
	scr_preImportScreen();
}

	
if not (global.newProject or global.openProject) {
	scr_openingMenu();
}
else if (not global.newProject and global.openProject) {
	room_goto(rm_loadingScreen);
}


// draw Rezonator logo with version number
if !(global.newProject and not global.openProject) {
	scr_drawLogo(camera_get_view_width(camera_get_active()) * .05, camera_get_view_height(camera_get_active()) * .08, true);
}
