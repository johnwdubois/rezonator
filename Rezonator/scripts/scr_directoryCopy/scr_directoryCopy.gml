

function scr_directoryCopy(sourceDir, destDir, debugTab) {
	
	var dbMessage = debugTab + "scr_directoryCopy START ... sourceDir: " + string(sourceDir) + ", destDir: " + string(destDir);
	ds_list_add(global.dirCopyDebugList, dbMessage);
	show_debug_message(dbMessage);

	// make sure the source dir exists
	if (!directory_exists(sourceDir)) {
		dbMessage = debugTab + "sourceDir " + string(sourceDir) + " does not exist";
		ds_list_add(global.dirCopyDebugList, dbMessage);
		show_debug_message(dbMessage);
		exit;
	}

	// find the dir delimiter for this computer's OS
	var delimiter = (os_type == os_macosx) ? "/" : "\\";

	// create destination folder
	if (!directory_exists(destDir)) {
		directory_create(destDir);
	}
	
	var sourceFileCount = 0;
	var destFileCount = 0;

	// find first sourceFile in source dir
	var sourceFile = file_find_first(sourceDir + delimiter + "*", fa_directory);
	if (sourceFile == ".DS_Store") sourceFile = file_find_next();
	dbMessage = debugTab + "FIRST sourceFile: " + string(sourceFile);
	ds_list_add(global.dirCopyDebugList, dbMessage);
	show_debug_message(dbMessage);


	var dirList = ds_list_create();

	// loop over & copy ever sourceFile from source dir
	while (sourceFile != "") {
		
		if (sourceFile == ".DS_Store") sourceFile = file_find_next();
		sourceFileCount++;
		
		// get file path, check if it's a directory
		var filePathFull = sourceDir + delimiter + sourceFile;
		var isDirectory = directory_exists(filePathFull);
		dbMessage = debugTab + "filePathFull: " + string(filePathFull) + ", isDir: " + string(isDirectory);
		ds_list_add(global.dirCopyDebugList, dbMessage);
		show_debug_message(dbMessage);
		
		
		if (isDirectory) {
			// if it is a directory, we will save it to a list and copy it later
			ds_list_add(dirList, filePathFull);
		}
		else {
			// copy the sourceFile to its new destination
			var copySource = filePathFull;
			var copyDest = destDir + delimiter + sourceFile;
			file_copy(copySource, copyDest);
		}

		// find the next sourceFile in source dir
		sourceFile = file_find_next();
		dbMessage = debugTab + "next sourceFile: " + string(sourceFile);
		ds_list_add(global.dirCopyDebugList, dbMessage);
		show_debug_message(dbMessage);
	}
	
	// close the sourceDir
	file_find_close();

	// copy all the sub-directories
	dbMessage = debugTab + "dirList: " + scr_getStringOfList(dirList);
	ds_list_add(global.dirCopyDebugList, dbMessage);
	show_debug_message(dbMessage);
	var dirListSize = ds_list_size(dirList);
	for (var i = 0; i < dirListSize; i++) {
		var currentDir = dirList[| i];
		var sourceFile = filename_name(currentDir);
		scr_directoryCopy(currentDir, destDir + delimiter + sourceFile, debugTab + "    ");
	}
	ds_list_destroy(dirList);
	
	
	
	// count up files in destDir
	var destFile = file_find_first(destDir + delimiter + "*", fa_directory);
	while (destFile != "") {
		destFileCount++;
		destFile = file_find_next();
	}
	
	// close the destDir
	file_find_close();
	
	dbMessage = debugTab + "scr_directoryCopy END ... sourceDir: " + string(sourceDir) + ", sourceFileCount: " + string(sourceFileCount) + ", destFileCount:" + string(destFileCount);
	ds_list_add(global.dirCopyDebugList, dbMessage);
	show_debug_message(dbMessage);

	

}