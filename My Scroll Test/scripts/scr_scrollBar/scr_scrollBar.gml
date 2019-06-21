var listSize = argument0;
var strHeight = argument1;
var marginTop = argument2;
var scrollBackColor = argument3;
var scrollBarColor = argument4;
var scrollButtonColor1 = argument5;
var scrollButtonColor2 = argument6;


var windowHeightAdjusted = windowHeight - marginTop;

var minScrollPlusY = windowHeightAdjusted - (listSize * strHeight);
var maxScrollPlusY = 0;

// setup scrollbar height
var scrollBarHeightMin = 30;
var scrollBarHeightMax = windowHeightAdjusted - (scrollBarWidth * 2);

scrollBarWidth = 20;
scrollBarHeight = ((windowHeightAdjusted / strHeight) / (listSize)) * (windowHeightAdjusted - (scrollBarWidth * 2));
scrollBarHeight = clamp(scrollBarHeight, scrollBarHeightMin, scrollBarHeightMax);

// for clicking and dragging scrollbar
if (point_in_rectangle(mouse_x, mouse_y, x + windowWidth - scrollBarWidth, y + scrollBarWidth + marginTop, x + windowWidth, y + windowHeight - scrollBarWidth)
&& mouse_check_button_pressed(mb_left)) {
	scrollBarHolding = true;
}


// click to scroll
if (scrollBarHolding && mouse_check_button(mb_left)) {
	var val = -(y - mouse_y + marginTop) - (scrollBarHeight / 2);	
		
	if (scrollBarPlusY < val) {
		scrollPlusYDest -= abs(scrollBarPlusY - val);
	}
	else if (scrollBarPlusY > val) {
		scrollPlusYDest += abs(scrollBarPlusY - val);
	}
}
scrollPlusY = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);


// set new Y position for bar itself
scrollBarPlusY = (scrollPlusY / minScrollPlusY) * (windowHeightAdjusted - scrollBarHeight - (scrollBarWidth * 2)) + scrollBarWidth;
if (scrollBarHeight == windowHeightAdjusted - (scrollBarWidth * 2)) {
	scrollBarPlusY = 0;
}
scrollBarPlusY = clamp(scrollBarPlusY, scrollBarWidth, windowHeightAdjusted - scrollBarWidth);

var scrollBarX1 = x + windowWidth - scrollBarWidth;
var scrollBarY1 = y + scrollBarPlusY + marginTop;
var scrollBarX2 = x + windowWidth;
var scrollBarY2 = scrollBarY1 + scrollBarHeight;

// draw scrollbar background
draw_set_color(scrollBackColor);
draw_rectangle(scrollBarX1 - clipX, y + marginTop - clipY, scrollBarX2 - clipX, y + windowHeightAdjusted + marginTop - clipY, false);




// scroll up button
draw_set_color(scrollButtonColor1);
if (point_in_rectangle(mouse_x, mouse_y, scrollBarX1, y + marginTop, scrollBarX2, y + scrollBarWidth + marginTop)) {
	draw_set_color(scrollButtonColor2);
	if (mouse_check_button_pressed(mb_left)) {
		scrollBarUpButtonHeld = true;
	}
}
else {
	scrollBarUpButtonHeld = false;
}
draw_rectangle(scrollBarX1 - clipX, y + marginTop - clipY, scrollBarX2 - clipX, y + scrollBarWidth + marginTop - clipY, false);

// scroll down button
draw_set_color(scrollButtonColor1);
if (point_in_rectangle(mouse_x, mouse_y, scrollBarX1, y + windowHeightAdjusted - scrollBarWidth + marginTop, scrollBarX2, y + windowHeightAdjusted + marginTop)) {
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
}
draw_rectangle(scrollBarX1 - clipX, y + windowHeightAdjusted - scrollBarWidth + marginTop - clipY, scrollBarX2 - clipX, y + windowHeightAdjusted + marginTop - clipY, false);




// draw scrollbar
draw_set_color(scrollBarColor);
draw_rectangle(scrollBarX1 - clipX, scrollBarY1 - clipY, scrollBarX2 - clipX, scrollBarY2 - clipY, false);


// move scrollbar with regular scroll
if (point_in_rectangle(mouse_x, mouse_y, x, y + marginTop, x + windowWidth, y + windowHeight)) {
	
	// (UP ARROW or mousewheel up) and (DOWN ARROW or mousewheel down)
	if (keyboard_check(vk_up) || mouse_wheel_up() || scrollBarUpButtonHeld) {
		scrollPlusYDest += 4;
	}
	else if (keyboard_check(vk_down) || mouse_wheel_down() || scrollBarDownButtonHeld) {
		scrollPlusYDest -= 4;
	}
	
	
	
	
	// CTRL+UP and CTRL+DOWN
	if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
		scrollPlusYDest = 0;
	}
	if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
		scrollPlusYDest = -999999999999;
	}
	
	
	
	// PAGEUP and PAGEDOWN
	if (keyboard_check_pressed(vk_pageup)) {
		scrollPlusYDest += (windowHeight);
	}
	if (keyboard_check_pressed(vk_pagedown)) {
		scrollPlusYDest -= (windowHeight);
	}
}
scrollPlusYDest = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);