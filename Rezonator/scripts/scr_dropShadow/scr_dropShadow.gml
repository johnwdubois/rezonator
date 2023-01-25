function scr_dropShadow(rectX1, rectY1, rectX2, rectY2) {
	
	var maxAlpha = 1;
	if (object_index == obj_dropDown) {
		if (myAlpha < 1) maxAlpha = myAlpha * 0.025;
		else maxAlpha = 1;
	}

	// draw drop shadow
	for (var i = 0; i < 8; i++) {
		var shadowRectX1 = (global.userLangRTL) ? rectX1-i : rectX1 + i;
		var shadowRectY1 = rectY1 + i;
		var shadowRectX2 = (global.userLangRTL) ? rectX2-i : rectX2 + i;
		var shadowRectY2 = rectY2 + i;
		draw_set_color(c_black);
		var shadowAlpha = clamp(((10 - i) * 0.075) * 0.2, 0, maxAlpha);
		draw_set_alpha(shadowAlpha);
		draw_rectangle(shadowRectX1, shadowRectY1, shadowRectX2, shadowRectY2, false);
	}

}