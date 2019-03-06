/// @description  input_text_create_singleline(x, y, width, font)
/// @function  input_text_create_singleline
/// @param x
/// @param  y
/// @param  width
/// @param  font
// Creates a simple singleline text input. Returns instance id.
// x, y: Text position.
// width: The width of the text input area (the height will be set to the char height). In other words the width of the area to draw the text in. Parts of the text exceeding this width might not be drawn.
//        For an example, look at the "name" input box for this script. You can see it has a certain width. Text will shift and only let the text around the cursor be drawn when navigating text that can't fit this width.
// font: Text font.

return input_text_create(false, argument0, argument1, argument2, -1, argument3, c_black, 1, -1, -1, -1, -1, fa_left, fa_top, true, 0);
