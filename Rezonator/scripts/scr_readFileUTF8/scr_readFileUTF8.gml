// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_readFileUTF8(filename){
	
	show_debug_message("scr_readFileUTF8() ... START, " + scr_printTime());
	
	// read a file in using GM's file_text functions
	// and then read it in again using UTF8 functions
	// if the two strings have the same length, the file is UTF8
	var textGM = "";
	var textUTF8 = "";
	
	// read file in using GM functions
	var file = file_text_open_read(filename);
	while (!file_text_eof(file)) {
		textGM += file_text_readln(file);
	}
	file_text_close(file);
	
	// read file in using buffer
	var buffer = buffer_load(filename);
	var size = buffer_get_size(buffer);
	while (buffer_tell(buffer) < size) {
		textUTF8 += utf8_read(buffer);
	}
	buffer_delete(buffer);
	
	var textGMLen = string_length(textGM);
	var textUTF8Len = string_length(textUTF8);
	show_debug_message("scr_identifyUTF8() ... textGM length: " + string(textGMLen) + ", textUTF8 length: " + string(textUTF8Len));
	
	if (textGMLen != textUTF8Len) {
		show_message("This file contains characters that are not encoded in UTF-8. Some characters may be missing in Rezonator.");
	}
	
		
		
	// create a list of all the lines in the file
	var lineList = ds_list_create();	
	textUTF8 = string_replace_all(textUTF8, "\r", "");
	var linebreakPos = string_pos("\n", textUTF8);
	while (linebreakPos > 0) {
		var line = string_copy(textUTF8, 1, linebreakPos);
		textUTF8 = string_delete(textUTF8, 1, linebreakPos);
		
		line = string_replace_all(line, "\n", "");
		ds_list_add(lineList, line);
			
		linebreakPos = string_pos("\n", textUTF8);
	}
	if (string_length(textUTF8) > 0) {
		textUTF8 = string_replace_all(textUTF8, "\n", "");
		ds_list_add(lineList, textUTF8);
	}
	
	show_debug_message("scr_readFileUTF8() ... file line count: " + string(ds_list_size(lineList)));
	show_debug_message("scr_readFileUTF8() ... END, " + scr_printTime());
	return lineList;

}