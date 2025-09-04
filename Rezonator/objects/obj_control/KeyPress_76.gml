/// @description Change text direction LTR/RTL

if (!shortcutsEnabled || instance_exists(obj_dialogueBox)) exit;

if (global.ctrlHold) {
	obj_control.showTranslation = !obj_control.showTranslation
}
else if (keyboard_check(vk_alt) && keyboard_check(vk_shift)) {

	if (obj_control.drawLineState == obj_control.lineState_ltr) {
		obj_control.drawLineState = obj_control.lineState_rtl;
		obj_control.justify = obj_control.justifyRight;
	}
	else if (obj_control.drawLineState == obj_control.lineState_rtl) {
		obj_control.drawLineState = obj_control.lineState_ltr;
		obj_control.justify = obj_control.justifyLeft;
	}

	scr_refreshPrevToken();
}