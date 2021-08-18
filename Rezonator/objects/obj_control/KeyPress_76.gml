/// @description Insert description here
// You can write your code in this editor

if(!shortcutsEnabled || instance_exists(obj_dialogueBox)) exit;

if(keyboard_check(vk_control)){
	obj_control.showTranslation = !obj_control.showTranslation
}

if(obj_control.drawLineState == obj_control.lineState_ltr){
	obj_control.drawLineState = obj_control.lineState_rtl;
	obj_control.justify = obj_control.justifyRight;
	exit;
}
else if(obj_control.drawLineState == obj_control.lineState_rtl) {
	obj_control.drawLineState = obj_control.lineState_ltr;
	obj_control.justify = obj_control.justifyLeft;
	exit;
}

//change text direction