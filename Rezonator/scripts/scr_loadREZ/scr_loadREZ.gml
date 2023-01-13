function scr_loadREZ() {
	
	if (global.html5) {
		
		
		var filename = working_directory + "IncludedFiles/sbc002.rez";
		var fileExists = file_exists(filename);
		show_message("filename: " + string(filename) + ", fileExists: " + string(fileExists));
		
		global.html5FileRipStr = "";
		var file = file_text_open_read(filename);
		while (!file_text_eof(file)) {
			var line = file_text_readln(file);
			line = string_replace_all(line, "\n", "");
			line = string_replace_all(line, "\r", "");
			line = string_replace_all(line, "	", "");
			global.html5FileRipStr += line;
		}
		file_text_close(file);
		
		var decode = json_decode(global.html5FileRipStr);
		
		scr_loadREZHandleWrapper(decode);		
		exit;
	}
	
	
	
	

	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	var RezDirString = global.rezonatorDirString + delimiter + "Data" + delimiter + "SBCorpus" + delimiter + "REZ";

	show_debug_message("global.previousRezDirectory:  "+string(global.previousRezDirectory));
	if (global.previousRezDirectory != "") {
		RezDirString = global.previousRezDirectory;
	
		// trimming the spaces off of RezDirString
		var charAt = string_length(RezDirString);
		while (string_char_at(RezDirString, charAt) == " " and charAt > 0) {
			charAt--;
		}
		RezDirString = string_delete(RezDirString, charAt, string_length(RezDirString) - charAt);
	}




	var filename = "";

	if(global.selectedFile != ""){
		var fileName = global.selectedFile;
		
	}
	else{
		if (directory_exists(global.rezonatorDirString)) {
			var fileName = get_open_filename_ext("REZ file|*.rez", "", RezDirString, "Open REZ");
		}
		else {
			var fileName = get_open_filename_ext("REZ file|*.rez", "", program_directory, "Open REZ");
		}
	}

	if (fileName == "" or not file_exists(fileName)) {
		show_debug_message("Going to openingScreen, scr_loadREZ");
		room_goto(rm_openingScreen);
		exit;
	}
	else{
		global.previousRezDirectory = filename_path(fileName);
	}
	


	var rezFileVersion = 0;

	global.fileSaveName = fileName;
	if (filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "\\") {
		global.fileSaveName = "";
	}

	var newInstList = ds_list_create();

	if (file_exists(fileName)) {
		scr_addToRecentFiles(string(fileName));
		var wrapper = scr_loadJSONBuffer(fileName);
		
		scr_loadREZHandleWrapper(wrapper);

	}
	
	scr_openFileRefreshCliques();

	ds_list_destroy(newInstList);
	
	var exitToOpeningScreen = scr_verifyRez(rezFileVersion);
	if (exitToOpeningScreen) {
		show_debug_message("scr_loadREZ ... verifyREZ has failed, exiting to opening screen");
		room_goto(rm_openingScreen);
		exit;
	}
	else {
		scr_refreshPrevToken();
	}
	

	var x1 = irandom(1);
	var y1 = irandom(1);
	if (x1 == y1) show_debug_message("hello terry :)");
	else show_debug_message("oh my god");
	
	// when opening a rez file, use full unit list (do not open)
	var docNodeSubMap = global.nodeMap[? global.discourseNode];
	if (scr_isNumericAndExists(docNodeSubMap, ds_type_map)) {
		var fullUnitList = docNodeSubMap[? "unitList"];
		var displayUnitList = docNodeSubMap[? "displayUnitList"];
		show_debug_message("fullUnitList: " + scr_getStringOfList(fullUnitList));
		show_debug_message("displayUnitList: " + scr_getStringOfList(displayUnitList));
		if (scr_isNumericAndExists(fullUnitList, ds_type_list) && scr_isNumericAndExists(displayUnitList, ds_type_list)) {
			ds_list_clear(displayUnitList);
			ds_list_copy(displayUnitList, fullUnitList);
			obj_control.currentView = obj_control.mainView;
		}
	}

}
