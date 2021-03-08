// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawRectWidth(x1, y1, x2, y2, width){
	
	draw_line_width(x1, y1, x2, y1, width);
	draw_line_width(x2, y1, x2, y2, width);
	draw_line_width(x2, y2, x1, y2, width);
	draw_line_width(x1, y2, x1, y1, width);

}