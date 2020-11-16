function scr_getImportFileRipList(filename) {
	var fileOpenRead = file_text_open_read(filename);

	while (not file_text_eof(fileOpenRead)) {
	
		var lineInFile = file_text_readln(fileOpenRead);
		ds_list_add(global.importFileRipList, lineInFile);
	
	}

	file_text_close(fileOpenRead);


}
