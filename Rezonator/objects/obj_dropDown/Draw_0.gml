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
var strHeight = string_height("A")
optionSpacing = strHeight * 1.25;
windowHeight = ds_list_size(optionList) * optionSpacing;
textBuffer = 10;


// clamp windowHeight so dropDown is not hanging off the screen
var showScrollBar = false;
var camHeight = camera_get_view_height(camera_get_active());
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
	show_debug_message("obj_dropDown Draw ... ds_list_size(optionList) <= 0");
	instance_destroy();
}

mouseOverDropDown =  false;
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseOverDropDown =  true;
}

scrollPlusY = min(scrollPlusY, 0);

var optionListSize = ds_list_size(optionList);
for (var i = 0; i < optionListSize; i++) {
	draw_set_alpha(1);
	var optionRectX1 = x;
	var optionRectY1 = y + (optionSpacing * i) + scrollPlusY;
	var optionRectX2 = x + windowWidth;
	var optionRectY2 = optionRectY1 + optionSpacing;
	var mouseoverRectX2 = (showScrollBar) ? optionRectX2 - global.scrollBarWidth : optionRectX2;
	
	var mouseoverCurrentOption = false;
	if (instance_exists(obj_panelPane)) {
		if (point_in_rectangle(mouse_x, mouse_y, optionRectX1, optionRectY1, mouseoverRectX2, optionRectY2) and ableToMouseover
		and not obj_panelPane.scrollBarClickLock) {
			mouseoverCurrentOption = true;
			ableToMouseover = false;
			if (room == rm_mainScreen) {
				obj_control.mouseoverPanelPane = true;
			}
		}
	}
	else {
		if (point_in_rectangle(mouse_x, mouse_y, optionRectX1, optionRectY1, mouseoverRectX2, optionRectY2) and ableToMouseover) {
			mouseoverCurrentOption = true;
			ableToMouseover = false;
			if (room == rm_mainScreen) {
				obj_control.mouseoverPanelPane = true;
			}
		}
	}
	
	draw_set_color(global.colorThemeBG);
	if (mouseoverCurrentOption or (optionCurrent == i && !mouseOverDropDown)) {
		draw_set_color(c_ltblue);
	}

	
	draw_rectangle(optionRectX1 - clipX, optionRectY1 - clipY, optionRectX2 - clipX, optionRectY2 - clipY, false);
	
	var optionText = ds_list_find_value(optionList, i);
	
	// check whether this option is expandable
	var isExpandable = ds_map_exists(global.expandableDropDownMap, optionText);
	if (optionText == "Stack" && (ds_list_size(optionList) == 4 || ds_list_size(optionList) == 3)) {
		isExpandable = false;
	}
	else if (optionText == "Search" && ds_list_size(optionList) == 4) {
		isExpandable = false;
	}
	else if (optionText == "Prose" && ds_list_size(optionList) == 2) {
		isExpandable = false;
	}
	
	
	draw_set_color(global.colorThemeText);
	if (room == rm_mainScreen) {
		if (string_char_at(optionText, 1) == "~") {
			draw_set_color(global.colorThemeSelected2);
		}
	}
	draw_text(optionRectX1 + textBuffer - clipX, mean(optionRectY1, optionRectY2) - clipY, optionText);
	draw_set_alpha(1);
	
	if (mouseoverCurrentOption and ableToClick and mouse_check_button_released(mb_left)) {
		optionCurrent = i;
		var optionSelected = ds_list_find_value(optionList, i);
		if (room == rm_mainScreen) {
			obj_menuBar.menuClickedIn = false;
		}
		scr_dropDownSelect(optionSelected);
	}
	
	// draw arrow if expandable
	if (isExpandable) {
		var expandArrowX = floor(optionRectX2 - (sprite_get_width(spr_ascend) / 2));
		var expandArrowY = floor(mean(optionRectY1, optionRectY2));
		draw_sprite_ext(spr_ascend, 0, expandArrowX - clipX, expandArrowY - clipY, 1, 1, 270, c_white, 1);
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



var mouseInDropDown = false;
var dropDownInstanceNumber = instance_number(obj_dropDown);
for (var i = 0; i < dropDownInstanceNumber; i++) {
	var currentDropDown = instance_find(obj_dropDown, i);
	if (point_in_rectangle(mouse_x, mouse_y, currentDropDown.x, currentDropDown.y, currentDropDown.x + currentDropDown.windowWidth, currentDropDown.y + currentDropDown.windowHeight)) {
		mouseInDropDown = true;
	}
}

if (ableToMouseover and ableToClick and mouse_check_button_released(mb_left) 
and !mouseInDropDown and !scrollBarHoldingDelay) {
	if (room == rm_mainScreen) {
		obj_menuBar.menuClickedIn = false;
	}
	show_debug_message("obj_dropDown Draw ... destroying dropdowns");
	with (obj_dropDown) {
		instance_destroy();
	}
}
scrollBarHoldingDelay = scrollBarHolding;


draw_set_color(c_ltgray);
draw_set_alpha(1);
draw_rectangle(x, y, x + windowWidth - 1, y + windowHeight, true);