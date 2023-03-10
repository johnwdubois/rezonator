function scr_importFromClipboard(){
	
	show_debug_message("scr_importFromClipboard");
	
	var lineList = ds_list_create();
	if (clipboard_has_text()) {
		var clipboardText = clipboard_get_text();
		clipboardText = string_replace_all(clipboardText, "\r", "");
		
		// split clipboard text by line breaks
		var lineBreakPos = string_pos("\n", clipboardText);
		while (lineBreakPos >= 1) {
			var currentLine = string_copy(clipboardText, 1, lineBreakPos - 1);
			ds_list_add(lineList, currentLine);
			
			// find next line break
			clipboardText = string_delete(clipboardText, 1, lineBreakPos);
			lineBreakPos = string_pos("\n", clipboardText);
		}
		
		if (string_length(clipboardText) >= 1) {
			ds_list_add(lineList, clipboardText);
		}
	}
	
	return lineList;

}