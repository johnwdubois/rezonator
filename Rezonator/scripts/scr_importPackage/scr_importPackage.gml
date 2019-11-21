/*
if (directory_exists(program_directory)) {
	show_message("BUH" + program_directory)
}
else {
	show_message("GUH" + program_directory)
}
*/

if	(os_type == os_macosx)	{	
	var userStr = environment_get_variable("HOME");
	//show_message(string(userStr));
	
	
	global.documentsDirString = string(userStr) + "/Documents";
	global.rezonatorDirString = global.documentsDirString + "/Rezonator/" + global.versionString;
	global.rezonatorTutorialDirString = global.rezonatorDirString + "/Tutorial";
	global.rezonatorElmoDirString = global.rezonatorDirString + "/Games/Where's_Elmo";
	global.rezonatorElmoSaveDirString = global.rezonatorElmoDirString + "/Saved_Games";
	global.rezonatorRezzlesDirString = global.rezonatorDirString + "/Games/Rezzles";
	global.rezonatorRezzlesSaveDirString = global.rezonatorRezzlesDirString + "/Saved_Games";
}
else	{
	var userStr = environment_get_variable("USERNAME");
	global.documentsDirString = "C:\\Users\\" + userStr + "\\Documents";
	global.rezonatorDirString = global.documentsDirString + "\\Rezonator\\" + global.versionString;
	global.rezonatorTutorialDirString = global.rezonatorDirString + "\\Tutorial";
	global.rezonatorElmoDirString = global.rezonatorDirString + "\\Games\\Where's Elmo";
	global.rezonatorElmoSaveDirString = global.rezonatorElmoDirString + "\\Saved Games";
	global.rezonatorRezzlesDirString = global.rezonatorDirString + "\\Games\\Rezzles";
	global.rezonatorRezzlesSaveDirString = global.rezonatorRezzlesDirString + "\\Saved Games";
}


if (directory_exists(global.documentsDirString)) {
	if	(os_type == os_macosx)	{
		//show_message("in here!!")
		directory_create(global.rezonatorDirString);
		directory_copy(working_directory, global.documentsDirString);
		//show_message(global.documentsDirString);
	}
	else {
		if (directory_exists(working_directory)) {
		
			if (!directory_exists(global.rezonatorDirString)) {
				directory_copy(working_directory, global.rezonatorDirString);
			}
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