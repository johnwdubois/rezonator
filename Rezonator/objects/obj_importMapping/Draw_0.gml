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

if(global.plainText){	
	scr_importPlainTextDraw();

}
else{
	scr_importMappingTagDraw();
}