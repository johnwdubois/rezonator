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

// Set the original height as the file loads
if(current_time - obj_control.sessionStartTime < 2000) {
	//originalWindowHeight = y;
}
// Allow hiding the Nav Window via setting each window's height to 2000
else{
	if(showTool) {
		y = originalWindowHeight;	
	} 
	else {
		y = collapsedWindowHeight;	
	}
}

if (device_mouse_check_button_released(0, mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
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
	
	/*
	if (i == sprite_get_number(spr_tools) - 1) {
		continue;
	}
	*/
	
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
		//if (currentTool == toolRezBrush) {
		//	currentTool = toolPointer;
		//}
		
		//if (i == 1) {
		//	iconAlpha = 0.5;
		//}
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
	
	if (mouseover) {
		if(global.tutorial){
			draw_set_colour(global.colorThemeBG);
			draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 110, false);
			draw_set_colour(global.colorThemeBorders);
			draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 110, true);
		}
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 16, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 16, true);

		draw_set_colour(global.colorThemeText);
		if (i == 0){
			draw_set_font(fnt_mainBold);
			draw_text(mouse_x - 172, mouse_y, "M: Pointer");
				if(global.tutorial){
					draw_set_halign(fa_center);
					draw_set_font(fnt_chainContents);
					draw_text(mouse_x - 132, mouse_y + 65 , toolTipTextPointer);
				}
		}
		if (i == 1){
			draw_set_font(fnt_mainBold);
			draw_text(mouse_x - 180, mouse_y, "R: Rez Brush");
			if(global.tutorial){
				draw_set_halign(fa_center);
				draw_set_font(fnt_chainContents);
				draw_text(mouse_x - 132, mouse_y + 65 ,toolTipTextRez);
			}
	
		}
		if (i == 2){
			draw_set_font(fnt_mainBold);
			draw_text(mouse_x - 185, mouse_y, "T: Track Brush");
			if(global.tutorial){
				draw_set_halign(fa_center);
				draw_set_font(fnt_chainContents);
				draw_text(mouse_x - 132, mouse_y + 65 ,toolTipTextTrack);
			}
		}
		if (i == 3){
			draw_set_font(fnt_mainBold);
			draw_text(mouse_x - 185, mouse_y, "K: Stack Brush");
			if(global.tutorial){
				draw_set_halign(fa_center);
				draw_set_font(fnt_chainContents);
				draw_text(mouse_x - 132, mouse_y + 65 ,toolTipTextStack);
			}
		}
		if (i == 4){
			draw_set_font(fnt_mainBold);
			draw_text(mouse_x - 180, mouse_y, "N: New Word");
			if(global.tutorial){
				draw_set_halign(fa_center);
				draw_set_font(fnt_chainContents);
				draw_text(mouse_x - 132, mouse_y + 65 ,toolTipTextNewWord);
			}
		}
		if (i == 5){
			draw_set_font(fnt_mainBold);
			draw_text(mouse_x - 180, mouse_y, "B: Box Brush");
			if(global.tutorial){
				draw_set_halign(fa_center);
				draw_set_font(fnt_chainContents);
				draw_text(mouse_x - 132, mouse_y + 65 ,toolTipTextBox);
			}
		}
	}
	
	var rectBuffer = 2;
	// Draw the outline of the focused or moused over tool
	if (mouseover or currentTool == i) {
		draw_set_color(global.colorThemeSelected2);
		draw_rectangle(mouseoverRectX1 - rectBuffer, mouseoverRectY1 - rectBuffer, mouseoverRectX2 + rectBuffer, mouseoverRectY2 + rectBuffer, true);
		
		// Switch the focus to this tool if the user has clicked in its icon
		if (mouseover and device_mouse_check_button_released(0, mb_left)) {
			obj_control.gridView = false;
			currentTool = i;
		}
	}
	
	// Shadow out tools when in the stackShow
	if(((i == 2 && tracksOnlyStackShow) || (i == 1 && rezOnlyStackShow)) && obj_control.stackShowActive) {
		draw_set_color(global.colorThemeText);
		draw_set_alpha(0.2);
		draw_rectangle(x, mouseoverRectY1 - rectBuffer, mouseoverRectX1 - rectBuffer, mouseoverRectY2 + rectBuffer, false);
		draw_rectangle(x, y, x + windowWidth, mouseoverRectY1 - rectBuffer, false);
		draw_rectangle(mouseoverRectX2 + rectBuffer, mouseoverRectY1 - rectBuffer, x + windowWidth, mouseoverRectY2 + rectBuffer, false);
		draw_rectangle(x, mouseoverRectY2 + rectBuffer, x + windowWidth, windowHeight, false);
		draw_set_alpha(1);
	}
	
	if (i mod 2 == 1 && i < sprite_get_number(spr_tools) - 1) {
		iconPlusY += iconPlusYIncrement;
	}
}

iconPlusY += iconPlusYIncrement * 2;

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
		
		if (mouseover){
			if(global.tutorial){
				draw_set_colour(global.colorThemeBG);
				draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 110, false);
				draw_set_colour(global.colorThemeBorders);
				draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 110, true);
			}
			draw_set_colour(global.colorThemeBG);
			draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 16, false);
			draw_set_colour(global.colorThemeBorders);
			draw_rectangle(mouse_x - 200, mouse_y - 16, mouse_x - 64, mouse_y + 16, true);
			draw_set_colour(global.colorThemeText);
			
			if (i == 0) {
				draw_set_font(fnt_mainBold);
				draw_text(mouse_x - 190, mouse_y, "Discourse View");
				if(global.tutorial){
					draw_set_halign(fa_center);
					draw_set_font(fnt_chainContents);
					draw_text(mouse_x - 132, mouse_y + 65 ,toolTipTextDiscourse);
				}
			}
			else if (i == 1) {

				
					draw_set_font(fnt_mainBold);
					draw_text(mouse_x - 165, mouse_y, "Grid View");
					if(global.tutorial){
						draw_set_halign(fa_center);
						draw_set_font(fnt_chainContents);
						draw_text(mouse_x - 132, mouse_y + 65 ,toolTipTextGrid);
			
				}
			}
		

		if (mouseover and device_mouse_check_button_released(0, mb_left)) {
			if (i == 0) {
				obj_control.gridView = false;
			}
		else if (i == 1) {
			obj_control.gridView = true;
			}
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