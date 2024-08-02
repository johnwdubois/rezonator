scr_windowExit();
scr_multiDropDownMouseover();

scr_ctrlHold();

// CSV group import
if (keyboard_check(vk_shift) && global.ctrlHold && keyboard_check_released(ord("I"))) {
	
	if (os_type == os_macosx) {
		global.importGroupOutputDir = "/Users/terry/Desktop/newrez";
	}
	else {
		global.importGroupOutputDir = get_string("Type in output directory for REZ files", "");
	}
	
	show_message(scr_get_translation("msg_directory-exists") + " " + string(directory_exists(global.importGroupOutputDir)));
	
	var filename = "";
	filename = get_open_filename("CSV file|*.csv", "");
	global.importGroupDir = filename_dir(filename);
	
	if (directory_exists(global.importGroupDir)) {
		var currentFile = file_find_first(global.importGroupDir + "\\*.csv", 0);
		while (currentFile != "") {
			var currentFilePath = global.importGroupDir + "\\" + currentFile;
			ds_list_add(global.importGroupFileList, currentFilePath);
			currentFile = file_find_next();
		}
		file_find_close();
		show_message("global.importGroupFileList: " + scr_getStringOfList(global.importGroupFileList));
	}
	
	global.importGroupSchemaFile = get_open_filename_ext("SCHEMA file|*.json", "", global.rezonatorSchemaDirString, "Open Schema");
	show_debug_message("global.importGroupSchemaFile: " + string(global.importGroupSchemaFile) + ", file exists: " + string(file_exists(global.importGroupSchemaFile)));
}

if (ds_list_size(global.importGroupFileList) > 0 && global.importGroupFileIndex >= 0 && global.importGroupFileIndex < ds_list_size(global.importGroupFileList)) {
	var importFileName = ds_list_find_value(global.importGroupFileList, global.importGroupFileIndex);
	show_debug_message("Going to import file: " + string(importFileName));
	show_debug_message(" ... file exists: " + string(file_exists(importFileName)));
	if (file_exists(importFileName)) {
		scr_importCSV(importFileName);
	}
}


// skipping to import screen by clicking "Import" in file menu
if (global.skipToImportScreen) {
	global.skipToImportScreen = false;
	global.project = "import";
	global.currentDirString = global.previousImportDirectory;
}
if (global.skipToOpen) {
	global.skipToOpen = false;
	alarm[8] = 1;
}
if (global.skipToAiChat) {
	global.skipToAiChat = false;
	global.project = "import";
	global.importType = IMPORTTYPE_AICHAT;
	room_goto(rm_aiChat);
}

window_set_caption(string(game_display_name));