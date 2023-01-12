function scr_openSpecifiedFile(optionSelected){
	
	if (room == rm_mainScreen) {
		global.skipToOpenFile = optionSelected;
		room_goto(rm_openingScreen);
		exit;
	}
	
	global.skipToOpenFile = "";
	global.html5filename = optionSelected;
	
	var filepath = working_directory + "IncludedFiles/Data/SBCorpus/REZ/" + optionSelected;
	var fileExists = file_exists(filepath);
		
	if (fileExists) {
		var str = "";
		var file = file_text_open_read(filepath);
		while (!file_text_eof(file)) {
			var line = file_text_readln(file);
			line = string_replace_all(line, "\n", "");
			line = string_replace_all(line, "\r", "");
			line = string_replace_all(line, "	", "");
			str += line;
		}
		
		global.rezString = str;
	}

	
	global.newProject = false;
	global.openProject = true;
}