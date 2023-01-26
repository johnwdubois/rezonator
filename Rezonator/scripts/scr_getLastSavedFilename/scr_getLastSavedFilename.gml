function scr_getLastSavedFilename(){
	
	// check if the file already has a saved name
	var lastSavedFilepath = "";
	if (is_string(global.fileSaveName) && global.fileSaveName != "") {
		if (file_exists(global.fileSaveName)) {
			lastSavedFilepath = global.fileSaveName;
		}
	}
	
	// if not, we can check the imported filename
	if (lastSavedFilepath == "") {
		if (is_string(global.importFilename) && global.importFilename != "") {
			if (file_exists(global.importFilename)) {
				lastSavedFilepath = global.importFilename;
			}
		}
	}
	
	// if we got a valid filepath, we will strip the filename
	var lastSavedFilename = "";
	if (is_string(lastSavedFilepath) && lastSavedFilepath != "") {
		if (file_exists(lastSavedFilepath)) {
			lastSavedFilename = filename_name(lastSavedFilepath);
		}
	}
	show_debug_message("scr_getLastSavedFilename, lastSavedFilepath: " + string(lastSavedFilepath) + ", lastSavedFilename: " + string(lastSavedFilename));
	return lastSavedFilename;

}