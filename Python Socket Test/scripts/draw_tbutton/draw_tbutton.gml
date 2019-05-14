/// @description draw_tbutton(x, y, text,def color,check color)
/// @param x
/// @param  y
/// @param  text
/// @param def color
/// @param check color
var _x = argument0;
var _y = argument1;
var text = argument2;
var default_color=argument3;
var check_color=argument4;

var cc=draw_get_colour();

var over = (mouse_x >= _x && mouse_y >= _y
    && mouse_y < _y + string_height(string_hash_to_newline(text))
    && mouse_x < _x + string_width(string_hash_to_newline(text))
);
//
if (over) {
    draw_set_color(check_color);
} else draw_set_color(default_color);
//
draw_text(argument0, argument1, string_hash_to_newline(argument2));
draw_set_color(cc)
//
return over && mouse_check_button_released(mb_left);
