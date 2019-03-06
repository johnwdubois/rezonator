/// @description  input_text_create_singleline_ext(x, y, width, font, color, alpha, max length, halign, valign, text selection enabled, fit style)
/// @function  input_text_create_singleline_ext
/// @param x
/// @param  y
/// @param  width
/// @param  font
/// @param  color
/// @param  alpha
/// @param  max length
/// @param  halign
/// @param  valign
/// @param  text selection enabled
/// @param  fit style
// Creates a fully customized singleline text input. Returns instance id.
// x, y: Text position.
// width: The width of the text input area (the height will be set to the char height). In other words the width of the area to draw the text in. Parts of the text exceeding this width might not be drawn.
//        For an example, look at the "name" input box for this script. You can see it has a certain width. Text will shift and only let the text around the cursor be drawn when navigating text that can't fit this width.
// font, color, alpha: Text font, color and alpha. Alpha between 0 and 1.
// max length: Highest number of characters allowed. Set to -1 for no limit.
// halign, valign: Text alignment. Use GM's built-in constants: fa_left, fa_center, fa_right, and fa_top, fa_middle, fa_bottom.
// text selection enabled: Whether the user can highlight texts with the mouse and shift key.
// fit style: How to fit the text inside the area specified on creation. 0: Won't affect scale, shifts to show text around the text cursor. 1: Uniform scaling to show all text. 2: Stretched scaling to show all text.

return input_text_create(false, argument0, argument1, argument2, -1, argument3, argument4, argument5, -1, argument6, -1, -1, argument7, argument8, argument9, argument10);
