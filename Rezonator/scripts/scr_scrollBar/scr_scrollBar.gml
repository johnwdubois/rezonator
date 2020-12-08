function scr_scrollBar(listSize, focusedElementY, strHeight, marginTop, scrollBackColor, scrollBarColor, scrollButtonColor1, scrollButtonColor2, scrollButtonSprite, windowWidth, windowHeight) {
	/*
		scr_scrollBar(listSize, focusedElementY, strHeight, marginTop, scrollBackColor, scrollBarColor, scrollButtonColor1, scrollButtonColor2, scrollButtonSprite, windowWidth, windowHeight);
	
		Last Updated: 2018-12-18
	
		Called from: any object
	
		Purpose: Draw the scroll bar used to naviagte a UI list
	
		Mechanism: lotso math
	
		Author: Terry DuBois
	*/



	draw_set_alpha(1);


	var windowHeightAdjusted = windowHeight - marginTop;

	var minScrollPlusY = windowHeightAdjusted - (listSize * strHeight);
	var maxScrollPlusY = 16;

	// Setup scrollbar height limiters
	var scrollBarHeightMin = 30;
	var scrollBarHeightMax = windowHeightAdjusted - (global.scrollBarWidth * 2);

	// Set the scroll bar's width
	global.scrollBarWidth = max(20, window_get_width() * 0.010416);

	// Calculate the height based on the window height, string height, and the size of the list
	scrollBarHeight = ((windowHeightAdjusted / strHeight) / (listSize)) * (windowHeightAdjusted - (global.scrollBarWidth * 2));
	scrollBarHeight = clamp(scrollBarHeight, scrollBarHeightMin, scrollBarHeightMax);

	// For clicking and dragging scrollbar
	if (point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + global.scrollBarWidth + marginTop, x + windowWidth, y + windowHeight - global.scrollBarWidth)) {
		mouseoverScrollBar = true;
		if (mouse_check_button_pressed(mb_left) and global.canScroll) {
			scrollBarHolding = true;
			global.canScroll = false;
			with (obj_control) {
				mouseoverNeutralSpace = false;
			}
		}
	}

	// User can't scroll if they're changing the window size
	if (windowResizeXHolding) {
		scrollBarHolding = false;
	}

	// Scroll based on clicked mouse pos
	if ((scrollBarHolding && mouse_check_button(mb_left))) {
		var val = -(y - mouse_y + marginTop) - (scrollBarHeight / 2);	
		
		if (scrollBarPlusY < val) {
			scrollPlusYDest -= abs(scrollBarPlusY - val);
		}
		else if (scrollBarPlusY > val) {
			scrollPlusYDest += abs(scrollBarPlusY - val);
		}
	}


	// Limit the scrolling within bounds
	scrollPlusY = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);


	// Set new Y position for bar itself
	scrollBarPlusY = (scrollPlusY / minScrollPlusY) * (windowHeightAdjusted - scrollBarHeight - (global.scrollBarWidth * 2)) + global.scrollBarWidth;
	if (scrollBarHeight == windowHeightAdjusted - (global.scrollBarWidth * 2)) {
		scrollBarPlusY = 0;
	}
	
	// Limit the scroll bar's pos within bounds
	scrollBarPlusY = clamp(scrollBarPlusY, global.scrollBarWidth, windowHeightAdjusted - global.scrollBarWidth);

	//Instantiate drawing variables
	var scrollBarX1 = x + windowWidth - global.scrollBarWidth;
	var scrollBarY1 = y + scrollBarPlusY + marginTop;
	var scrollBarX2 = x + windowWidth;
	var scrollBarY2 = min(scrollBarY1 + scrollBarHeight, y + windowHeightAdjusted - global.scrollBarWidth + marginTop);

	// Draw scrollbar background
	draw_set_color(scrollBackColor);
	draw_rectangle(scrollBarX1 - clipX, y + marginTop - clipY, scrollBarX2 - clipX, y + windowHeightAdjusted + marginTop - clipY, false);




	// Scroll up button
	var scrollUpButtonX1 = scrollBarX1;
	var scrollUpButtonY1 = y + marginTop;
	var scrollUpButtonX2 = scrollBarX2;
	var scrollUpButtonY2 = y + global.scrollBarWidth + marginTop;
	draw_set_color(scrollButtonColor1);
	if (point_in_rectangle(mouse_x, mouse_y, scrollUpButtonX1, scrollUpButtonY1, scrollUpButtonX2, scrollUpButtonY2)) {
		draw_set_color(scrollButtonColor2);
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarUpButtonHeld = true;
		}
	}
	else {
		scrollBarUpButtonHeld = false;
	}
	draw_rectangle(scrollBarX1 - clipX, y + marginTop - clipY, scrollBarX2 - clipX, y + global.scrollBarWidth + marginTop - clipY, false);

	// Scroll down button
	var scrollDownButtonX1 = scrollBarX1;
	var scrollDownButtonY1 = y + windowHeightAdjusted - global.scrollBarWidth + marginTop;
	var scrollDownButtonX2 = scrollBarX2;
	var scrollDownButtonY2 = y + windowHeightAdjusted + marginTop;
	draw_set_color(scrollButtonColor1);
	if (point_in_rectangle(mouse_x, mouse_y, scrollDownButtonX1, scrollDownButtonY1, scrollDownButtonX2, scrollDownButtonY2)) {
		draw_set_color(scrollButtonColor2);
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarDownButtonHeld = true;
		}
	}
	else {
		scrollBarDownButtonHeld = false;
	}
	
	if (!mouse_check_button(mb_left)) {
		scrollBarHolding = false;
		scrollBarUpButtonHeld = false;
		scrollBarDownButtonHeld = false;
		global.canScroll = true;
	}
	
	draw_rectangle(scrollBarX1 - clipX, y + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, scrollBarX2 - clipX, y + windowHeightAdjusted + marginTop - clipY, false);






	// Draw scrollbar
	draw_set_color(scrollBarColor);
	draw_rectangle(scrollBarX1 - clipX, scrollBarY1 - clipY, scrollBarX2 - clipX, scrollBarY2 - clipY, false);
	scrollBarCenter = mean(scrollBarY1, scrollBarY2);


	// Draw scrollbar button sprites
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + marginTop - clipY, y + global.scrollBarWidth + marginTop - clipY), 1, 1, 0, c_white, 1);
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, y + windowHeightAdjusted + marginTop - clipY), 1, -1, 0, c_white, 1);
	
	if (instance_exists(obj_control)) {
		if (obj_control.showDevVars) {
			draw_set_color(global.colorThemeText);
			draw_set_halign(fa_middle);
			draw_set_valign(fa_middle);
			draw_text(mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + marginTop - clipY, y + global.scrollBarWidth + marginTop - clipY), string(scrollPlusYDest));
		}
	}
	
	// Draw outlines of scrollbar buttons
	//draw_set_color(global.colorThemeBorders);
	//draw_rectangle(scrollBarX1 - clipX, y + marginTop - clipY, scrollBarX2 - clipX, y + global.scrollBarWidth + marginTop - clipY, true);
	//draw_rectangle(scrollBarX1 - clipX, y + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, scrollBarX2 - clipX, y + windowHeightAdjusted + marginTop - clipY, true);


	// Move scrollbar with regular scroll
	if (point_in_rectangle(mouse_x, mouse_y, x, y + marginTop, x + windowWidth, y + windowHeight)) {
		if (scrollBarUpButtonHeld) {
			scrollPlusYDest += 4;
		}
		else if (scrollBarDownButtonHeld) {
			scrollPlusYDest -= 4;
		}
	}
	scrollPlusYDest = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);


}
