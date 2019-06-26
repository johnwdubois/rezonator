var listSize = argument0;
var focusedElementY = argument1;
var strHeight = argument2;
var marginTop = argument3;
var scrollBackColor = argument4;
var scrollBarColor = argument5;
var scrollButtonColor1 = argument6;
var scrollButtonColor2 = argument7;
var scrollButtonSprite = argument8;
var windowWidth = argument9;
var windowHeight = argument10;



var windowHeightAdjusted = windowHeight - marginTop;

var minScrollPlusY = windowHeightAdjusted - (listSize * strHeight);
var maxScrollPlusY = 16;

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


if (windowResizeXHolding) {
	scrollBarHolding = false;
}

// click to scroll
if ((scrollBarHolding && mouse_check_button(mb_left))) {
	var val = -(y - mouse_y + marginTop) - (scrollBarHeight / 2);	
		
	if (scrollBarPlusY < val) {
		scrollPlusYDest -= abs(scrollBarPlusY - val);
	}
	else if (scrollBarPlusY > val) {
		scrollPlusYDest += abs(scrollBarPlusY - val);
	}
}

/*
if (focusedElementY > y + windowHeight - marginTop) {
	//var val = focusedElementY;
	scrollPlusYDest -= strHeight;
	
	
	//if (scrollBarPlusY < val) {
	//	scrollPlusYDest -= abs(scrollBarPlusY - val);
	//}
}
*/


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

// draw scrollbar button sprites
draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + marginTop - clipY, y + scrollBarWidth + marginTop - clipY), 1, 1, 0, c_white, 1);
draw_sprite_ext(scrollButtonSprite, 0, mean(scrollBarX1 - clipX, scrollBarX2 - clipX), mean(y + windowHeightAdjusted - scrollBarWidth + marginTop - clipY, y + windowHeightAdjusted + marginTop - clipY), 1, -1, 0, c_white, 1);


// draw outlines of scrollbar buttons
draw_set_color(global.colorThemeBorders);
draw_rectangle(scrollBarX1 - clipX, y + marginTop - clipY, scrollBarX2 - clipX, y + scrollBarWidth + marginTop - clipY, true);
draw_rectangle(scrollBarX1 - clipX, y + windowHeightAdjusted - scrollBarWidth + marginTop - clipY, scrollBarX2 - clipX, y + windowHeightAdjusted + marginTop - clipY, true);


// move scrollbar with regular scroll
if (point_in_rectangle(mouse_x, mouse_y, x, y + marginTop, x + windowWidth, y + windowHeight)) {
	if (scrollBarUpButtonHeld) {
		scrollPlusYDest += 4;
	}
	else if (scrollBarDownButtonHeld) {
		scrollPlusYDest -= 4;
	}
}
scrollPlusYDest = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);