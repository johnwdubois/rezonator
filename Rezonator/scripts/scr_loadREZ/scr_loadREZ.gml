function scr_loadREZ() {
	
	if (global.html5) {
		
		var html5filename = working_directory + "IncludedFiles/Data/SBCorpus/REZ_beautify/" + global.html5RezFile + ".rez";
		if (file_exists(html5filename)) {
			global.html5FileRipStr = "";
			show_debug_message("scr_loadREZ, html5, before reading file");
			var file = file_text_open_read(html5filename);
			while (!file_text_eof(file)) {
				var line = file_text_readln(file);
				line = string_replace_all(line, "\n", "");
				line = string_replace_all(line, "\r", "");
				line = string_replace_all(line, "	", "");
				global.html5FileRipStr += line;
			}
			file_text_close(file);
			show_debug_message("scr_loadREZ, html5, after reading file");
		
			var decode = json_decode(global.html5FileRipStr);
			scr_loadREZHandleWrapper(decode);
		}
		else {
			show_message("ERROR. " + string(global.html5RezFile) + " does not exist");
			if (global.html5) global.html5RezFile = "";
			room_goto(rm_openingScreen);
		}
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
	if (global.selectedFile != "") {
		filename = global.selectedFile;
	}
	else {
		if (directory_exists(global.rezonatorDirString)) {
			filename = get_open_filename_ext("REZ file|*.rez", "", RezDirString, "Open REZ");
		}
		else {
			filename = get_open_filename_ext("REZ file|*.rez", "", program_directory, "Open REZ");
		}
	}

	if (filename == "" or not file_exists(filename)) {
		show_debug_message("Going to openingScreen, scr_loadREZ");
		room_goto(rm_openingScreen);
		exit;
	}
	else {
		global.previousRezDirectory = filename_path(filename);
	}
	


	var rezFileVersion = 0;

	global.fileSaveName = filename;
	if (filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "\\") {
		global.fileSaveName = "";
	}

	var newInstList = ds_list_create();

	if (file_exists(filename)) {
		scr_addToRecentFiles(string(filename));
		var wrapper = scr_loadJSONBuffer(filename);
		
		scr_loadREZHandleWrapper(wrapper);

	}

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
	
	scr_openFileRefreshCliques();
	scr_lockChunks(true);

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
	
	// change to the stackType from when the rez file was saved
	scr_changeActiveStacking(obj_control.activeStacking);
	
	if (global.restoreAutosave) {
		
		var lastSavedFilename = "";
		if (is_string(global.autosaveLastSavedFilename) && global.autosaveLastSavedFilename != "") {
			lastSavedFilename = global.autosaveLastSavedFilename;
		}
		if (!directory_exists(global.rezonatorMyREZFileDir)) directory_create(global.rezonatorMyREZFileDir);
		if (!is_string(lastSavedFilename)) lastSavedFilename = "";
		lastSavedFilename = string_replace_all(lastSavedFilename, ".csv", "");
		lastSavedFilename = string_replace_all(lastSavedFilename, ".txt", "");
		lastSavedFilename = string_replace_all(lastSavedFilename, ".rez", "");
		var backupFilename = get_save_filename_ext("REZ file|*.rez", lastSavedFilename + "_Backup", global.rezonatorMyREZFileDir, "Restore autosave");
		if (is_string(backupFilename) && backupFilename != "") {
			file_copy(global.selectedFile, backupFilename);
			global.selectedFile = backupFilename;
			global.restoreAutosave = false;
			scr_loadREZ();
		}
	}
	

}
