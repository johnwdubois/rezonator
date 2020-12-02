function scr_scrollBarGridViewer(scrollBackColor, scrollBarColor, scrollButtonColor1, scrollButtonColor2, scrollButtonSprite, windowWidth, windowHeight) {

	var colXList = ds_map_find_value(gridViewColXListMap, scr_getGridNameString(grid));
	var firstColX = ds_list_find_value(colXList, 0);
	var lastColX = ds_list_find_value(colXList, ds_list_size(colXList) - 1);
	var colXDifference = lastColX - firstColX;
	
	var minScrollHorPlusX = -(colXDifference + 100);
	var maxScrollHorPlusX = 16;
	
	// Set the scroll button size
	var buttonSize = max(20, window_get_width() * 0.010416);
	
	// Setup scrollbar width limiters
	var scrollBarHorWidthMin = 30;
	var scrollBarHorWidthMax = windowWidth - (buttonSize * 2);
	
	// Calculate the width
	scrollBarHorWidth = (windowWidth / colXDifference) * (windowWidth - (buttonSize * 2));
	scrollBarHorWidth = clamp(scrollBarHorWidth, scrollBarHorWidthMin, scrollBarHorWidthMax);

	
	// For clicking and dragging scrollbar
	var mouseoverScrollBar = point_in_rectangle(mouse_x, mouse_y, x + buttonSize, y + windowHeight - buttonSize, x + windowWidth - buttonSize, y + windowHeight);
	if (mouseoverScrollBar) {
		if (mouse_check_button_pressed(mb_left) and global.canScroll) {
			scrollBarHorHolding = true;
			global.canScroll = false;
			with (obj_control) {
				mouseoverNeutralSpace = false;
			}
		}
	}
	
	// User can't scroll if they're changing the window size
	if (windowResizeXHolding) {
		scrollBarHorHolding = false;
	}
	
	// Scroll based on clicked mouse pos
	if (scrollBarHorHolding && mouse_check_button(mb_left)) {
		var val = -(x - mouse_x) - (scrollBarHorWidth / 2);
		show_debug_message("val: " + string(val));
		
		if (scrollBarHorPlusX < val) {
			scrollHorPlusXDest -= abs(scrollBarHorPlusX - val);
		}
		else if (scrollBarHorPlusX > val) {
			scrollHorPlusXDest += abs(scrollBarHorPlusX - val);
		}
	}
	
	// Limit the scrolling within bounds
	scrollHorPlusX = clamp(scrollHorPlusXDest, minScrollHorPlusX, maxScrollHorPlusX);
	
	// Set new X position for bar itself
	scrollBarHorPlusX = (scrollHorPlusX / minScrollHorPlusX) * (windowWidth - scrollBarHorWidth - (buttonSize * 2)) + buttonSize;
	if (scrollBarHorWidth == windowWidth - (buttonSize * 2)) {
		scrollBarHorPlusX = 0;
	}
	
	// Limit the scroll bar's pos within bounds
	scrollBarHorPlusX = clamp(scrollBarHorPlusX, buttonSize, windowWidth - buttonSize);
	
	
	
	// Declare drawing variables
	var scrollBarHorX1 = x + scrollBarHorPlusX;
	var scrollBarHorY1 = y + windowHeight - buttonSize;
	var scrollBarHorX2 = min(scrollBarHorX1 + scrollBarHorWidth, x + windowWidth - buttonSize);
	var scrollBarHorY2 = y + windowHeight;


	// Draw scrollbar background
	draw_set_color(scrollBackColor);
	draw_set_alpha(1);
	draw_rectangle(x + buttonSize - clipX, scrollBarHorY1 - clipY, x + windowWidth - buttonSize - clipX, scrollBarHorY2 - clipY, false);
	
	
	if (!mouse_check_button(mb_left)) {
		scrollBarHorHolding = false;
		scrollBarLeftButtonHeld = false;
		scrollBarRightButtonHeld = false;
		global.canScroll = true;
	}
	
	
	
	// Scroll left button
	var scrollLeftButtonX1 = x;
	var scrollLeftButtonY1 = y + windowHeight - buttonSize;
	var scrollLeftButtonX2 = x + buttonSize;
	var scrollLeftButtonY2 = y + windowHeight;
	draw_set_alpha(1);
	draw_set_color(scrollButtonColor1);
	if (point_in_rectangle(mouse_x, mouse_y, scrollLeftButtonX1, scrollLeftButtonY1, scrollLeftButtonX2, scrollLeftButtonY2)) {
		draw_set_color(scrollButtonColor2);
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarLeftButtonHeld = true;
		}
	}
	else {
		scrollBarLeftButtonHeld = false;
	}
	draw_rectangle(scrollLeftButtonX1 - clipX, scrollLeftButtonY1 - clipY, scrollLeftButtonX2 - clipX, scrollLeftButtonY2 - clipY, false);
	
	// Scroll right button
	var scrollRightButtonX1 = x + windowWidth - buttonSize;
	var scrollRightButtonY1 = y + windowHeight - buttonSize;
	var scrollRightButtonX2 = x + windowWidth;
	var scrollRightButtonY2 = y + windowHeight;
	draw_set_alpha(1);
	draw_set_color(scrollButtonColor1);
	if (point_in_rectangle(mouse_x, mouse_y, scrollRightButtonX1, scrollRightButtonY1, scrollRightButtonX2, scrollRightButtonY2)) {
		draw_set_color(scrollButtonColor2);
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarRightButtonHeld = true;
		}
	}
	else {
		scrollBarRightButtonHeld = false;
	}
	draw_rectangle(scrollRightButtonX1 - clipX, scrollRightButtonY1 - clipY, scrollRightButtonX2 - clipX, scrollRightButtonY2 - clipY, false);
	
	
	
	
	
	
	
	// Draw scrollbar
	draw_set_color(scrollBarColor);
	draw_rectangle(scrollBarHorX1 - clipX, scrollBarHorY1 - clipY, scrollBarHorX2 - clipX, scrollBarHorY2 - clipY, false);
	
	
	// Draw scrollbar button sprites
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollLeftButtonX1, scrollLeftButtonX2) - clipX, mean(scrollLeftButtonY1, scrollLeftButtonY2) - clipY, 1, 1, 90, c_white, 1);
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollRightButtonX1, scrollRightButtonX2) - clipX, mean(scrollRightButtonY1, scrollRightButtonY2) - clipY, 1, 1, 270, c_white, 1);
	
	
	// Move scrollbar with regular scroll
	if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (scrollBarLeftButtonHeld) {
			scrollHorPlusXDest += 4;
		}
		else if (scrollBarRightButtonHeld) {
			scrollHorPlusXDest -= 4;
		}
	}
	scrollHorPlusXDest = clamp(scrollHorPlusXDest, minScrollHorPlusX, maxScrollHorPlusX);

}
