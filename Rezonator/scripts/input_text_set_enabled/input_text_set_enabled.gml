/// @description  input_text_set_enabled(id, enabled)
/// @function  input_text_set_enabled
/// @param id
/// @param  enabled
// Enables/disables a text input unless it's not already enabled/disabled. When a text input is disabled, the user can't input text and the text cursor will not be shown. Text inputs are disabled when created,
// so you need this script to enable them.
// id: The instance id of the obj_input_text to be enabled.
// enabled: Whether to enable (true) or disable (false).

if (argument1) {
    if (!argument0.enabled) {
        with (obj_input_text) {enabled = false; selection_start = 0;}
        with (argument0) {
            enabled = true; enabled_step = 0;
            keyboard_string = "";
            cursor_timer = cursor_time;
            key_pressed_timer = -1; key_down = -1;
            event_perform(ev_step, ev_step_normal);
        }
    }
} else
    if (argument0.enabled)
        with (argument0) {enabled = false; selection_start = 0;}
