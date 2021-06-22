// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_readFileUTF8(filename){
	
	show_debug_message("scr_readFileUTF8 ... START, " + scr_printTime());
	
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


	//check two file sizes for differences
	if(totalGMCharCount != totalBufferCharCount){
		show_debug_message("This file contains characters that are not encoded in UTF-8. Some characters may be missing in Rezonator.")
	}
	
	show_debug_message("scr_readFileUTF8 ... END, " + scr_printTime());
	
	//return list of lines in file
	return lineList;

}