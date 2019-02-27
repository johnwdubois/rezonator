/*
	obj_toolPane: Draw
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Draw the tool pane and all of its contents
	
	Mechanism: Draw all text, icons, and boxes in the tool pane, and check for user mouseover
	
	Author: Terry DuBois
*/

x = camera_get_view_width(view_camera[0]) - windowWidth;
y = 0;

if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	if (not obj_control.gridView) {
		with (obj_chain) {
			scr_chainDeselect();
		}
	}
}


draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);

var iconMarginTop = 30;
var iconPlusY = 0;
var iconPlusYIncrement = sprite_get_height(spr_tools) * 1.5;
var iconHorizontalSpacing = 20;


for (var i = 0; i < sprite_get_number(spr_tools); i++) {
	if (i == sprite_get_number(spr_tools) - 1) {
		continue;
	}
	
	var iconX = x + (windowWidth / 2);
	var iconY = y + iconMarginTop + iconPlusY;
	
	if (i mod 2 == 0) {
		iconX -= iconHorizontalSpacing;
	}
	else {
		iconX += iconHorizontalSpacing;
	}
	
	var spriteColor = c_white;
	if (currentTool == i) {
		spriteColor = c_fuchsia;
	}
	
	var iconAlpha = 1;
	
	if (not obj_control.lineGridDefaultSort) {
		if (currentTool == toolRezBrush) {
		currentTool = toolPointer;
		}
		
		if (i == 1) {
			iconAlpha = 0.5;
		}
	}
	
	draw_sprite_ext(spr_tools, i, iconX, iconY, 1, 1, 0, spriteColor, iconAlpha);
	
	var mouseoverRectX1 = iconX - sprite_get_width(spr_tools) / 2;
	var mouseoverRectY1 = iconY - sprite_get_height(spr_tools) / 2;
	var mouseoverRectX2 = mouseoverRectX1 + sprite_get_width(spr_tools);
	var mouseoverRectY2 = mouseoverRectY1 + sprite_get_height(spr_tools);
	
	var mouseover = false;
	if (point_in_rectangle(mouse_x, mouse_y, mouseoverRectX1, mouseoverRectY1, mouseoverRectX2, mouseoverRectY2)) {
		mouseover = true;
	}
	
	if (mouseover or currentTool == i) {
		var rectBuffer = 2;
		draw_set_color(global.colorThemeSelected2);
		draw_rectangle(mouseoverRectX1 - rectBuffer, mouseoverRectY1 - rectBuffer, mouseoverRectX2 + rectBuffer, mouseoverRectY2 + rectBuffer, true);
		
		if (mouseover and mouse_check_button_pressed(mb_left)) {
			obj_control.gridView = false;
			currentTool = i;
		}
	}
	
	if (i mod 2 == 1) {
		iconPlusY += iconPlusYIncrement;
	}
}

iconPlusY += iconPlusYIncrement * 0.75;

for (var i = 0; i < 2; i++) {
	var viewIconRectX1 = x + (windowWidth / 2) - iconHorizontalSpacing + (i * (iconHorizontalSpacing * 2)) - (sprite_get_width(spr_viewIcons) / 2);
	var viewIconRectY1 = y + iconPlusY - (sprite_get_height(spr_viewIcons) / 2);
	var viewIconRectX2 = viewIconRectX1 + sprite_get_width(spr_viewIcons);
	var viewIconRectY2 = viewIconRectY1 + sprite_get_height(spr_viewIcons);
	
	var mouseover = false;
	if (point_in_rectangle(mouse_x, mouse_y, viewIconRectX1, viewIconRectY1, viewIconRectX2, viewIconRectY2)) {
		mouseover = true;
	}
	
	var selected = false;
	if (i == 0 and not obj_control.gridView
	or i == 1 and obj_control.gridView) {
		selected = true;
	}
	
	if (mouseover or selected) {
		var rectBuffer = 2;
		draw_set_color(global.colorThemeSelected2);
		draw_rectangle(viewIconRectX1 - rectBuffer, viewIconRectY1 - rectBuffer, viewIconRectX2 + rectBuffer, viewIconRectY2 + rectBuffer, true);
		
		if (mouseover and mouse_check_button_pressed(mb_left)) {
			if (i == 0) {
				obj_control.gridView = false;
			}
			else if (i == 1) {
				obj_control.gridView = true;
			}
		}
	}
	
	var imageBlend = global.colorThemeText;
	if (selected) {
		imageBlend = global.colorThemeBG;	
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_rectangle(viewIconRectX1, viewIconRectY1, viewIconRectX2, viewIconRectY2, false);
	}
	
	draw_sprite_ext(spr_viewIcons, i, x + (windowWidth / 2) - iconHorizontalSpacing + (i * (iconHorizontalSpacing * 2)), y + iconPlusY, 1, 1, 0, imageBlend, 1);
}

progressBarX = camera_get_view_width(view_camera[0]) - 100;
scr_drawImportProgressBar();