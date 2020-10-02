// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createTooltip(tipX, tipY, tipText, arrowFaceDirection){
	
	with (obj_tooltip) {	
		text = tipText;
		arrowFacing = arrowFaceDirection;
		x = tipX;
		y = tipY;
		show = true;
		if (text != tipText) {
			alpha = 0;
		}
	}
}