var list = argument0;

var strHeight = string_height("0");

draw_set_color(c_black);

// draw items
for (var i = 0; i < ds_list_size(list); i++) {
	
	var currentText = ds_list_find_value(list, i);
	draw_text(x + 10 - clipX, y + (i * strHeight) + scrollPlusY - clipY, currentText);
}




// move scrollbar
if (keyboard_check(vk_up)) {
	scrollPlusY += 4;
}
else if (keyboard_check(vk_down)) {
	scrollPlusY -= 4;
}

var minScrollPlusY = -(ds_list_size(list) * strHeight) + ((windowHeight / strHeight) * strHeight);
var maxScrollPlusY = 0;
scrollPlusY = clamp(scrollPlusY, minScrollPlusY, maxScrollPlusY);



// setup scrollbar
var scrollBarHeightMin = 30;
var scrollBarHeightMax = windowHeight - (scrollBarWidth * 2);
scrollBarWidth = 20;
scrollBarHeight = ((windowHeight / strHeight) / (ds_list_size(list))) * (windowHeight - (scrollBarWidth * 2));
scrollBarHeight = clamp(scrollBarHeight, scrollBarHeightMin, scrollBarHeightMax);

scrollBarPlusY = (scrollPlusY / minScrollPlusY) * (windowHeight - scrollBarHeight - (scrollBarWidth * 2)) + scrollBarWidth;
//scrollBarPlusY = clamp(scrollBarPlusY, scrollBarWidth, windowHeight - scrollBarWidth);

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

// draw scrollbar
draw_set_color(c_dkgray);
draw_rectangle(scrollBarX1 - clipX, scrollBarY1 - clipY, scrollBarX2 - clipX, scrollBarY2 - clipY, false);


