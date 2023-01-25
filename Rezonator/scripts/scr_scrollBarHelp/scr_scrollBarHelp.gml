function scr_scrollBarHelp(listSize, focusedElementY, strHeight, marginTop, scrollBackColor, scrollBarColor, scrollButtonColor1, scrollButtonColor2, scrollButtonSprite, windowWidth, windowHeight, relativeX, relativeY) {
	

	draw_set_alpha(1);


	var windowHeightAdjusted = windowHeight - marginTop;

	var minScrollPlusY = windowHeightAdjusted - (listSize * strHeight);
	var maxScrollPlusY = 16;

	// Setup scrollbar height limiters
	var scrollBarHeightMin = 30;
	var scrollBarHeightMax = windowHeightAdjusted - (global.scrollBarWidth * 2);

	// Calculate the height based on the window height, string height, and the size of the list
	scrollBarHeight = ((windowHeightAdjusted / strHeight) / (listSize)) * (windowHeightAdjusted - (global.scrollBarWidth * 2));
	scrollBarHeight = clamp(scrollBarHeight, scrollBarHeightMin, scrollBarHeightMax);
	var mouseOverScrollBar = point_in_rectangle(mouse_x, mouse_y, relativeX + windowWidth - global.scrollBarWidth, relativeY + global.scrollBarWidth + marginTop, relativeX + windowWidth, relativeY + windowHeight - global.scrollBarWidth)
	// For clicking and dragging scrollbar
	if (mouseOverScrollBar) {
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


	var holdOffset = 0;
	if (mouseOverScrollBar || scrollBarHolding) {
		holdOffset = global.scrollBarWidth/8;
	}

	//Instantiate drawing variables
	var scrollBarX1 = relativeX + windowWidth - (global.scrollBarWidth * 0.65);
	var scrollBarY1 = relativeY + scrollBarPlusY + marginTop;
	var scrollBarX2 = relativeX + windowWidth- (global.scrollBarWidth * 0.35);
	var scrollBarY2 = scrollBarY1 + scrollBarHeight;

	scrollBarX1 -= holdOffset;
	scrollBarY1 -= holdOffset;
	scrollBarX2 += holdOffset;
	scrollBarY2 += holdOffset;

	// Scroll up button
	var mouseOverScrollUp = point_in_rectangle(mouse_x, mouse_y, scrollBarX1, relativeY + marginTop, scrollBarX2, relativeY + global.scrollBarWidth + marginTop);
	if (mouseOverScrollUp) {
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarUpButtonHeld = true;
		}
	}
	else {
		scrollBarUpButtonHeld = false;
	}

	// Scroll down button
	var mouseOverScrollDown = point_in_rectangle(mouse_x, mouse_y, scrollBarX1, relativeY + windowHeightAdjusted - global.scrollBarWidth + marginTop, scrollBarX2, relativeY + windowHeightAdjusted + marginTop)
	if (mouseOverScrollDown) {
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


	// Draw scrollbar
	draw_set_color(scrollBarColor);
	draw_roundrect(scrollBarX1 - clipX, scrollBarY1 - clipY, scrollBarX2 - clipX, scrollBarY2 - clipY, false);
	scrollBarCenter = mean(scrollBarY1, scrollBarY2);


	// Draw scrollbar button sprites
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(relativeY + marginTop - clipY, relativeY + global.scrollBarWidth + marginTop - clipY), 1, 1, 0, scrollBarColor, 1);
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(relativeY + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, relativeY + windowHeightAdjusted + marginTop - clipY), 1, -1, 0, scrollBarColor, 1);



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
