draw_set_alpha(1);

draw_sprite(spr_logo, 0, room_width / 2, room_height / 4);

draw_set_font(fnt_main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var importButtonRectWidth = 200;
var importButtonRectHeight = 60;

var importButtonRectX1 = room_width / 2 - (importButtonRectWidth / 2);
var importButtonRectY1 = (room_height / 4) * 3 - (importButtonRectHeight / 2);
var importButtonRectX2 = importButtonRectX1 + importButtonRectWidth;
var importButtonRectY2 = importButtonRectY1 + importButtonRectHeight;

if (point_in_rectangle(mouse_x, mouse_y, importButtonRectX1, importButtonRectY1, importButtonRectX2, importButtonRectY2))
{
	draw_set_color(c_ltgray);
	
	if (mouse_check_button_pressed(mb_left))
	{
		scr_openXML();
	}
}
else
{
	draw_set_color(c_white);
}
draw_rectangle(importButtonRectX1, importButtonRectY1, importButtonRectX2, importButtonRectY2, false);
draw_set_color(c_black);
draw_rectangle(importButtonRectX1, importButtonRectY1, importButtonRectX2, importButtonRectY2, true);

draw_text(mean(importButtonRectX1, importButtonRectX2), mean(importButtonRectY1, importButtonRectY2), "Import Discourse");



var continueButtonRectWidth = 200;
var continueButtonRectHeight = 60;

var continueButtonRectX1 = room_width / 2 - (continueButtonRectWidth / 2);
var continueButtonRectY1 = (room_height / 8) * 7 - (continueButtonRectHeight / 2);
var continueButtonRectX2 = continueButtonRectX1 + continueButtonRectWidth;
var continueButtonRectY2 = continueButtonRectY1 + continueButtonRectHeight;

if (point_in_rectangle(mouse_x, mouse_y, continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2))
{
	draw_set_color(c_ltgray);
	
	if (mouse_check_button_pressed(mb_left))
	{
		room_goto_next();
	}
}
else
{
	draw_set_color(c_white);
}
draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, false);
draw_set_color(c_black);
draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, true);

draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), "Continue");







draw_text(room_width / 2, room_height / 2, "fileLineRipGrid height: " + string(ds_grid_height(global.fileLineRipGrid)));