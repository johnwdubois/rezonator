// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_textDirectionOptions(optionSelected){

	switch(optionSelected){
		case "Right To Left":
			obj_control.drawLineState = obj_control.lineState_rtl;
			instance_destroy(obj_dropDown);
		break;
		case "Left To Right":
			obj_control.drawLineState = obj_control.lineState_ltr;
			instance_destroy(obj_dropDown);
		break;
	}
	
}