/*
	Purpose: Help Rez load files without interruptions
*/



if (global.ctrlHold and keyboard_check_pressed(ord("S")) and ableToHotkey) {

	ableToHotkey = false;
	var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingBar);
	instLoading.loadSprite = spr_saving;
	with (obj_fileLoader) {
		alarm[0] = 1;
	}

}

if (!global.ctrlHold and not ableToHotkey) {
	ableToHotkey = true;
}

if (drawAutosaveText) {
	var camWidth = camera_get_view_width(view_camera[0]);
	var camHeight = camera_get_view_height(view_camera[0]);
	var savingText = scr_get_translation("msg_warning_autosaving");
	scr_adaptFont(savingText, "L");
	var textWidth = string_width(savingText);
	var textHeight = string_height(savingText);
	var textBuffer = 20;
	
	// get coordinates for autosave text
	var autosaveTextX = camWidth * 0.5;
	var autosaveTextY = camHeight * 0.9;
	var savingRectX1 = autosaveTextX - (textWidth * 0.5);
	var savingRectY1 = autosaveTextY - (textHeight * 0.5);
	var savingRectX2 = savingRectX1 + textWidth;
	var savingRectY2 = savingRectY1 + textHeight;
	
	// draw autosave text & rect
	draw_set_alpha(1);
	draw_set_color(global.colorThemeSelected1);
	draw_roundrect(savingRectX1, savingRectY1, savingRectX2, savingRectY2, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(autosaveTextX, autosaveTextY, savingText);
}