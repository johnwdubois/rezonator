function scr_createRezDirectory() {
	
	// Create the colelction of folders and files the user will receive on downloading Rezonator
	var userName = (os_type == os_macosx) ? "USER" : "USERNAME";
	var userStr = environment_get_variable(userName);
	var delimiter = (os_type == os_macosx) ? "/" : "\\";

	// create core rezonator directories
	if (os_type == os_macosx) {
		global.documentsDirString = "/Users/" + string(userStr) + "/Documents";
	}
	else {
		global.documentsDirString = "C:\\Users\\" + userStr + "\\Documents";
	}
	global.rezonatorDirString = global.documentsDirString + delimiter + "Rezonator" + delimiter + global.versionString;
	global.rezonatorDefaultDiscourseDirString = global.rezonatorDirString + delimiter + "Data";
	global.rezonatorSchemaDirString = global.rezonatorDirString + delimiter + "Schemas";
	
	// copy directory to user's Documents folder
	if (directory_exists(global.documentsDirString)) {
		var includedFilesDir = working_directory + delimiter + "IncludedFiles";
		if (os_type == os_macosx) {
			if (directory_exists(global.documentsDirString)) {
				if (!directory_exists(global.documentsDirString + "/Rezonator")) {
					directory_create(global.documentsDirString + "/Rezonator");
				}
			}
			directory_create(global.rezonatorDirString);
			scr_directoryCopy(includedFilesDir, global.rezonatorDirString);
		}
		else {
			if (directory_exists(includedFilesDir)) {
				if (!directory_exists(global.rezonatorDirString)) {
					scr_directoryCopy(includedFilesDir, global.rezonatorDirString);
				}
			}
		}
	}
	
	
	// create autosave & schema directory
	if (directory_exists(global.rezonatorDirString)) {
		var autosaveDir = global.rezonatorDirString + delimiter + "Autosave";		
		if (!directory_exists(autosaveDir)) {
			directory_create(autosaveDir);
		}
	
		if (!directory_exists(global.rezonatorSchemaDirString)) {
			directory_create(global.rezonatorSchemaDirString);
		}
	}
}
