function scr_createRezDirectory() {
	// Create the colelction of folders and files the user will receive on downloading Rezonator


	if	(os_type == os_macosx)	{
		var userStr = environment_get_variable("USER");
	
	
		global.documentsDirString = "/Users/" + string(userStr) + "/Documents";
		global.rezonatorDirString = global.documentsDirString + "/Rezonator/" + global.versionString;
		global.rezonatorTutorialDirString = global.rezonatorDirString + "/Tutorial";
		global.rezonatorElmoDirString = global.rezonatorDirString + "/Play_&_Learn/Where's_Elmo";
		global.rezonatorElmoSaveDirString = global.rezonatorElmoDirString + "/Saved_Games";
		global.rezonatorRezzlesDirString = global.rezonatorElmoDirString; //global.rezonatorRezzlesDirString = global.rezonatorDirString + "/Play_&_Learn/Where's_Elmo";
		global.rezonatorRezzlesSaveDirString = global.rezonatorRezzlesDirString + "/Saved_Games";
		global.rezonatorDefaultDiscourseDirString = global.rezonatorDirString + "/Data";
		global.rezonatorSchemaDirString = global.rezonatorDirString + "/Schemas";
		global.rezonatorFontDirString = global.rezonatorDirString + "/Fonts";

	}
	else	{
		var userStr = environment_get_variable("USERNAME");
		global.documentsDirString = "C:\\Users\\" + userStr + "\\Documents";
		global.rezonatorDirString = global.documentsDirString + "\\Rezonator\\" + global.versionString;
		global.rezonatorTutorialDirString = global.rezonatorDirString + "\\Tutorial";
		global.rezonatorElmoDirString = global.rezonatorDirString + "\\Play & Learn\\Where's Elmo";
		global.rezonatorElmoSaveDirString = global.rezonatorElmoDirString + "\\Saved Games";
		global.rezonatorRezzlesDirString = global.rezonatorElmoDirString; //global.rezonatorRezzlesDirString = global.rezonatorDirString + "\\Games\\Rezzles";
		global.rezonatorRezzlesSaveDirString = global.rezonatorRezzlesDirString + "\\Saved Games";
		global.rezonatorDefaultDiscourseDirString = global.rezonatorDirString + "\\Data";
		global.rezonatorSchemaDirString = global.rezonatorDirString + "\\Schemas";
		global.rezonatorFontDirString = global.rezonatorDirString + "\\Fonts";
	}


	if (directory_exists(global.documentsDirString)) {
		if	(os_type == os_macosx)	{
			var userStr = environment_get_variable("USER");
			var testDir = "/Users/" + string(userStr) + "/Documents";
			
			if(directory_exists(testDir)){
				if(!directory_exists(testDir + "/Rezonator")){
					directory_create(testDir + "/Rezonator");
				}
			}

			directory_create(global.rezonatorDirString);
			scr_directoryCopy(working_directory, global.rezonatorDirString);
			//directory_copy(working_directory + "Resources", global.rezonatorDirString);
		}
		else {
			
			
			if (directory_exists(working_directory)) {
		
				if (!directory_exists(global.rezonatorDirString)) {
					scr_directoryCopy(working_directory, global.rezonatorDirString);
					//directory_copy(working_directory, global.rezonatorDirString);
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
		else {
			if (!directory_exists(global.rezonatorDirString + "\\Autosave")) {
				directory_create(global.rezonatorDirString + "\\Autosave");
			}
		}
	
		if (!directory_exists(global.rezonatorSchemaDirString)) {
			directory_create(global.rezonatorSchemaDirString);
		}
	}


}
