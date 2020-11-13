// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_readFileUTF8(filename){
	
	// read text file in using buffer
	var buffer = buffer_load(filename);
	var size = buffer_get_size(buffer);
	
	var textRip = "";
	while (buffer_tell(buffer) < size) {
		textRip += utf8_read(buffer);
	}
	
	buffer_delete(buffer);
		
		
	// create a list of all the lines in the file
	var lineList = ds_list_create();	
	textRip = string_replace_all(textRip, "\r", "");
	var linebreakPos = string_pos("\n", textRip);
	while (linebreakPos > 0) {
		var line = string_copy(textRip, 1, linebreakPos);
		textRip = string_delete(textRip, 1, linebreakPos);
		
		line = string_replace_all(line, "\n", "");
		ds_list_add(lineList, line);
			
		linebreakPos = string_pos("\n", textRip);
	}
	if (string_length(textRip) > 0) {
		textRip = string_replace_all(textRip, "\n", "");
		ds_list_add(lineList, textRip);
	}
	
	show_debug_message("scr_readFileUTF8() ... file line count: " + string(ds_list_size(lineList)));
	return lineList;

}