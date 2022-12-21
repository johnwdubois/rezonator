/// @description quick zero

if (!obj_control.dialogueBoxActive) {
	if (is_string(obj_control.hoverTokenID) && obj_control.hoverTokenID != "") {
		
		var fillWord = scr_get_translation("option_zero-0");
		if (keyboard_check(vk_shift)) {
			obj_control.before = false;
		}
		else {
			obj_control.before = true;
		}
		scr_newToken(fillWord, obj_control.hoverTokenID);
	}
}