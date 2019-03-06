/// @description  input_text_create(multiline, x, y, width, height, font, color, alpha, text wrapping width, max length, max lines, line seperation, halign, valign, text selection enabled, fit style)
/// @function  input_text_create
/// @param multiline
/// @param  x
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
// Creates a fully customized text input. Returns instance id. (This script does not offer anything more than input_text_create_singleline_ext and input_text_create_multiline_ext do.)
// multiline: Enables multiline input.
// x, y: Text position.
// width, height: The dimensions of the text input area. In other words the width and height of the area to draw the text in. Parts of the text exceeding the width/height might not be drawn. For an example, look
//                at the "name" input box for this script. You can see it has a certain width and height. Text will shift and only let the text around the cursor be drawn when navigating text that can't fit the width/height.
// height: Like the width, but will also apply vertically. Set to -1 for no limit.
// font, color, alpha: Text font, color and alpha. Alpha between 0 and 1.
// text wrapping width: When a line's string width is greater than this argument, it will split at the closest space (or if no space exists; the position closest to the width from the left). So-called text wrapping.
//                      Setting it to something smaller than your char width (e.g. to 0) will actually make the illusion of a vertical singleline (just a tip if you'd like to try vertical text input). Set to -1 for no limit. 
// max length: Highest number of characters allowed. Set to -1 for no limit.
// max lines: Highest number of lines allowed. Set to -1 for no limit.
// line separation: The separation between the lines if the text input is multiline. -1 for default.
// halign, valign: Text alignment. Use GM's built-in constants: fa_left, fa_center, fa_right, and fa_top, fa_middle, fa_bottom.
// text selection enabled: Whether the user can highlight texts with the mouse and shift key.
// fit style: How to fit the text inside the area specified on creation. 0: Won't affect scale, shifts to show text around the text cursor. 1: Uniform scaling to show all text. 2: Stretched scaling to show all text.

var instance = instance_create(argument1, argument2, obj_input_text);

with (instance) {
    multiline = argument0;
    width = argument3; height = argument4;
    font = argument5;
    color = argument6; alpha = argument7;
    wrapping_width = argument8;
    max_length = argument9;
    max_lines = argument10;
    line_separation = argument11;
    h_align = argument12;
    v_align = argument13;
    selection_enabled = argument14;
    fit_style = argument15;
    
    enabled = 0; enabled_previous = 0;
    sf_main = -1; update_surfaces = false;
    cursor_style = 0; cursor_time = 700000;
    cursor_position = 1; cursor_position_previous = cursor_position;
    action_previous = 8; text = "";
    draw_set_font(font); char_height = string_height(" "); eoln_width = 6;
    cursor = spr_input_text_cursor_default; cursor_scale = char_height / sprite_get_height(cursor);
    if (line_separation == -1) line_separation = char_height;
    if (!multiline && height == -1) height = char_height;
    clipboard_pasting_enabled = true;
    // Only windows applications have access to the real clipboard. We simulate it for the others. Move the line below to an event triggered around game start to avoid having clipboard reset for each text input.
    if (os_type != os_windows || os_browser != browser_not_a_browser) global.clipboard_local = "";
    global_scale_x = 1; global_scale_y = 1;
    local_scale_x = 1; local_scale_y = 1;
    transformation_was_changed = false;
    offset_x = 0; offset_y = 0;
    origin_x = 0; if (h_align == fa_center) origin_x += (width >> 1); else if (h_align == fa_right) origin_x += width;
    origin_y = 0; if (v_align == fa_middle) origin_y += (height >> 1); else if (v_align == fa_bottom) origin_y += height;
    matrix_identity = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
    if (fit_style == 0) matrix_local = matrix_build(origin_x, origin_y, 0, 0, 0, 0, 1, 1, 1);
    matrix_global = matrix_build(x, y, 0, 0, 0, 0, 1, 1, 1); matrix_cursor = matrix_global;
    if (os_browser == browser_not_a_browser) draw_rectangle_add = 0; else draw_rectangle_add = 1;
    shaders = true;
    
    max_undo_redo_states = 32; undo_redo_text_list = ds_list_create(); undo_redo_cursor_position_list = ds_list_create(); undo_redo_position = 0;
    if (multiline) {new_line_list = ds_list_create(); new_line_offset = 0;}
    if (selection_enabled) {
        sf_selection = -1; selection_start = 0; selection_end = 0; selection_color_background = c_black; selection_alpha_background = 0.6; selection_color_text = c_white; selection_alpha_text = 1;
        m_x_previous = 0; m_y_previous = 0; double_click_time = 500000; mouse_pressed_previous = -double_click_time;
        uniform_sf_selection = shader_get_sampler_index(sh_input_text_selection, "sf_selection");
        uniform_selection_color_text = shader_get_uniform(sh_input_text_selection, "selection_color_text"); uniform_selection_color_background = shader_get_uniform(sh_input_text_selection, "selection_color_background");
        uniform_alpha = shader_get_uniform(sh_input_text_selection, "alpha");
        selection_red_text = color_get_red(selection_color_text) / 255; selection_green_text = color_get_green(selection_color_text) / 255; selection_blue_text = color_get_blue(selection_color_text) / 255;
        selection_red_background = color_get_red(selection_color_background) / 255; selection_green_background = color_get_green(selection_color_background) / 255; selection_blue_background = color_get_blue(selection_color_background) / 255;
    }
    
    input_text_set_text(id, "");
}

return instance;
