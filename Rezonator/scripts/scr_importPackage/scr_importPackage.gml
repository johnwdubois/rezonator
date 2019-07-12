var driveStr = working_directory + "nsfs.dll";

if	(os_type == os_macosx)	{
	var userStr = environment_get_variable("USER");
	global.documentsDirString = "/Users/" + userStr + "/Documents";
	global.rezonatorDirString = global.documentsDirString + "/Rezonator";
}
else	{
	var userStr = environment_get_variable("USERNAME");
	global.documentsDirString = "C:\\Users\\" + userStr + "\\Documents";
	global.rezonatorDirString = global.documentsDirString + "\\Rezonator";
}

if (directory_exists(global.documentsDirString)) {
	if (directory_exists(working_directory)) {
		
		if (!directory_exists(global.rezonatorDirString)) {
			directory_copy(working_directory, global.rezonatorDirString);
		}
	}
}

if (directory_exists(global.rezonatorDirString)) {
	if	(os_type == os_macosx)	{
		if (!directory_exists(global.rezonatorDirString + "/Autosave")) {
			directory_create(global.rezonatorDirString + "/Autosave");
		}
	}
	else{
		if (!directory_exists(global.rezonatorDirString + "\\Autosave")) {
			directory_create(global.rezonatorDirString + "\\Autosave");
		}
	}
}