// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_directoryCopy(sourceDir, destDir){

	show_debug_message("scr_directoryCopy() ... sourceDir: " + string(sourceDir) + ", destDir: " + string(destDir));

	// make sure the source dir exists
	if (!directory_exists(sourceDir)) {
		show_debug_message("sourceDir " + string(sourceDir) + " does not exist");
		exit;
	}

	// find the dir delimiter for this computer's OS
	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	show_debug_message("delimiter: " + string(delimiter));

	// create destination folder
	if (!directory_exists(destDir)) {
		directory_create(destDir);
	}

	// find first file in source dir
	var file = file_find_first(sourceDir + delimiter + "*", fa_directory);
	show_debug_message("FIRST FILE: " + string(file));

	var dirList = ds_list_create();

	// loop over & copy ever file from source dir
	while (file != "") {

		var filePathFull = sourceDir + delimiter + file;
		show_debug_message("filePathFull: " + string(filePathFull));

		// check if this file is a directory or not
		var isDirectory = directory_exists(filePathFull);
		show_debug_message("isDirectory: " + string(isDirectory));
		if (isDirectory) {
			// if it is a directory, we will save it to a list and copy it later
			ds_list_add(dirList, filePathFull);
		}
		else {
			// copy the file to its new destination
			var copySource = filePathFull;
			var copyDest = destDir + delimiter + file;
			file_copy(copySource, copyDest);
		}

		// find the next file in source dir
		file = file_find_next();
		show_debug_message("next file: " + string(file));
	}

	// copy all the sub-directories
	var dirListSize = ds_list_size(dirList);
	for (var i = 0; i < dirListSize; i++) {
		var currentDir = dirList[| i];
		var file = filename_name(currentDir);
		scr_directoryCopy(currentDir, destDir + delimiter + file);
	}

	ds_list_destroy(dirList);

}