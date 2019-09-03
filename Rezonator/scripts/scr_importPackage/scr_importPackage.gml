var driveStr = working_directory + "nsfs.dll";

if	(os_type == os_macosx)	{
	var userStr = environment_get_variable("USER");
	global.documentsDirString = "/Users/" + userStr + "/Documents";
	global.rezonatorDirString = global.documentsDirString + "/Rezonator";
	global.rezonatorTutorialDirString = global.documentsDirString + "/Tutorial";
	global.rezonatorElmoDirString = global.documentsDirString + "/Games/Where's Elmo";
	global.rezonatorRezzlesDirString = global.documentsDirString + "/Games/Rezzles";
}
else	{
	var userStr = environment_get_variable("USERNAME");
	global.documentsDirString = "C:\\Users\\" + userStr + "\\Documents";
	global.rezonatorDirString = global.documentsDirString + "\\Rezonator";
	global.rezonatorTutorialDirString = global.documentsDirString + "\\Tutorial";
	global.rezonatorElmoDirString = global.documentsDirString + "\\Games\\Where's Elmo";
	global.rezonatorRezzlesDirString = global.documentsDirString + "\\Games\\Rezzles";
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