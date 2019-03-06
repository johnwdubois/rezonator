/// @description  input_text_create_multiline(x, y, width, height, font, text wrapping width)
/// @function  input_text_create_multiline
/// @param x
/// @param  y
/// @param  width
/// @param  height
/// @param  font
/// @param  text wrapping width
// Creates a simple multiline text input. Returns instance id.
// x, y: Text position.
// width, height: The dimensions of the text input area. In other words the width and height of the area to draw the text in. Parts of the text exceeding the width/height might not be drawn. For an example, look
//                at the "name" input box for this script. You can see it has a certain width and height. Text will shift and only let the text around the cursor be drawn when navigating text that can't fit the width/height.
// font: Text font.
// text wrapping width: When a line's string width is greater than this argument, it will split at the closest space (or if no space exists; the position closest to the width from the left). So-called text wrapping.
//                      Setting it to something smaller than your char width (e.g. to 0) will actually make the illusion of a vertical singleline (just a tip if you'd like to try vertical text input). Set to -1 for no limit.

return input_text_create(true, argument0, argument1, argument2, argument3, argument4, c_black, 1, argument5, -1, -1, -1, fa_left, fa_top, true, 0);
