var list = argument0;
var offsetY = argument1;


draw_set_color(c_black);
draw_set_font(font);
draw_set_halign(fa_left);

var strHeight = string_height("0");

// get first item to draw
firstItemToDraw = floor(abs(scrollPlusY));
lastItemToDraw = ds_list_size(list);

firstItemToDraw = clamp(firstItemToDraw, 0, lastItemToDraw);
lastItemToDraw = clamp(lastItemToDraw, firstItemToDraw, ds_list_size(list));

// draw items
for (var i = firstItemToDraw; i < lastItemToDraw; i++) {
	
	var currentText = ds_list_find_value(list, i);
	var textX = x + 10 - clipX;
	var textY = y + (i * strHeight) + scrollPlusY - clipY;
	
	
	draw_text(textX, textY + offsetY, currentText);
}



draw_set_color(c_black);
