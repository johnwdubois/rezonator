/// @description  input_text_set_misc(id, clipboard pasting enabled, cursor sprite, cursor style, max undo/redo states, selection background color, selection background alpha, selection text color, selection text alpha, shaders)
/// @function  input_text_set_misc
/// @param id
/// @param  clipboard pasting enabled
/// @param  cursor sprite
/// @param  cursor style
/// @param  max undo/redo states
/// @param  selection background color
/// @param  selection background alpha
/// @param  selection text color
/// @param  selection text alpha
/// @param  shaders
// Sets some miscellaneous variables for a text input instance.
// id: The instance id of the obj_input_text to set the variables for.
// clipboard pasting enabled: Lets the player paste with Ctrl + V.
// cursor sprite: A sprite of your choice to use for the text cursor.
// cursor style: The look of the text cursor. 0: Alternate between showing and hiding. 1: Show, then fade out, then show etc. 2: Fade out and fade in.
// max undo/redo states: The highest number of undo/redo states to be stored in memory. -1 for no limit. 0 will disable undo/redo.
// selection background color: The color of the rectangle behind the text when text selecting.
// selection background alpha: The alpha of the rectangle behind the text when text selecting. From 0 to 1.
// selection text color: The color of the text that's selected.
// selection text alpha: The alpha of the text that's selected. From 0 to 1.
// shaders: Set to false if you don't want to use shaders. Shaders are used for fast and customizable text selection visualization. Without shaders, you won't be able to color selected text (only background).

with (argument0) {
    clipboard_pasting_enabled = argument1;
    cursor = argument2; cursor_scale = char_height / sprite_get_height(cursor);
    cursor_style = argument3;
    max_undo_redo_states = argument4;
    selection_color_background = argument5; selection_alpha_background = argument6; selection_color_text = argument7; selection_alpha_text = argument8; update_surfaces = true;
    shaders = argument9;
    
    selection_red_text = color_get_red(selection_color_text) / 255; selection_green_text = color_get_green(selection_color_text) / 255; selection_blue_text = color_get_blue(selection_color_text) / 255;
    selection_red_background = color_get_red(selection_color_background) / 255; selection_green_background = color_get_green(selection_color_background) / 255; selection_blue_background = color_get_blue(selection_color_background) / 255;
}
