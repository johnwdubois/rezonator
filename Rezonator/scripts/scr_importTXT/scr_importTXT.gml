function scr_importTXT(filename) {
	
	show_debug_message("scr_importTXT() ... START, " + scr_printTime());
	
	global.importFilename = filename;

	// clear & reset importTXTGrid
	ds_grid_clear(global.importTXTLineGrid, 0);
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, 0);
	
	
	// get a list of lines from the source file
	var fileLineList = scr_readFileUTF8(filename);
	var fileLineListSize = ds_list_size(fileLineList);
	
	// resize the importTXTLineGrid to have a row for every line in the source file
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, fileLineListSize);
	
	// fill up the importTXTLineGrid with all the text from lineList
	for (var i = 0; i < fileLineListSize; i++) {
		var lineInFile = string(ds_list_find_value(fileLineList, i));
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i, lineInFile);
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, false);
	}
	
	ds_list_destroy(fileLineList);
	
	// automatically mark comment lines as exceptions in importTXTGrid
	scr_markAutoExceptions();
	
	
	if (global.importType == global.importType_IGT) {
		// IGT import
		scr_importIGT();
	}
	else if (global.importType == global.importType_CoNLLU) {
		// CoNLL-U import
		scr_importConlluTXT(filename);
	}
	else if (global.importType == global.importType_TabDelimited || global.importType == global.importType_Transcription) {
		// tab delimited/elan/transcription import
		var fileExt = filename_ext(obj_openingScreen.openedFile);
		var delimiter = (string_count("csv", fileExt) > 0) ? "," : chr(9);
		scr_importTabbedTXT(filename, delimiter);
	}
	else if (global.importType == global.importType_PlainText || global.importType == global.importType_Paragraph) {	
		// plain text import
		scr_importPlainTXT(filename);
	}
	
	
	
	show_debug_message("scr_importTXT() ... END, " + scr_printTime());

	// if something went wrong in the import process, we exit back to the openingScreen
	// otherwise we continue to the importScreen
	if (global.exitOut) {
		global.skipToImportScreen = true;
		room_goto(rm_openingScreen);
	}
	else {
		room_goto(rm_importScreen);
	}


}
