

function scr_readFileUTF8(filename){
	
	show_debug_message("scr_readFileUTF8 ... START, " + scr_printTime());
	
	// read a file in using GM's file_text functions
	// and then read it in again using UTF8 functions
	// if the two strings have the same length, the file is UTF8
	// read a file in using GM's file_text functions
	// and then read it in again using UTF8 functions
	// if the two strings have the same length, the file is UTF8
	var textUTF8 = "";
	var totalGMCharCount = 0;
	var totalBufferCharCount = 0;
	var lineList = ds_list_create();
	
	// read file in using GM functions
	var file = file_text_open_read(filename);
	while (!file_text_eof(file)) {
		totalGMCharCount += string_length(file_text_readln(file));
	}
	file_text_close(file);
	
	// read file in using buffer
	var buffer = buffer_load(filename);
	var size = buffer_get_size(buffer);
	while (buffer_tell(buffer) < size) {
		var currentLetter = utf8_read(buffer);
		totalBufferCharCount++;
		if(currentLetter != "\n"){
			textUTF8 += currentLetter;
		}
		else{
			ds_list_add(lineList, textUTF8);
			textUTF8 = "";
		}
	}
	if(currentLetter != "\n"){
		textUTF8 += currentLetter;
	}
	ds_list_add(lineList, textUTF8);
	buffer_delete(buffer);

	//check two file sizes for differences
	if(totalGMCharCount != totalBufferCharCount){
		show_debug_message("This file contains characters that are not encoded in UTF-8. Some characters may be missing in Rezonator.")
	}
	
	show_debug_message("scr_readFileUTF8 ... END, " + scr_printTime());
	
	//return list of lines in file
	return lineList;

}