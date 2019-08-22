var list = argument0;
var offsetY = argument1;
var topAligned = argument2;


draw_set_color(c_black);
draw_set_font(font);
draw_set_halign(fa_left);

var strHeight = string_height("0");

// get first item to draw
//firstItemToDraw = 0;
//lastItemToDraw = y

//firstItemToDraw = clamp(firstItemToDraw, 0, lastItemToDraw);
//lastItemToDraw = ceil(clamp(lastItemToDraw, firstItemToDraw, ds_list_size(list)));

// draw items
for (var i = 0; i < lastItemToDraw; i++) {
	
	var currentText = ds_list_find_value(list, i);
	var textX = x + 10 - clipX;
	if (topAligned) {
		var textY = y + (i * strHeight) + scrollPlusY - clipY;
	}
	else {
		var textY = y + (strHeight * lastItemToDraw) - (i * strHeight) + scrollPlusY - clipY;
	}
	
	if (i == firstItemToDraw) {
		firstItemY = textY;
	}
	
	
	draw_text(textX, textY + offsetY, currentText);
}



draw_set_color(c_black);

if (firstItemY < -60) {
	firstItemToDraw++;
}
if (firstItemY > -30) {
	firstItemToDraw--;
}
firstItemToDraw = clamp(firstItemToDraw, 0, ds_list_size(list) - ceil(windowHeight / strHeight));

lastItemToDraw = ds_list_size(list);