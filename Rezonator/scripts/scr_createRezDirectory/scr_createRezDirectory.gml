function scr_createRezDirectory() {
	
	if (BUILDTYPE == "Web") {
		global.rezonatorDirString = "";
		global.documentsDirString = "";
		global.rezonatorDefaultDiscourseDirString = "";
		global.rezonatorSchemaDirString = "";
		global.rezonatorREZFileDir = "";
		global.rezonatorMyREZFileDir = "";
		exit;
	}
	
	// Create the colelction of folders and files the user will receive on downloading Rezonator
	var userName = (os_type == os_windows) ? "USERNAME" : "USER";
	var userStr = environment_get_variable(userName);
	var delimiter = (os_type == os_windows) ? "\\" : "/";
	show_debug_message("scr_createRezDirectory, userStr: " + string(environment_get_variable("USERNAME")) + ", " + string(environment_get_variable("USER")));

	// create core rezonator directories
	if (os_type == os_macosx) {
		global.documentsDirString = "/Users/" + string(userStr) + "/Documents";
	}
	else if (os_type == os_windows) {
		global.documentsDirString = "C:\\Users\\" + userStr + "\\Documents";
	}
	else if (os_type == os_linux) {
		global.documentsDirString = "/Users/" + string(userStr) + "/Documents";
	}
	global.rezonatorDirString = global.documentsDirString + delimiter + "Rezonator" + delimiter + global.versionString;
	global.rezonatorDefaultDiscourseDirString = global.rezonatorDirString + delimiter + "Data";
	global.rezonatorSchemaDirString = global.rezonatorDirString + delimiter + "Schemas";
	global.rezonatorREZFileDir = global.rezonatorDirString + delimiter + "Data" + delimiter + "SBCorpus" + delimiter + "REZ";
	global.rezonatorMyREZFileDir = global.rezonatorDirString + delimiter + "Data" + delimiter + "MyData";
	
	// copy directory to user's Documents folder
	ds_list_clear(global.dirCopyDebugList);
	if (directory_exists(global.documentsDirString)) {
		var includedFilesDir = working_directory + delimiter + "IncludedFiles";
		if (directory_exists(includedFilesDir)) {
			if (!directory_exists(global.rezonatorDirString)) {
				scr_directoryCopy(includedFilesDir, global.rezonatorDirString, "");
			}
		}
	}
	
	// save dirCopy debug file
	var dirCopyFilePath = working_directory + "~dir.txt";
	var dirCopyDebugFile = file_text_open_write(dirCopyFilePath);
	var dirCopyDebugListSize = ds_list_size(global.dirCopyDebugList);
	for (var i = 0; i < dirCopyDebugListSize; i++) {
		var currentDebugStr = string(global.dirCopyDebugList[| i]);
		file_text_write_string(dirCopyDebugFile, currentDebugStr);
		file_text_writeln(dirCopyDebugFile);
	}
	file_text_close(dirCopyDebugFile);
	show_debug_message("dirCopyFilePath: " + string(dirCopyFilePath));
	show_debug_message("dirCopyDebugFile exists: " + string(file_exists(dirCopyFilePath)));
	if (file_exists(dirCopyFilePath)) file_copy(dirCopyFilePath, global.rezonatorDirString + delimiter + "~dir.txt");
	
	
	
	
	
	// create autosave & schema directory
	if (directory_exists(global.rezonatorDirString)) {
		var autosaveDir = global.rezonatorDirString + delimiter + "Autosave";		
		if (!directory_exists(autosaveDir)) {
			directory_create(autosaveDir);
		}
	
		if (!directory_exists(global.rezonatorSchemaDirString)) {
			directory_create(global.rezonatorSchemaDirString);
		}
		
		if (!directory_exists(global.rezonatorMyREZFileDir)) {
			directory_create(global.rezonatorMyREZFileDir);
		}
	}
}
