/// @description Insert description here
// You can write your code in this editor
/// @description quick zero
// You can write your code in this editor

if(!obj_control.dialogueBoxActive){
	if(obj_control.hoverTokenID != ""){
		var fillWord = scr_get_translation("option_zero-0");

		if(keyboard_check(vk_shift)){
			obj_control.before = false;
		}
		else {
			obj_control.before = true;
		}
		
		scr_newToken(fillWord,obj_control.hoverTokenID);
	}
}