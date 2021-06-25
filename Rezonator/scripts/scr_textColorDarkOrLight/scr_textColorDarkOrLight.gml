// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_textColorDarkOrLight(color){
	
	var r = color_get_red(color);
	var g = color_get_green(color);
	var b = color_get_blue(color);

	if (r * 0.299 + g * 0.587 + b * 0.114 > 150) return c_black
	else return c_white;

}