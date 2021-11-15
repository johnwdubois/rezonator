function scr_scrollBar(listSize, focusedElementY, strHeight, marginTop, scrollBackColor, scrollBarColor, scrollButtonColor1, scrollButtonColor2, scrollButtonSprite, windowWidth, windowHeight) {
	
	/*
		Purpose: Draw the scroll bar used to naviagte a UI list
	*/
	
	var scrollCancel = instance_exists(obj_flyout);
	if (instance_exists(obj_dropDown) && object_index != obj_dropDown) scrollCancel = true;
	
	var outterBuffer = 50;
	var mouseNear = point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth - outterBuffer, y - outterBuffer, x + windowWidth + outterBuffer, y + windowHeight + outterBuffer);
	var currentAlpha = (mouseNear || scrollBarHolding) ? 1 : 0.5;
	draw_set_alpha(currentAlpha);


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
	mouseoverScrollBar = point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + global.scrollBarWidth + marginTop, x + windowWidth, y + windowHeight - global.scrollBarWidth);
	
	if (scrollBarHeight == scrollBarHeightMax) currentAlpha = 0;
	draw_set_alpha(currentAlpha);
	
	// For clicking and dragging scrollbar
	if (mouseoverScrollBar) {
		if (mouse_check_button_pressed(mb_left) and global.canScroll) {
			scrollBarHolding = true;
			global.canScroll = false;
			with (obj_control) {
				mouseoverNeutralSpace = false;
			}
		}
	}

	// User can't scroll if they're changing the window size
	if (windowResizeXHolding || scrollCancel) {
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
	var scrollBarX1 = x + windowWidth - (global.scrollBarWidth * 0.65);
	var scrollBarY1 = y + scrollBarPlusY + marginTop;
	var scrollBarX2 = x + windowWidth - (global.scrollBarWidth * 0.35);
	var scrollBarY2 = min(scrollBarY1 + scrollBarHeight, y + windowHeightAdjusted - global.scrollBarWidth + marginTop);
	
	// adjust for whether mouse is near
	var holdOffset = 0;
	if(mouseoverScrollBar || scrollBarHolding){
		holdOffset = global.scrollBarWidth/8;
	}
	scrollBarX1 -= holdOffset;
	scrollBarY1 -= holdOffset;
	scrollBarX2 += holdOffset;
	scrollBarY2 += holdOffset;
	

	// Scroll up button
	var scrollUpButtonX1 = x + windowWidth - global.scrollBarWidth;
	var scrollUpButtonY1 = y + marginTop;
	var scrollUpButtonX2 = x + windowWidth;
	var scrollUpButtonY2 = y + global.scrollBarWidth + marginTop;
	var mouseOverUpButton = point_in_rectangle(mouse_x, mouse_y, scrollUpButtonX1, scrollUpButtonY1, scrollUpButtonX2, scrollUpButtonY2);
	if (mouseOverUpButton) {
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarUpButtonHeld = true;
		}
	}
	else {
		scrollBarUpButtonHeld = false;
	}
	
	// Scroll down button
	var scrollDownButtonX1 = scrollUpButtonX1;
	var scrollDownButtonY1 = y + windowHeightAdjusted - global.scrollBarWidth + marginTop;
	var scrollDownButtonX2 = scrollUpButtonX2;
	var scrollDownButtonY2 = y + windowHeightAdjusted + marginTop;
	var mouseOverDownButton = point_in_rectangle(mouse_x, mouse_y, scrollDownButtonX1, scrollDownButtonY1, scrollDownButtonX2, scrollDownButtonY2);
	if (mouseOverDownButton) {
		if (mouse_check_button_pressed(mb_left)) {
			scrollBarDownButtonHeld = true;
		}
	}
	else {
		scrollBarDownButtonHeld = false;
	}
	
	// make sure we're not holding scrollbar if user does not have mb_left held
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
	var scrollUpScale = (mouseOverUpButton) ? 1.2: 1;
	var scrollDownScale = (mouseOverDownButton) ? 1.2: 1;
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + marginTop - clipY, y + global.scrollBarWidth + marginTop - clipY), scrollUpScale, scrollUpScale, 0, scrollBarColor, currentAlpha);
	draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + windowHeightAdjusted - global.scrollBarWidth + marginTop - clipY, y + windowHeightAdjusted + marginTop - clipY), scrollDownScale, -scrollDownScale, 0, scrollBarColor, currentAlpha);
	
	if (instance_exists(obj_control)) {
		if (obj_control.showDevVars) {
			draw_set_color(global.colorThemeText);
			draw_set_halign(fa_middle);
			draw_set_valign(fa_middle);
			draw_text(mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + marginTop - clipY, y + global.scrollBarWidth + marginTop - clipY), string(scrollPlusYDest));
		}
	}
	


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
	draw_set_alpha(1);
}
