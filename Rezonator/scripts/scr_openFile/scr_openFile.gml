function scr_openFile() {
	
	show_debug_message("scr_openFile, global.importType: " + string(global.importType));

	if (global.importFrom == "clipboard") {
		openedFile = "";
	}
	else if (global.importFrom == "file") {
		if (global.previousImportDirectory == "") {
	
			var discourseDirString = global.rezonatorDirString + "\\Data\\SBCorpus\\Transcript";
			if (os_type == os_macosx) {
				discourseDirString = global.currentDirString + "/Data/SBCorpus/Transcript";
			}

		}
		else {
			var discourseDirString = global.previousImportDirectory;
	
			var charAt = string_length(discourseDirString);
			while (string_char_at(discourseDirString, charAt) == " " and charAt > 0) {
				charAt--;
			}
			discourseDirString = string_delete(discourseDirString, charAt, string_length(discourseDirString) - charAt);

		}

	
		var fileExtension = "";
		if (global.importType == IMPORTTYPE_WORD) {
			fileExtension = "CSV (.csv)|*.csv";
		}
		else if (global.importType == IMPORTTYPE_CONLLU) {
			fileExtension = "CoNLL-U (.txt)|*.txt";
		}
		else if (global.importType == IMPORTTYPE_SONG) {
			fileExtension = scr_get_translation(IMPORTTYPE_SONG) +" (.txt)|*.txt";
		}
		else if (global.importType == IMPORTTYPE_PROSE) {
			fileExtension = "Paragraph (.txt)|*.txt";
		}
		else if (global.importType == IMPORTTYPE_ELAN) {
			fileExtension = "Tab delimited (.txt)|*.txt";
		}
		else if (global.importType == IMPORTTYPE_IGT) {
			fileExtension = "Interlinear glossed text (.txt)|*.txt";
		}
		else if (global.importType == IMPORTTYPE_TRANSCRIPTION) {
			fileExtension = "Transcription (.txt, .csv)|*.txt;*.csv";
		}
		openedFile = get_open_filename_ext(fileExtension, "", discourseDirString, scr_get_translation("menu_import"));



		if (openedFile == "" or not file_exists(openedFile)) {
			exit;
		}
		else {
			global.previousImportDirectory = filename_path(openedFile);
		}

		var fileName = filename_name(openedFile);
		var fileExt = filename_ext(openedFile);
		var fileExtCharAt = string_pos(fileExt, fileName);

		if (fileExtCharAt > 0) {
			fileName = string_delete(fileName, fileExtCharAt, string_length(fileExt));
		}
	}

	if (global.importType == IMPORTTYPE_WORD) {
		scr_importCSV(openedFile);
		exit;
	}
	else {
		scr_importTXT(openedFile);
		exit;
	}

}
