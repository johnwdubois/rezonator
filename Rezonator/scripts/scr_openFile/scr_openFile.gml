function scr_openFile() {
	
	/*
	show_debug_message("global.importType: " + string(global.importType));

	if(global.previousImportDirectory == ""){
	
		var discourseDirString = global.rezonatorDirString + "\\Data\\SBCorpus\\Transcript";
		if (os_type == os_macosx) {
			discourseDirString = global.currentDirString + "/Data/SBCorpus/Transcript";
		}

	}
	else{
		var discourseDirString = global.previousImportDirectory;
	
		var charAt = string_length(discourseDirString);
		while (string_char_at(discourseDirString, charAt) == " " and charAt > 0) {
			charAt--;
		}
		discourseDirString = string_delete(discourseDirString, charAt, string_length(discourseDirString) - charAt);

	}

	
	var fileExtension = "";
	if (global.importType == global.importType_CSV) {
		fileExtension = "CSV (.csv)|*.csv";
	}
	else if (global.importType == global.importType_CoNLLU) {
		fileExtension = "CoNLL-U (.txt)|*.txt";
	}
	else if (global.importType == global.importType_PlainText) {
		fileExtension = scr_get_translation("import_type_song") +" (.txt)|*.txt";
	}
	else if (global.importType == global.importType_Paragraph) {
		fileExtension = "Paragraph (.txt)|*.txt";
	}
	else if (global.importType == global.importType_TabDelimited) {
		fileExtension = "Tab delimited (.txt)|*.txt";
	}
	else if (global.importType == global.importType_IGT) {
		fileExtension = "Interlinear glossed text (.txt)|*.txt";
	}
	else if (global.importType == global.importType_Transcription) {
		fileExtension = "Transcription (.txt, .csv)|*.txt;*.csv";
	}
	openedFile = get_open_filename_ext(fileExtension, "", discourseDirString, scr_get_translation("menu_import"));



	if (openedFile == "" or not file_exists(openedFile)) {
		exit;
	}
	else{
		global.previousImportDirectory = filename_path(openedFile);
	}

	var fileName = filename_name(openedFile);
	var fileExt = filename_ext(openedFile);
	var fileExtCharAt = string_pos(fileExt, fileName);

	if (fileExtCharAt > 0) {
		fileName = string_delete(fileName, fileExtCharAt, string_length(fileExt));
	}

	if (global.importType == global.importType_CSV) {
		scr_importCSV(openedFile);
		exit;
	}
	else {
		scr_importTXT(openedFile);
		exit;
	}
	*/
	
	scr_importTXT("");

}
