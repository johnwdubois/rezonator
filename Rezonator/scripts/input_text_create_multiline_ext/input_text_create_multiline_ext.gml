/// @description  input_text_create_multiline_ext(x, y, width, height, font, color, alpha, text wrapping width, max length, max lines, line seperation, halign, valign, text selection enabled, fit style)
/// @function  input_text_create_multiline_ext
/// @param x
/// @param  y
/// @param  width
/// @param  height
/// @param  font
/// @param  color
/// @param  alpha
/// @param  text wrapping width
/// @param  max length
/// @param  max lines
/// @param  line seperation
/// @param  halign
/// @param  valign
/// @param  text selection enabled
/// @param  fit style
// Creates a fully customized multiline text input. Returns instance id.
// x, y: Text position.
// width, height: The dimensions of the text input area. In other words the width and height of the area to draw the text in. Parts of the text exceeding the width/height might not be drawn. For an example, look
//                at the "name" input box for this script. You can see it has a certain width and height. Text will shift and only let the text around the cursor be drawn when navigating text that can't fit the width/height.
// font, color, alpha: Text font, color and alpha. Alpha between 0 and 1.
// text wrapping width: When a line's string width is greater than this argument, it will split at the closest space (or if no space exists; the position closest to the width from the left). So-called text wrapping.
//                      Setting it to something smaller than your char width (e.g. to 0) will actually make the illusion of a vertical singleline (just a tip if you'd like to try vertical text input). Set to -1 for no limit. 
// max length: Highest number of characters allowed. Set to -1 for no limit.
// max lines: Highest number of lines allowed. Set to -1 for no limit.
// line separation: The separation between the lines if the text input is multiline. -1 for default.
// halign, valign: Text alignment. Use GM's built-in constants: fa_left, fa_center, fa_right, and fa_top, fa_middle, fa_bottom.
// text selection enabled: Whether the user can highlight texts with the mouse and shift key.
// fit style: How to fit the text inside the area specified on creation. 0: Won't affect scale, shifts to show text around the text cursor. 1: Uniform scaling to show all text. 2: Stretched scaling to show all text.

return input_text_create(true, argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12, argument13, argument14);
