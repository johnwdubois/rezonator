/// @description Insert description here
// You can write your code in this editor

if(!shortcutsEnabled) exit;

if(keyboard_check(vk_control)){
	obj_control.showTranslation = !obj_control.showTranslation
}

if(obj_control.drawLineState == obj_control.lineState_ltr){
	obj_control.drawLineState = obj_control.lineState_rtl;
	exit;
}
	
else if(obj_control.drawLineState == obj_control.lineState_rtl) {
	obj_control.drawLineState = obj_control.lineState_ltr;
	exit;
}

//change text direction