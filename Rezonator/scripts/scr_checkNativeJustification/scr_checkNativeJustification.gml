// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_checkNativeJustification(){
return	(obj_control.justify == obj_control.justifyLeft && obj_control.drawLineState == obj_control.lineState_ltr)
		|| (obj_control.justify == obj_control.justifyRight && obj_control.drawLineState == obj_control.lineState_rtl)
}