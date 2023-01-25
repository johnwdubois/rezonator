


// arrowFaceDirection should be obj_tooltip.arrowFaceLeft, ...Right, ...up, or ...down

function scr_createTooltip(tipX, tipY, tipText, arrowFaceDirection) {
	
	with (obj_tooltip) {	
		text = tipText;
		

		arrowFacing = arrowFaceDirection;
		x = tipX;
		y = tipY;
		showCount = 2;
		if (text != tipText) {
			alpha = 0;
		}
	}
}