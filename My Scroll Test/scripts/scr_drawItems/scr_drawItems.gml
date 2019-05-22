var list = argument0;
var offsetY = argument1;


draw_set_color(c_black);
draw_set_font(font);



// draw items
for (var i = 0; i < ds_list_size(list); i++) {
	
	var currentText = ds_list_find_value(list, i);
	var textX = x + 10 - clipX;
	var textY = y + (i * string_height("0")) + scrollPlusY - clipY;
	
	
	draw_text(textX, textY + offsetY, currentText);
}



draw_set_color(c_black);
