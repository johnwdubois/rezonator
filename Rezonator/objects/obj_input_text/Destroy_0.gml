ds_list_destroy(undo_redo_text_list);
ds_list_destroy(undo_redo_cursor_position_list);

if (multiline) ds_list_destroy(new_line_list);

if (selection_enabled) surface_free(sf_selection);

surface_free(sf_main);

