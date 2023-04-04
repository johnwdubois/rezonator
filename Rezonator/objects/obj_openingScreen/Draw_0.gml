if (runFontSizeTest) {
	if (fontSizeTest >= 0 && fontSizeTest <= global.fontSizeMax) {
		global.fontSize = fontSizeTest;
		fontSizeTest++;
		scr_adaptFont("a", "M", false);
		if (fontSizeTest >= global.fontSizeMax) {
			runFontSizeTest = false;
			alarm[9] = 1;
			show_debug_message("obj_openingScreen Draw, done with fontSizeTest");
			if (BUILD) with (obj_loadingBar) alarm[0] = 2;
		}
	}
}


scr_colorThemeControl();

importWindowWidth = camera_get_view_width(camera_get_active()) / 2;
importWindowHeight = camera_get_view_height(camera_get_active()) / 5;
importWindowX1 = camera_get_view_width(camera_get_active()) * 0.25;
importWindowY1 = camera_get_view_height(camera_get_active()) * 0.4;
importWindowX2 = importWindowX1 + importWindowWidth;
importWindowY2 = importWindowY1 + importWindowHeight;

scr_windowCameraAdjust();




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
	
	draw_text(20, 20, "openingScreen, global.fontSize: " + string(global.fontSize));
}



if (!global.fontsLoaded) {
	if (!global.loadingScreenCreated) {
		var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingBar);
		instLoading.loadSprite = spr_loading;
		global.loadingScreenCreated = true;
	}
}

	
if (global.project == "") {
	scr_openingMenu();
	scr_drawLogo(camera_get_view_width(camera_get_active()) * .05, camera_get_view_height(camera_get_active()) * 0.08, true);
}
else if (global.project == "open") {
	room_goto(rm_loadingScreen);
}
else if (global.project == "import") {
	scr_preImportScreen();
}

if (global.project != "") {
	hoverColorMergeOpen = 0;
	hoverColorMergeImport = 0;
	hoverColorMergeHelp = 0;
}