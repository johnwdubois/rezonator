

function scr_checkNativeJustification(){
return	(obj_control.justify == obj_control.justifyLeft && obj_control.drawLineState == obj_control.lineState_ltr)
		|| (obj_control.justify == obj_control.justifyRight && obj_control.drawLineState == obj_control.lineState_rtl)
}