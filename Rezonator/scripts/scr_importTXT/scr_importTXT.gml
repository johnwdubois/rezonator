function scr_importTXT(filename) {
	
	show_debug_message("scr_importTXT ... START, " + scr_printTime());
	show_debug_message("scr_importTXT, global.importFrom: " + string(global.importFrom));
	
	global.importFilename = filename;

	// clear & reset importTXTGrid
	ds_grid_clear(global.importTXTLineGrid, 0);
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, 0);
	
	// get a list of lines from clipboard/file/ai
	var fileLineList = -1;
	if (global.importFrom == "clipboard") fileLineList = scr_importFromClipboard();
	else if (global.importFrom == "file") fileLineList = scr_readFileUTF8(filename);
	else if (global.importFrom == "ai") fileLineList = scr_importAIChat();
	var fileLineListSize = ds_list_size(fileLineList);
	
	// resize the importTXTLineGrid to have a row for every line in the source file
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, fileLineListSize);
	
	// fill up the importTXTLineGrid with all the text from lineList
	for (var i = 0; i < fileLineListSize; i++) {
		var lineInFile = string(ds_list_find_value(fileLineList, i));
		lineInFile = string_replace_all(lineInFile, "\n", "");
		lineInFile = string_replace_all(lineInFile, "\r", "");
		
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i, lineInFile);
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, false);
	}
	
	ds_list_destroy(fileLineList);
	// automatically mark comment lines as exceptions in importTXTGrid
	scr_markAutoExceptions();
	
	
	if (global.importType == "import_type_interlinear") {
		// IGT import
		scr_importIGT();
	}
	else if (global.importType == "import_type_conllu") {
		// CoNLL-U import
		scr_importConlluTXT(filename);
	}
	else if (global.importType == "import_type_elan" || global.importType == "import_type_transcription") {
		// tab delimited/elan/transcription import
		var delimiter = chr(9);
		if (instance_exists(obj_openingScreen)) {
			// check if delimiter should be comma
			var fileExt = filename_ext(obj_openingScreen.openedFile);
			if (string_count("csv", fileExt) >= 1) delimiter = ",";
		}
		scr_importTabbedTXT(delimiter);
	}
	else if (global.importType == "import_type_song" || global.importType == "import_type_prose") {	
		// plain text import
		scr_importPlainTXT();
	}
	
	
	
	show_debug_message("scr_importTXT ... END, " + scr_printTime());

	// if something went wrong in the import process, we exit back to the openingScreen
	// otherwise we continue to the importScreen
	if (!global.exitOut) {
		room_goto(rm_importScreen);
	}


}
