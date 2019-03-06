// How the system works:
// When a text input is enabled, it will check for user interaction. Whenever GM's keyboard_string has text, the text is added to the text input and the keyboard_string is cleared. This way keyboard_string controls all
// character input (but the rest is done by the program (even backspace which is usually done by keyboard_string)). Input through keyboard_string is considered one of the 10 "actions":
// None (0), keyboard_string input (1), delete/backspace (2), text navigation (3), enter (4), undoing/redoing (5), cutting (6), pasting (7), text change from outside with input_text_set_text (8), transformation changed (9).
// Organizing the actions like this is useful for adding states to the undo/redo list; we don't want to add an undo/redo state for every new character, so instead we wait for the current action to
// differ from the previous one (in other words; we save when the action changes). Only one action can happen each step. The first while loop below is responsible for finding the action and start doing changes to the variable
// "text" (which holds all input). After this, if action is not 0, the update of text gets completed, and text is put into text_draw, text wrapped (if multiline), then analyzed for line information (if multiline).
// text_draw is the string that's drawn to screen in the draw event. We also update the cursor's screen position, and offsets and matrices according to "fit style" to fit the text to its width and height.
// Note that we use chr(10) a.k.a. line feed for new line characters. (We're not using the chr(13) + chr(10) standard as GM's draw_text sees this as two new lines (unless in HTML5).) The if statement in the end is for saving
// undo/redo states and updating the cursor timer. If you have any questions, send me (Dragon47) a message on the Game Maker Community website or a mail to asbjorn.lystrup@gmail.com.

if (enabled) {
    // Holding down certain keys can eventually simulate a series of presses. (E.g. holding down arrow keys when navigating text.)
    key_pressed = 0;
    if (keyboard_check_pressed(vk_anykey)) {key_pressed_timer = 380000; key_down = keyboard_key; key_pressed = key_down;}
    else {key_pressed_timer -= delta_time; if (key_pressed_timer <= 0) {key_pressed_timer = 26000; if (keyboard_check(key_down)) key_pressed = key_down;}}
    
    // Set mouse position variables and apply transformations. You can change mouse_x/y to window_mouse_get_x/y if you want it irrespective of views.
    var m_x = window_mouse_get_x() - x, m_y = window_mouse_get_y() - y;
    if (image_angle != 0) {var t_x = m_x, t_y = m_y; m_x = lengthdir_x(t_x, image_angle) + lengthdir_y(t_y, image_angle); m_y = lengthdir_x(t_y, image_angle) - lengthdir_y(t_x, image_angle);}
    if (image_xscale == 0) m_x = 0; else m_x /= image_xscale;
    if (image_yscale == 0) m_y = 0; else m_y /= image_yscale;
}

draw_set_font(font);
var cursor_stay_visible = false, add_to_text = "", action = 0;
if (max_undo_redo_states != 0) var text_previous = text;
if (selection_enabled) var selection_update = false;
    
// Checks actions for moving the cursor or changing text.
while (true) {
    // If input_text_set_text was called.
    if (is_string(text_change_from_outside)) {
        text = text_change_from_outside; text_change_from_outside = false;
        cursor_position = string_length(text) + 1;
        if (selection_enabled) selection_start = 0;
        cursor_stay_visible = true; action = 8; break;
    }
    
    // If input_text_set_transformation was called.
    if (transformation_was_changed) {
        transformation_was_changed = false;
        action = 9; break;
    }
    
    // Further input is only available if the text input is enabled.
    if (!enabled) break;
    
    // Copying/cutting.
    if (selection_enabled && selection_start != 0 && keyboard_check(vk_control)) {
        if (key_pressed == ord("C") || key_pressed == ord("X")) {
            var s = string_copy(text, selection_start_ordered, selection_end_ordered - selection_start_ordered);
            if (os_type == os_windows && os_browser == browser_not_a_browser) clipboard_set_text(s); else global.clipboard_local = s;
            if (key_pressed == ord("X")) {action = 6; break;}
        }
    }
    
    // Undos/redos. (When undoing/redoing, the previous text and cursor position is swapped with the text and cursor position previously saved in the undo/redo lists.)
    if (max_undo_redo_states != 0 && keyboard_check(vk_control)) {
        if (((keyboard_check(vk_shift) && key_pressed == ord("Z")) || key_pressed == ord("Y")) && undo_redo_position < ds_list_size(undo_redo_text_list) - 1) {
            ++undo_redo_position;
            text = undo_redo_text_list[| undo_redo_position]; cursor_position = undo_redo_cursor_position_list[| undo_redo_position];
            if (selection_enabled) selection_start = 0;
            cursor_stay_visible = true; action = 5; break;
        }
        if (!keyboard_check(vk_shift) && key_pressed == ord("Z") && undo_redo_position > 0) {
            --undo_redo_position;
            text = undo_redo_text_list[| undo_redo_position]; cursor_position = undo_redo_cursor_position_list[| undo_redo_position];
            if (selection_enabled) selection_start = 0;
            cursor_stay_visible = true; action = 5; break;
        }
    }
    
    // Text navigation with up/down and mouse, and double click/ctrl + A selection.
    if (selection_enabled && keyboard_check(vk_control) && key_pressed == ord("A")) {
        selection_start = 1; cursor_position = string_length(text) + 1; selection_update = true;
        action = 3; break;
    }
    if (mouse_check_button_pressed(mb_left) || (selection_enabled && mouse_check_button(mb_left) && (m_x != m_x_previous || m_y != m_y_previous))
       || (multiline && (key_pressed == vk_up || key_pressed == vk_down || key_pressed == vk_pageup || key_pressed == vk_pagedown))) {
        if (selection_enabled) {
            var double_clicked = false;
            if (mouse_check_button_pressed(mb_left)) {
                double_clicked = (enabled_step > 1 && selection_start == 0 && m_x == m_x_previous && m_y == m_y_previous && get_timer() - mouse_pressed_previous < double_click_time
                                 && (string_lettersdigits_universal(string_char_at(text, cursor_position)) != "" || string_lettersdigits_universal(string_char_at(text, cursor_position - 1)) != ""));
                mouse_pressed_previous = get_timer();
            }
        }
        if (selection_enabled && double_clicked) {
            mouse_clear(mb_left);
            if (multiline && cursor_position < 0) cursor_position = -cursor_position + 1;
            selection_start = cursor_position;
            var char, char_before;
            while (true) {
                char = string_char_at(text, selection_start);
                if (selection_start == 1) char_before = ""; else char_before = string_char_at(text, selection_start - 1);
                if (string_lettersdigits_universal(char) != "" && string_lettersdigits_universal(char_before) == "") break;
                --selection_start; if (selection_start <= 1) break;
            }
            while (true) {
                char = string_char_at(text, cursor_position);
                if (cursor_position == 1) char_before = ""; else char_before = string_char_at(text, cursor_position - 1);
                if (string_lettersdigits_universal(char) == "" && string_lettersdigits_universal(char_before) != "") break;
                ++cursor_position; if (cursor_position > string_length(text)) break;
            }
            selection_update = true;
        } else {
            var searched_width = 0, smallest = -1, target_width, last_index, line_width, line;
            if (multiline) {
                if (key_pressed == vk_up) {
                    line = cursor_line - 1;
                    if (keyboard_check(vk_control)) while (line > 0) {
                        if (new_line_list[| line] - 1 == new_line_list[| line - 1] && cursor_position != new_line_list[| line] + 1 && string_char_at(text, new_line_list[| line] + 1) != chr(10)) break; --line;
                    }
                } else if (key_pressed == vk_down) {
                    line = cursor_line + 1;
                    if (keyboard_check(vk_control)) while (line < lines - 1) {
                        if (new_line_list[| line] - 1 == new_line_list[| line - 1] && string_char_at(text, new_line_list[| line] + 1) != chr(10)) break; ++line;
                    }
                } else if (key_pressed == vk_pageup) {
                    if (keyboard_check(vk_control)) {
                        if (v_align == fa_top) line = ceil(-offset_y / line_separation);
                        else if (v_align == fa_bottom) line = ceil(lines - (offset_y + height) / line_separation);
                        else line = ceil(lines * 0.5 - (height * 0.5 + offset_y) / line_separation);
                    } else {line = cursor_line - (height div line_separation); offset_y += (height div line_separation) * line_separation;}
                } else if (key_pressed == vk_pagedown) {
                    if (keyboard_check(vk_control)) {
                        if (v_align == fa_top) line = floor((height - offset_y) / line_separation - 1);
                        else if (v_align == fa_bottom) line = floor(lines - offset_y / line_separation - 1);
                        else line = floor(lines * 0.5 + (height * 0.5 - offset_y) / line_separation - 1);
                    } else {line = cursor_line + (height div line_separation); offset_y -= (height div line_separation) * line_separation;}
                } else line = (m_y - offset_y - v_align_offset) div line_separation;
                line = clamp(line, 0, lines - 1);
                cursor_position = new_line_list[| line] + 1; last_index = min(new_line_list[| line + 1], string_length(text)) + 1;
                line_width = string_width(string_copy(text, cursor_position, last_index - cursor_position));
            } else {cursor_position = 1; last_index = string_length(text) + 1; line_width = text_width;}
            if (multiline && (key_pressed == vk_up || key_pressed == vk_down)) {if (keyboard_check(vk_control)) target_width = -line_width; else target_width = cursor_offset_x - offset_x;}
            else if (multiline && (key_pressed == vk_pageup || key_pressed == vk_pagedown)) target_width = cursor_offset_x - offset_x; else target_width = m_x - offset_x;
            if (h_align == fa_center) target_width += (line_width >> 1); else if (h_align == fa_right) target_width += line_width;
            if (target_width > 0) while (true) {
                if (smallest == -1 || abs(target_width - searched_width) <= smallest) smallest = abs(target_width - searched_width); else {--cursor_position; break;}
                if (cursor_position == last_index) break;
                searched_width += string_width(string_char_at(text, cursor_position)); ++cursor_position;
            }
            if (multiline && cursor_position == last_index && cursor_position - 1 < string_length(text)) {--cursor_position; if (string_char_at(text, cursor_position) != chr(10)) cursor_position *= -1;}
        }
        m_x_previous = m_x; m_y_previous = m_y;
        action = 3; break;
    }
    
    // Pasting text.
    if (clipboard_pasting_enabled && keyboard_check(vk_control) && key_pressed == ord("V") && (((os_type != os_windows || os_browser != browser_not_a_browser) && global.clipboard_local != "") || clipboard_has_text())) {
        var s; if (os_type == os_windows && os_browser == browser_not_a_browser) s = clipboard_get_text(); else s = global.clipboard_local;
        add_to_text = string_replace_all(s, chr(13), "");
        if (!multiline) add_to_text = string_replace_all(add_to_text, chr(10), "");
        action = 7; break;
    }
    
    // Adding new lines.
    if (multiline && key_pressed == vk_enter) {add_to_text = chr(10); action = 4; break;}
    
    // Delete and backspace.
    if (key_pressed == vk_delete) {
        if (selection_enabled && selection_start != 0) {action = 2; break;}
        if (cursor_position <= string_length(text)) {
            var position = cursor_position;
            if (keyboard_check(vk_control))
                while (position <= string_length(text)) {
                    var char = string_char_at(text, position), char_next = string_char_at(text, position + 1);
                    if (char == chr(10) || char_next == chr(10) || (string_lettersdigits_universal(char) == "" && string_lettersdigits_universal(char_next) != "")) break;
                    ++position;
                }
            text = string_delete(text, cursor_position, position - cursor_position + 1);
            cursor_stay_visible = true; action = 2; break;
        }
    }
    if (key_pressed == vk_backspace) {
        if (selection_enabled && selection_start != 0) {action = 2; break;}
        if (cursor_position > 1) {
            var position = cursor_position - 1;
            if (keyboard_check(vk_control))
                while (position > 1) {
                    var char = string_char_at(text, position), char_before = string_char_at(text, position - 1);
                    if (char == chr(10) || char_before == chr(10) || (string_lettersdigits_universal(char) != "" && string_lettersdigits_universal(char_before) == "")) break;
                    --position;
                }
            text = string_delete(text, position, cursor_position - position); cursor_position = position;
            action = 2; break;
        }
    }
    
    // Text navigation with home/end and right/left.
    if (key_pressed == vk_home) {if (multiline && !keyboard_check(vk_control)) cursor_position = new_line_list[| cursor_line] + 1; else cursor_position = 1; action = 3; break;}
    if (key_pressed == vk_end) {
        if (multiline && !keyboard_check(vk_control)) {
            cursor_position = new_line_list[| cursor_line + 1]; if (cursor_position <= string_length(text) && string_char_at(text, cursor_position) != chr(10)) cursor_position *= -1;
        } else cursor_position = string_length(text) + 1; action = 3; break;
    }
    if (key_pressed == vk_right || key_pressed == vk_left) {
        do {
            if (key_pressed == vk_right) {if (cursor_position > string_length(text)) break; ++cursor_position;}
            else {if (cursor_position == 1) break; --cursor_position;}
            var char = string_char_at(text, cursor_position), char_before = string_char_at(text, cursor_position - 1);
        } until (!keyboard_check(vk_control) || char == chr(10) || char_before == chr(10) || (string_lettersdigits_universal(char) != "" && string_lettersdigits_universal(char_before) == ""));
        action = 3; break;
    }
    
    // Removes the ""-characters that keyboard_string gets when you do Ctrl + Backspace. Then adds the characters to text.
    keyboard_string = string_replace_all(keyboard_string, "", "");
    if (keyboard_string != "") {add_to_text = keyboard_string; action = 1; break;}
    
    break;
}

if (action) {
    keyboard_string = "";

    // Deletes characters in text selection (if enabled). Adds new characters. Limits text if too long.
    if (action != 3) {
        if (selection_enabled && selection_start != 0) {
            text = string_delete(text, selection_start_ordered, selection_end_ordered - selection_start_ordered);
            cursor_position = selection_start_ordered; selection_start = 0; cursor_stay_visible = true;
        }
        if (add_to_text != "") {text = string_insert(add_to_text, text, cursor_position); cursor_position += string_length(add_to_text);}
        if (max_length != -1 && string_length(text) > max_length) {cursor_position -= string_length(text) - max_length; text = string_delete(text, cursor_position, string_length(text) - max_length);}
    }
    
    // Updates new_line_list and text_draw (possibly text too) when needed. (new_line_list contains the string positions for all chr(10)s and a beginning and an end. It'll also automatically add chr(10)s when text wrapping.)
    if (multiline) {
        if (action != 3) {
            while (true) {
                text_draw = text;
                ds_list_clear(new_line_list); ds_list_add(new_line_list, 0);
                var position = 0, delta_position, offset = 0;
                while (position <= string_length(text)) {
                    delta_position = string_pos(chr(10), string_delete(text, 1, position)); if (!delta_position) delta_position = string_length(text) + 1 - position;
                    if (wrapping_width != -1) {
                        var position_1 = 0, delta_position, text_line = string_copy(text, position + 1, delta_position - 1), searched_width = 0, t;
                        if (string_width(text_line) > wrapping_width) {
                            while (true) {
                                delta_position_1 = string_pos(" ", string_delete(text_line, 1, position_1));
                                if (!delta_position_1 || string_width(string_copy(text_line, 1, position_1 + delta_position_1 - 1)) > wrapping_width) break;
                                position_1 += delta_position_1;
                            }
                            if (h_align == fa_right && position_1 == 1 && string_char_at(text_line, 1) == " ") position_1 = 0;
                            if (position_1 == 0) while (true) {
                                ++position_1; searched_width += string_width(string_char_at(text_line, position_1));
                                if (searched_width > wrapping_width) {--position_1; break;}
                            }
                            if (position_1 == 0 && delta_position != 2) position_1 = 1;
                            if (position_1 != 0) {
                                delta_position = position_1 - (h_align == fa_right && string_char_at(text_line, position_1) == " " && position_1 != 1);
                                ++offset; text_draw = string_insert(chr(10), text_draw, position + delta_position + offset);
                            }
                        }
                    }
                    position += delta_position; ds_list_add(new_line_list, position);
                }
                lines = ds_list_size(new_line_list) - 1;
                var i = 1, t = abs(cursor_position); while (t > new_line_list[| i]) ++i; cursor_line = i - 1;
                if (max_lines != -1 && lines > max_lines) {
                    if (lines > max_lines + 1) {var t = new_line_list[| cursor_line + max_lines + 2 - lines]; text = string_delete(text, t, cursor_position - t); cursor_position = t;}
                    else {--cursor_position; text = string_delete(text, cursor_position, 1);}
                } else break;
            }
            text_draw = text_draw;
        } else {var i = 1, t = abs(cursor_position); while (t > new_line_list[| i]) ++i; cursor_line = i - 1;}
    } else text_draw = text;
    
    // Updates the vertical alignment offset, the cursor's display position, and visually fits the text inside the input area.
    var text_height_above_cursor, text_width_left_of_cursor, line_width;
    text_width = string_width(text_draw);
    if (multiline) {
        text_height = line_separation * (lines - 1) + char_height; text_height_above_cursor = line_separation * cursor_line;
        line_width = string_width(string_copy(text, new_line_list[| cursor_line] + 1, new_line_list[| cursor_line + 1] - new_line_list[| cursor_line]));
        if (cursor_position < 0) text_width_left_of_cursor = line_width;
        else text_width_left_of_cursor = string_width(string_copy(text, new_line_list[| cursor_line] + 1, cursor_position - new_line_list[| cursor_line] - 1));
    } else {
        text_height = char_height; text_height_above_cursor = 0;
        text_width_left_of_cursor = string_width(string_copy(text, 1, cursor_position - 1));
        line_width = text_width;
    }
    v_align_offset = 0;
    cursor_offset_x = text_width_left_of_cursor;
    if (h_align == fa_center) cursor_offset_x -= (line_width >> 1); else if (h_align == fa_right) cursor_offset_x -= line_width;
    if (v_align == fa_middle) v_align_offset -= (text_height >> 1); else if (v_align == fa_bottom) v_align_offset -= text_height;
    cursor_offset_y = text_height_above_cursor + v_align_offset;
    var local_scale_x_previous = local_scale_x, local_scale_y_previous = local_scale_y;
    if (fit_style == 0) {
        offset_x = clamp(offset_x, -origin_x - cursor_offset_x, -origin_x + width - cursor_offset_x);
        offset_y = clamp(offset_y, -origin_y - cursor_offset_y, -origin_y + height - cursor_offset_y - char_height);
        
        if (h_align == fa_left) offset_x = clamp2(offset_x, width - text_width, 0);
        else if (h_align == fa_right) offset_x = clamp2(offset_x, 0, text_width - width);
        else offset_x = clamp2(offset_x, (width - text_width) >> 1, (text_width - width) >> 1);
        
        if (v_align == fa_top) offset_y = clamp2(offset_y, height - text_height, 0);
        else if (v_align == fa_bottom) offset_y = clamp2(offset_y, 0, text_height - height);
        else offset_y = clamp2(offset_y, (height - text_height) >> 1, (text_height - height) >> 1);
        
        cursor_offset_x += offset_x; cursor_offset_y += offset_y;
    } else {
        if (text_width <= width) local_scale_x = 1; else local_scale_x = width / text_width;
        if (text_height <= height) local_scale_y = 1; else local_scale_y = height / text_height;
        if (fit_style == 1) {local_scale_x = min(local_scale_x, local_scale_y); local_scale_y = local_scale_x;}
        matrix_local = matrix_build(origin_x, origin_y, 0, 0, 0, 0, local_scale_x, local_scale_y, 1);
        offset_x = 0; offset_y = 0;
    }
    if (local_scale_x != local_scale_x_previous || local_scale_y != local_scale_y_previous) {
        image_xscale = global_scale_x * local_scale_x; image_yscale = global_scale_y * local_scale_y;
        if (os_browser == browser_not_a_browser) {
            matrix_cursor = matrix_build(0, 0, 0, 0, 0, 0, image_xscale, image_yscale, 1); matrix_cursor = matrix_multiply(matrix_cursor, matrix_build(x, y, 0, 0, 0, image_angle, 1, 1, 1));
        }
    }
    if (os_browser != browser_not_a_browser) {
        var t_x = cursor_offset_x * image_xscale, t_y = cursor_offset_y * image_yscale;
        cursor_x = round(x + lengthdir_x(t_x, image_angle) - lengthdir_y(t_y, image_angle));
        cursor_y = round(y + lengthdir_x(t_y, image_angle) + lengthdir_y(t_x, image_angle));
    }
    
    // If a certain change in action was recognized this step, this saves the previous text and cursor position to the undo/redo list.
    if (max_undo_redo_states != 0 && action != action_previous && (action != 3 || cursor_position != cursor_position_previous) && action != 9) {
        if (!(action == 3 && action_previous == 5) && !(action == 5 && action_previous == 3)) {
            var last;
            if (action == 5) --undo_redo_position;
            else while (true) {
                last = ds_list_size(undo_redo_text_list) - 1;
                if (undo_redo_position == last + 1) break;
                ds_list_delete(undo_redo_text_list, last); ds_list_delete(undo_redo_cursor_position_list, last);
            }
            ds_list_add(undo_redo_text_list, text_previous); ds_list_add(undo_redo_cursor_position_list, cursor_position_previous);
            if (max_undo_redo_states != -1) while (ds_list_size(undo_redo_text_list) > max_undo_redo_states) {
                ds_list_delete(undo_redo_text_list, 0); ds_list_delete(undo_redo_cursor_position_list, 0);
                --undo_redo_position;
            }
            ++undo_redo_position;
        }
        action_previous = action;
    }
    
    // If text selection is happening.
    if (selection_enabled) {
        if (action == 3 && (keyboard_check(vk_shift) || (mouse_check_button(mb_left) && !mouse_check_button_pressed(mb_left))) || selection_update) {
            var i;
            if (selection_start == 0 || selection_update) {
                if (!selection_update) selection_start = cursor_position_previous;
                if (multiline) {
                    if (selection_start < 0) selection_start = -selection_start + 1;
                    i = 0; while (selection_start > new_line_list[| i]) ++i; selection_start_line = i - 1;
                } else selection_start_line = 0;
            }
            selection_end = cursor_position;
            if (multiline) {
                if (selection_end < 0) selection_end = -selection_end + 1;
                i = 0; while (selection_end > new_line_list[| i]) ++i; selection_end_line = i - 1;
            } else selection_end_line = 0;
            if (selection_start == selection_end) {
                selection_start = 0;
            } else if (selection_start < selection_end) {
                selection_start_ordered = selection_start; selection_end_ordered = selection_end;
                selection_start_line_ordered = selection_start_line; selection_end_line_ordered = selection_end_line;
            } else {
                selection_start_ordered = selection_end; selection_end_ordered = selection_start;
                selection_start_line_ordered = selection_end_line; selection_end_line_ordered = selection_start_line;
            }
        } else if (selection_start != 0) {selection_start = 0; cursor_stay_visible = true;}
    }
    
    if (cursor_position != cursor_position_previous) {cursor_stay_visible = true; cursor_position_previous = cursor_position;}
    
    // Most text editors allow for two different visualizations of the cursor when it's between text wrapped lines; either end of first line, or beginning of second line. A negative cursor position indicates end of line.
    if (multiline && cursor_position < 0) cursor_position = -cursor_position + 1;
    
    update_surfaces = true;
}

if (enabled) {
    ++enabled_step;
    // Makes the cursor blink.
    cursor_timer -= delta_time; if (cursor_timer <= -cursor_time || cursor_stay_visible) cursor_timer = cursor_time;
}

