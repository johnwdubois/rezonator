// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dropShadow(rectX1, rectY1, rectX2, rectY2){

	// draw drop shadow
	for (var i = 0; i < 8; i++) {
		var shadowRectX1 = (global.lang_codes[| global.lang_index] == "he") ? rectX1-i : rectX1 + i;
		var shadowRectY1 = rectY1 + i;
		var shadowRectX2 = (global.lang_codes[| global.lang_index] == "he") ? rectX2-i : rectX2 + i;
		var shadowRectY2 = rectY2 + i;
		draw_set_color(c_black);
		var shadowAlpha = clamp(((10 - i) * 0.075) * 0.2, 0, 1);
		draw_set_alpha(shadowAlpha);
		draw_rectangle(shadowRectX1, shadowRectY1, shadowRectX2, shadowRectY2, false);
	}

}