scr_windowCameraAdjust();
scr_drawBackArrow();

	
if (keyboard_check(vk_alt) and keyboard_check(vk_shift)
and keyboard_check_pressed(ord("Q"))) {
	room_goto(rm_openingScreen);
}
if (keyboard_check(vk_alt) and keyboard_check(vk_shift)
and keyboard_check_pressed(ord("D"))) {
	showDevVars = !showDevVars;
}

if (global.plainText) {	
	scr_importPlainTextDraw();

}
else if (!instance_exists(obj_importException)) {
	scr_importMappingTagDraw();
}


if (showDevVars) {
	draw_set_font(global.fontMain);
	draw_set_halign(fa_left);
	draw_text(500, 300, "canContinueDisplayToken: " + string(canContinueDisplayToken));
	draw_text(500, 320, "canContinueToken1to1: " + string(canContinueToken1to1));
	draw_text(500, 340, "canContinueWordDelimiter: " + string(canContinueWordDelimiter));
	draw_text(500, 360, "canContinueWord1to1: " + string(canContinueWord1to1));
}