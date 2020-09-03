/*
	obj_dropDown: Draw
	
	Last Updated: 2019-02-15
	
	Called from: Every frame of the game
	
	Purpose: Create the visuals of any drop down menus
	
	Mechanism: Draw the outlines and text, and check for user mouse input
	
	Author: Terry DuBois
*/

if (live_call()) return live_result;



draw_set_font(global.fontMain);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var ableToMouseover = true;
var strHeight = string_height("A")
optionSpacing = strHeight * 1.25;
windowHeight = ds_list_size(optionList) * optionSpacing;
textBuffer = 10;


// clamp windowHeight so dropDown is not hanging off the screen
var showScrollBar = false;
var camHeight = camera_get_view_height(view_camera[0]);
if (y + windowHeight > camHeight) {
	windowHeight = camHeight - y - 50;
	showScrollBar = true;
}


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


// surface stuff
windowX = x;
windowY = y;
clipX = x;
clipY = y;
clipWidth = windowWidth;
clipHeight = windowHeight;

if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}

scr_windowCameraAdjust();

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);




if (ds_list_size(optionList) <= 0) {
	instance_destroy();
}

mouseOverDropDown =  false;
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseOverDropDown =  true;
}

scrollPlusY = min(scrollPlusY, 0);

var optionListSize = ds_list_size(optionList);
for (var i = 0; i < optionListSize; i++) {
	var optionRectX1 = x;
	var optionRectY1 = y + (optionSpacing * i) + scrollPlusY;
	var optionRectX2 = x + windowWidth;
	var optionRectY2 = optionRectY1 + optionSpacing;
	
	var mouseoverCurrentOption = false;
	if (point_in_rectangle(mouse_x, mouse_y, optionRectX1, optionRectY1, optionRectX2 - global.scrollBarWidth, optionRectY2) and ableToMouseover
	and !scrollBarHolding) {
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

	
	draw_rectangle(optionRectX1 - clipX, optionRectY1 - clipY, optionRectX2 - clipX, optionRectY2 - clipY, false);
	
	var optionText = ds_list_find_value(optionList, i);
	
	draw_set_color(c_black);
	draw_text(optionRectX1 + textBuffer - clipX, mean(optionRectY1, optionRectY2) - clipY, optionText);
	
	if (mouseoverCurrentOption and ableToClick and mouse_check_button_released(mb_left)) {
		optionCurrent = i;
		var optionSelected = ds_list_find_value(optionList, i);
		if (room == rm_mainScreen) {
			obj_menuBar.menuClickedIn = false;
		}
		scr_dropDownSelect(optionSelected);
	}
}

if (showScrollBar) {
	scr_scrollBar(optionListSize, -1, optionSpacing, 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
		
	// scroll mouse wheel
	if (mouse_wheel_up()) {
		scrollPlusYDest += strHeight;
	}
	if (mouse_wheel_down()) {
		scrollPlusYDest -= strHeight;
	}
}

scr_surfaceEnd();

if (scrollBarHolding) {
	scrollBarHoldingDelay = true;
}

if (ableToMouseover and ableToClick and mouse_check_button_released(mb_left) 
and !point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight)
and !scrollBarHoldingDelay) {
	if (room == rm_mainScreen) {
		obj_menuBar.menuClickedIn = false;
	}
	instance_destroy();
}
scrollBarHoldingDelay = scrollBarHolding;


draw_set_color(c_ltgray);
draw_rectangle(x, y, x + windowWidth - 1, y + windowHeight, true);