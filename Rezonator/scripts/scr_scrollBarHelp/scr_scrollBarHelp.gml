/*
	scr_scrollBar(listSize, focusedElementY, strHeight, marginTop, scrollBackColor, scrollBarColor, scrollButtonColor1, scrollButtonColor2, scrollButtonSprite, windowWidth, windowHeight);
	
	Last Updated: 2018-12-18
	
	Called from: any object
	
	Purpose: Draw the scroll bar used to naviagte a UI list
	
	Mechanism: lotso math
	
	Author: Terry DuBois
*/
function scr_scrollBarHelp(listSize, focusedElementY, strHeight, marginTop, scrollBackColor, scrollBarColor, scrollButtonColor1, scrollButtonColor2, scrollButtonSprite, windowWidth, windowHeight, relativeX, relativeY) {
	

	draw_set_alpha(1);


	var windowHeightAdjusted = windowHeight - marginTop;

	var minScrollPlusY = windowHeightAdjusted - (listSize * strHeight);
	var maxScrollPlusY = 16;

	// Setup scrollbar height limiters
	var scrollBarHeightMin = 30;
	var scrollBarHeightMax = windowHeightAdjusted - (global.scrollBarWidth * 2);

	// Set the scroll bar's width
	global.scrollBarWidth = 20;

	// Calculate the height based on the window height, string height, and the size of the list
	scrollBarHeight = ((windowHeightAdjusted / strHeight) / (listSize)) * (windowHeightAdjusted - (global.scrollBarWidth * 2));
	scrollBarHeight = clamp(scrollBarHeight, scrollBarHeightMin, scrollBarHeightMax);

	// For clicking and dragging scrollbar
	if (point_in_rectangle(mouse_x, mouse_y, relativeX + windowWidth - global.scrollBarWidth, relativeY + global.scrollBarWidth + marginTop, relativeX + windowWidth, relativeY + windowHeight - global.scrollBarWidth)) {
		mouseoverScrollBar = true;
		if (mouse_check_button_pressed(mb_left) and global.canScroll) {
			scrollBarHolding = true;
			global.canScroll = false;
			obj_control.mouseoverNeutralSpace = false;
		}
	}

	// User can't scroll if they're changing the window size
	if (windowResizeXHolding) {
		scrollBarHolding = false;
	}

	// Scroll based on clicked mouse pos
	if ((scrollBarHolding && mouse_check_button(mb_left))) {
		var val = -(relativeY - mouse_y + marginTop) - (scrollBarHeight / 2);	
		
		if (scrollBarPlusY < val) {
			scrollPlusYDest -= abs(scrollBarPlusY - val);
		}
		else if (scrollBarPlusY > val) {
			scrollPlusYDest += abs(scrollBarPlusY - val);
		}
	}


	// Limit the scrolling within bounds
	scrollPlusY = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);


	// Set new relativeY position for bar itself
	scrollBarPlusY = (scrollPlusY / minScrollPlusY) * (windowHeightAdjusted - scrollBarHeight - (global.scrollBarWidth * 2)) + global.scrollBarWidth;
	if (scrollBarHeight == windowHeightAdjusted - (global.scrollBarWidth * 2)) {
		scrollBarPlusY = 0;
	}
	// Limit the scrol bar's pos within bounds
	scrollBarPlusY = clamp(scrollBarPlusY, global.scrollBarWidth, windowHeightAdjusted - global.scrollBarWidth);

	//Instantiate drawing variables
	var scrollBarX1 = relativeX + windowWidth - global.scrollBarWidth;
	var scrollBarY1 = relativeY + scrollBarPlusY + marginTop;
	var scrollBarX2 = relativeX + windowWidth;
	var scrollBarY2 = scrollBarY1 + scrollBarHeight;

	// Draw scrollbar background
	draw_set_color(scrollBackColor);
	draw_rectangle(scrollBarX1 - clipX, relativeY + marginTop - clipY, scrollBarX2 - clipX, relativeY + windowHeightAdjusted + marginTop - clipY, false);




	// Scroll up button
	draw_set_color(scrollButtonColor1);
	if (point_in_rectangle(mouse_x, mouse_y, scrollBarX1, relativeY + marginTop, scrollBarX2, relativeY + global.scrollBarWidth + marginTop)) {
		draw_set_color(scrollButtonColor2);
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarUpButtonHeld = true;
		}
	}
	else {
		scrollBarUpButtonHeld = false;
	}
	draw_rectangle(scrollBarX1 - clipX, relativeY + marginTop - clipY, scrollBarX2 - clipX, relativeY + global.scrollBarWidth + marginTop - clipY, false);

	// Scroll down button
	draw_set_color(scrollButtonColor1);
	if (point_in_rectangle(mouse_x, mouse_y, scrollBarX1, relativeY + windowHeightAdjusted - global.scrollBarWidth + marginTop, scrollBarX2, relativeY + windowHeightAdjusted + marginTop)) {
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
	draw_rectangle(scrollBarX1 - clipX, relativeY + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, scrollBarX2 - clipX, relativeY + windowHeightAdjusted + marginTop - clipY, false);






	// Draw scrollbar
	draw_set_color(scrollBarColor);
	draw_rectangle(scrollBarX1 - clipX, scrollBarY1 - clipY, scrollBarX2 - clipX, scrollBarY2 - clipY, false);
	scrollBarCenter = mean(scrollBarY1, scrollBarY2);


	// Draw scrollbar button sprites
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(relativeY + marginTop - clipY, relativeY + global.scrollBarWidth + marginTop - clipY), 1, 1, 0, c_white, 1);
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(relativeY + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, relativeY + windowHeightAdjusted + marginTop - clipY), 1, -1, 0, c_white, 1);


	// Draw outlines of scrollbar buttons
	//draw_set_color(global.colorThemeBorders);
	//draw_rectangle(scrollBarX1 - clipX, relativeY + marginTop - clipY, scrollBarX2 - clipX, relativeY + global.scrollBarWidth + marginTop - clipY, true);
	//draw_rectangle(scrollBarX1 - clipX, relativeY + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, scrollBarX2 - clipX, relativeY + windowHeightAdjusted + marginTop - clipY, true);


	// Move scrollbar with regular scroll
	if (point_in_rectangle(mouse_x, mouse_y, relativeX, relativeY + marginTop, relativeX + windowWidth, relativeY + windowHeight)) {
		if (scrollBarUpButtonHeld) {
			scrollPlusYDest += 4;
		}
		else if (scrollBarDownButtonHeld) {
			scrollPlusYDest -= 4;
		}
	}
	scrollPlusYDest = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);


}
