// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawEndNoteWindow(){
	
	
	//if (live_call()) return live_result;
	


	var fullWindowWidth = camera_get_view_width(camera_get_active()) / 3;
	var fullWindowHeight = camera_get_view_height(camera_get_active()) / 3;
	
	// draw dialogue box BG
	var fullWindowX = (camera_get_view_width(camera_get_active()) / 2) - (fullWindowWidth / 2);
	var fullWindowY = (camera_get_view_height(camera_get_active()) / 2) - (fullWindowHeight / 2);
	draw_set_halign(fa_left);
	draw_set_colour(c_ltgray);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + fullWindowHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + fullWindowHeight, true);
	
	if(point_in_rectangle(mouse_x, mouse_y, fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + fullWindowHeight)) {
		obj_control.mouseOverUI = true;	
	}
	
	// draw caption
	draw_set_font(global.fontMainBold);
	var captionHeight = string_height("A") * 1.25;
	draw_set_color(global.colorThemeBG);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + captionHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + captionHeight, true);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(floor(fullWindowX + 10), floor(mean(fullWindowY, fullWindowY + captionHeight)), string(game_display_name));
	
	draw_set_font(fnt_mainLarge1);
	var buttonXOffset = 65;
	var buttonYOffset = 25;
	var windowMidPointx = (fullWindowWidth/2) + fullWindowX;
	
	var okButtonX1 = windowMidPointx - 100 - buttonXOffset;
	var okButtonY1 = fullWindowY + fullWindowHeight - captionHeight - buttonYOffset;
	var okButtonX2 = windowMidPointx - 100 + buttonXOffset;
	var okButtonY2 = fullWindowY + fullWindowHeight - captionHeight + buttonYOffset;
	
	var cancelButtonX1 = windowMidPointx + 100 - buttonXOffset;
	var cancelButtonY1 = fullWindowY + fullWindowHeight - captionHeight - buttonYOffset;
	var cancelButtonX2 = windowMidPointx + 100 + buttonXOffset;
	var cancelButtonY2 = fullWindowY + fullWindowHeight - captionHeight + buttonYOffset;
	
	// draw buttons for OK and Cancel
	draw_set_colour(global.colorThemeBG);
	if(point_in_rectangle(mouse_x, mouse_y, okButtonX1, okButtonY1, okButtonX2, okButtonY2)) {
		draw_set_color(obj_control.c_ltblue);
		if (mouse_check_button_released(mb_left)) {
			obj_stacker.alarm[6] = 1;
			splitSave = true;
			showEndNoteWindow = false;
		}
	}
	draw_rectangle(okButtonX1, okButtonY1, okButtonX2, okButtonY2, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(okButtonX1, okButtonY1, okButtonX2, okButtonY2, true);
	
	draw_set_colour(global.colorThemeBG);
	if(point_in_rectangle(mouse_x, mouse_y, cancelButtonX1, cancelButtonY1, cancelButtonX2, cancelButtonY2)) {
		draw_set_color(obj_control.c_ltblue);
		if (mouse_check_button_released(mb_left)) {
			showEndNoteWindow = false;
		}
	}
	draw_rectangle(cancelButtonX1, cancelButtonY1, cancelButtonX2, cancelButtonY2, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(cancelButtonX1, cancelButtonY1, cancelButtonX2, cancelButtonY2, true);
	
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainLarge1);
	
	// draw button text
	draw_text(floor(okButtonX1), floor((okButtonY2 - okButtonY1)/2 + okButtonY1), "Create Stacks");
	draw_text(floor(cancelButtonX1), floor((cancelButtonY2 - cancelButtonY1)/2 + okButtonY1), "Cancel");
	
	
	
	// draw list window
	var listWindowBufferX = 20;
	var listWindowBufferY = captionHeight + 20;
	x = fullWindowX + listWindowBufferX;
	y = fullWindowY + listWindowBufferY;
	windowWidth = fullWindowWidth - ((x - fullWindowX) * 2);
	windowHeight = fullWindowHeight - ((y - fullWindowY) * 2);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
	
	
	
	scr_surfaceStart();
	
	// loop through the list and draw all endTagNotes
	draw_set_font(global.fontMain);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("A");
	var plusY = strHeight / 2;
	var endNoteTagsGridHeight = ds_grid_height(endNoteTagsGrid);
	var checkedEndNoteTagRectBuffer = 10;
	for (var i = 0; i < endNoteTagsGridHeight; i++) {
		var currentEndNoteTagChecked = ds_grid_get(endNoteTagsGrid, endNoteTagsGrid_colChecked, i);
		var currentEndNoteTag = ds_grid_get(endNoteTagsGrid, endNoteTagsGrid_colTag, i);
		
		var currentEndNoteTagCheckedRectX1 = x + 20 + checkedEndNoteTagRectBuffer;
		var currentEndNoteTagCheckedRectY1 = y + plusY + scrollBarPlusY - strHeight + checkedEndNoteTagRectBuffer;
		var currentEndNoteTagCheckedRectX2 = currentEndNoteTagCheckedRectX1 + strHeight - checkedEndNoteTagRectBuffer;
		var currentEndNoteTagCheckedRectY2 = currentEndNoteTagCheckedRectY1 + strHeight - checkedEndNoteTagRectBuffer;
		
		if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, currentEndNoteTagCheckedRectX1, currentEndNoteTagCheckedRectY1, currentEndNoteTagCheckedRectX2, currentEndNoteTagCheckedRectY2)) {
			if (mouse_check_button_released(mb_left)) {
				currentEndNoteTagChecked = !currentEndNoteTagChecked;
				ds_grid_set(endNoteTagsGrid, endNoteTagsGrid_colChecked, i, currentEndNoteTagChecked);
			}
		}
		
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(currentEndNoteTagCheckedRectX1 - clipX, currentEndNoteTagCheckedRectY1 - clipY, currentEndNoteTagCheckedRectX2 - clipX, currentEndNoteTagCheckedRectY2 - clipY, (!currentEndNoteTagChecked));
		
		draw_set_color(global.colorThemeText);
		draw_text(floor(currentEndNoteTagCheckedRectX2 + 15) - clipX, floor(y + plusY + scrollPlusY) - clipY, string(currentEndNoteTag));
		plusY += strHeight;
	}
	
	scr_scrollBar(endNoteTagsGridHeight, -1, strHeight, 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scr_surfaceEnd();
	
	
	
	


/*
	
	var verticleBuffer = 230;
	var horizontalBuffer = 300;
	var stackBoxXOffset = 280;
	var stackBoxYOffset = 160;
	var buttonXOffset = 65;
	var buttonYOffset = 25;
	var captionBoxWidth = 240;
	var captionBoxHeight = 185;
	var rightCenter = 160;
	
	draw_set_colour(global.colorThemePaneBG);
	if (global.colorTheme ==0) {
	draw_set_colour(c_ltgray);
	}
		
	// draw background UI
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);

		
	// draw stack box
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset - 20, camera_get_view_width(camera_get_active()) /2 + 20, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset - 20, camera_get_view_width(camera_get_active()) /2 + 21, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, true);

		
	// draw inside stack box
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 10 , camera_get_view_width(camera_get_active()) /2 + 20, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 10 , camera_get_view_width(camera_get_active()) /2 + 21, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, true);

	// draw stack caption box
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40, camera_get_view_height(camera_get_active())/2 - 50, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2 - 50 + captionBoxHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40 , camera_get_view_height(camera_get_active())/2  - 50, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2  - 50 + captionBoxHeight, true);
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40, camera_get_view_height(camera_get_active())/2 - 25, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2 - 25 + captionBoxHeight - 20, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40, camera_get_view_height(camera_get_active())/2  - 25, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2  - 25 + captionBoxHeight - 20, true);

	
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_text(floor(camera_get_view_width(camera_get_active()) / 2 - stackBoxXOffset  + 30), floor(camera_get_view_height(camera_get_active()) / 2 - stackBoxYOffset - 5), "Select All");
	
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_text(floor(camera_get_view_width(camera_get_active()) / 2 - horizontalBuffer + 15), floor(camera_get_view_height(camera_get_active()) / 2 - verticleBuffer + 15), string(game_display_name));
	
	draw_set_font(fnt_mainLarge1);

	// draw buttons for OK and Cancel
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - 100 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 - 100 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - 100 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 - 100 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset, true);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 100 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 100 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 100 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 100 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset, true);
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainLarge1);
	
	// draw button text
	draw_text(floor(camera_get_view_width(camera_get_active()) / 2 - 155), floor(camera_get_view_height(camera_get_active()) / 2 + 180), "Show Stacks");
	draw_text(floor(camera_get_view_width(camera_get_active()) / 2 + 70), floor(camera_get_view_height(camera_get_active())/2 + 180), "Cancel");
	
	*/
}