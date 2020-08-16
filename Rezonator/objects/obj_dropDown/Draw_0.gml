/*
	obj_dropDown: Draw
	
	Last Updated: 2019-02-15
	
	Called from: Every frame of the game
	
	Purpose: Create the visuals of any drop down menus
	
	Mechanism: Draw the outlines and text, and check for user mouse input
	
	Author: Terry DuBois
*/

draw_set_font(global.fontMain);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var ableToMouseover = true;
optionSpacing = string_height("A") * 1.25;
var windowHeight = (ds_list_size(optionList) * optionSpacing);
textBuffer = 10;


// loop through list to get windowWidth
var optionListSize = ds_list_size(optionList);
var maxStrWidth = originalWindowWidth;
for (var i = 0; i < optionListSize; i++) {
	var currentOptionStr = string(ds_list_find_value(optionList, i));
	var currentOptionStrWidth = string_width(currentOptionStr) + (textBuffer * 2);
	if (currentOptionStrWidth > maxStrWidth) {
		maxStrWidth = currentOptionStrWidth;
	}
}
windowWidth = maxStrWidth;




if (ds_list_size(optionList) <= 0) {
	instance_destroy();
}

mouseOverDropDown =  false;
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseOverDropDown =  true;
}

var optionListSize = ds_list_size(optionList);
for (var i = 0; i < optionListSize; i++) {
	var optionRectX1 = x;
	var optionRectY1 = y + (optionSpacing * i);
	var optionRectX2 = x + windowWidth;
	var optionRectY2 = optionRectY1 + optionSpacing;
	
	var mouseoverCurrentOption = false;
	if (point_in_rectangle(mouse_x, mouse_y, optionRectX1, optionRectY1, optionRectX2, optionRectY2) and ableToMouseover) {
		mouseoverCurrentOption = true;
		ableToMouseover = false;
		if (room == rm_mainScreen) {
			obj_control.mouseoverPanelPane = true;
		}
	}
	
	draw_set_color(c_white);
	if (mouseoverCurrentOption or (optionCurrent == i && !mouseOverDropDown)) {
		draw_set_color(c_ltblue);
	}

	
	draw_rectangle(optionRectX1, optionRectY1, optionRectX2, optionRectY2, false);
	
	var optionText = ds_list_find_value(optionList, i);
	
	draw_set_color(c_black);
	draw_text(optionRectX1 + textBuffer, mean(optionRectY1, optionRectY2), optionText);
	
	if (mouseoverCurrentOption and ableToClick and mouse_check_button_released(mb_left)) {
		optionCurrent = i;
		var optionSelected = ds_list_find_value(optionList, i);
		if (room == rm_mainScreen) {
			obj_menuBar.menuClickedIn = false;
		}
		scr_dropDownSelect(optionSelected);
	}
}

if (ableToMouseover and ableToClick and mouse_check_button_released(mb_left)) {
	if (room == rm_mainScreen) {
		obj_menuBar.menuClickedIn = false;
	}
	instance_destroy();
}

draw_set_color(c_ltgray);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);