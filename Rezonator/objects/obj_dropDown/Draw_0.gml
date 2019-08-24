/*
	obj_dropDown: Draw
	
	Last Updated: 2019-02-15
	
	Called from: Every frame of the game
	
	Purpose: Create the visuals of any drop down menus
	
	Mechanism: Draw the outlines and text, and check for user mouse input
	
	Author: Terry DuBois
*/

var optionSpacing = 20;
var ableToMouseover = true;
var windowHeight = (ds_list_size(optionList) * optionSpacing);
var textBuffer = 10;

draw_set_font(fnt_dropDown);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

if (ds_list_size(optionList) <= 0)
{
	instance_destroy();
}

for (var i = 0; i < ds_list_size(optionList); i++)
{
	var optionRectX1 = x;
	var optionRectY1 = y + (optionSpacing * i);
	var optionRectX2 = x + windowWidth;
	var optionRectY2 = optionRectY1 + optionSpacing;
	
	var mouseoverCurrentOption = false;
	if (point_in_rectangle(mouse_x, mouse_y, optionRectX1, optionRectY1, optionRectX2, optionRectY2) and ableToMouseover)
	{
		mouseoverCurrentOption = true;
		ableToMouseover = false;
		obj_control.mouseoverPanelPane = true;
	}
	
	draw_set_color(c_white);
	if (mouseoverCurrentOption)
	{
		draw_set_color(obj_control.c_ltblue);
	}
	
	draw_rectangle(optionRectX1, optionRectY1, optionRectX2, optionRectY2, false);
	
	var optionText = ds_list_find_value(optionList, i);
	
	draw_set_color(c_black);
	draw_text(optionRectX1 + textBuffer, mean(optionRectY1, optionRectY2), optionText);
	
	if (mouseoverCurrentOption and ableToClick and mouse_check_button_released(mb_left))
	{
		var optionSelected = ds_list_find_value(optionList, i);
		obj_menuBar.menuClickedIn = false;
		scr_dropDownSelect(optionSelected);
	}
}

if (ableToMouseover and ableToClick and mouse_check_button_released(mb_left))
{
	obj_menuBar.menuClickedIn = false;
	instance_destroy();
}

draw_set_color(c_ltgray);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);