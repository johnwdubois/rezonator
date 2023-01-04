/// @description add default files to recent files window
if (ds_list_size(global.recentFilesList) < 1 && directory_exists(global.rezonatorDirString)) {
	
	// get rezfile directory
	var delimiter = os_type == os_macosx ? "/" : "\\"
	var rezFileDir = global.rezonatorDirString + delimiter + "Data" + delimiter + "SBCorpus" + delimiter + "REZ";
	if (directory_exists(rezFileDir)) {
		
		// check if we can find sbc001 and sbc002
		var defaultFilepath1 = rezFileDir + delimiter + "sbc002.rez";
		var defaultFilepath2 = rezFileDir + delimiter + "sbc001.rez";
		
		if (file_exists(defaultFilepath1)) scr_addToRecentFiles(defaultFilepath1);
		if (file_exists(defaultFilepath2)) scr_addToRecentFiles(defaultFilepath2);
	}
	
}