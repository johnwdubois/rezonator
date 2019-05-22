var list = argument0;
var listSize = ds_list_size(list);
var strHeight = string_height("0");

draw_set_color(c_black);
draw_set_font(font);



// draw items
for (var i = 0; i < listSize; i++) {
	
	var currentText = ds_list_find_value(list, i);
	var textX = x + 10 - clipX;
	var textY = y + (i * strHeight) + scrollPlusY - clipY;
	
	if (valueSelected == i) {
		draw_set_color(c_ltgray);
		draw_rectangle(textX, textY, textX + string_width(currentText), textY + string_height(currentText), false);
		draw_set_color(c_black);
		draw_rectangle(textX, textY, textX + string_width(currentText), textY + string_height(currentText), true);
	}
	
	draw_text(textX, textY, currentText);
}



draw_set_color(c_black);





var minScrollPlusY = windowHeight - (listSize * strHeight);
var maxScrollPlusY = 0;






// setup scrollbar height
var scrollBarHeightMin = 30;
var scrollBarHeightMax = windowHeight - (scrollBarWidth * 2);

scrollBarWidth = 20;
scrollBarHeight = ((windowHeight / strHeight) / (listSize)) * (windowHeight - (scrollBarWidth * 2));
scrollBarHeight = clamp(scrollBarHeight, scrollBarHeightMin, scrollBarHeightMax);


if (point_in_rectangle(mouse_x, mouse_y, x + windowWidth - scrollBarWidth, y + scrollBarWidth, x + windowWidth, y + windowHeight - scrollBarWidth)
&& mouse_check_button_pressed(mb_left)) {
	scrollBarHolding = true;
}

if (scrollBarHolding && mouse_check_button(mb_left)) {
	var val = -(y - mouse_y) - (scrollBarHeight / 2);
	
		
	if (scrollBarPlusY < val) {
		scrollPlusYDest -= abs(scrollBarPlusY - val);
	}
	else if (scrollBarPlusY > val) {
		scrollPlusYDest += abs(scrollBarPlusY - val);
	}
}
scrollPlusY = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);




scrollBarPlusY = (scrollPlusY / minScrollPlusY) * (windowHeight - scrollBarHeight - (scrollBarWidth * 2)) + scrollBarWidth;
if (scrollBarHeight == windowHeight - (scrollBarWidth * 2)) {
	scrollBarPlusY = 0;
}
scrollBarPlusY = clamp(scrollBarPlusY, scrollBarWidth, windowHeight - scrollBarWidth);

var scrollBarX1 = x + windowWidth - scrollBarWidth;
var scrollBarY1 = y + scrollBarPlusY;
var scrollBarX2 = x + windowWidth;
var scrollBarY2 = scrollBarY1 + scrollBarHeight;

// draw scrollbar background
draw_set_color(c_ltgray);
draw_rectangle(scrollBarX1 - clipX, y - clipY, scrollBarX2 - clipX, y + windowHeight - clipY, false);

// draw scrollbar buttons
draw_set_color(c_blue);
draw_rectangle(scrollBarX1 - clipX, y - clipY, scrollBarX2 - clipX, y + scrollBarWidth - clipY, false);
draw_rectangle(scrollBarX1 - clipX, y + windowHeight - scrollBarWidth - clipY, scrollBarX2 - clipX, y + windowHeight - clipY, false);

if (mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, scrollBarX1, y, scrollBarX2, y + scrollBarWidth)) {
	scrollBarUpButtonHeld = true;
}
if (!point_in_rectangle(mouse_x, mouse_y, scrollBarX1, y, scrollBarX2, y + scrollBarWidth)) {
	scrollBarUpButtonHeld = false;
}
if (mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, scrollBarX1, y + windowHeight - scrollBarWidth, scrollBarX2, y + windowHeight)) {
	scrollBarDownButtonHeld = true;
}
if (!point_in_rectangle(mouse_x, mouse_y, scrollBarX1, y + windowHeight - scrollBarWidth, scrollBarX2, y + windowHeight)) {
	scrollBarDownButtonHeld = false;
}

if (!mouse_check_button(mb_left)) {
	scrollBarHolding = false;
	scrollBarUpButtonHeld = false;
	scrollBarDownButtonHeld = false;
}




// draw scrollbar
draw_set_color(c_dkgray);
draw_rectangle(scrollBarX1 - clipX, scrollBarY1 - clipY, scrollBarX2 - clipX, scrollBarY2 - clipY, false);


// move scrollbar with regular scroll
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	if (keyboard_check(vk_up) || mouse_wheel_up() || scrollBarUpButtonHeld) {
		scrollPlusYDest += 4;
	}
	else if (keyboard_check(vk_down) || mouse_wheel_down() || scrollBarDownButtonHeld) {
		scrollPlusYDest -= 4;
	}
}
scrollPlusYDest = clamp(scrollPlusYDest, minScrollPlusY, maxScrollPlusY);