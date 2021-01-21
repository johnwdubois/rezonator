function scr_exportGrids() {
	
	// Get the default name for the CSV folder
	var filenameNoExt = filename_change_ext(global.fileSaveName, "");
	var exportDirDefault = filenameNoExt + " CSV Export";
	show_debug_message("scr_exportGrids() ... exportDirDefault: " + string(exportDirDefault));
	
	// User will specify a name and a location for the CSV folder
	var exportDir = get_save_filename_ext("CSV Folder", exportDirDefault, program_directory, scr_get_translation("msg_save_csv"));
	show_debug_message("scr_exportGrids() ... exportDir: " + string(exportDir));
	
	// Check if exportDir is valid, or if the user exited the window
	if (exportDir == "" or exportDir == "undefined") {
		exportDir = "undefined";
		show_message(scr_get_translation("save_error"));
		exit;
	}

	// Create the folder with the user created name
	if (not directory_exists(exportDir)) {
		directory_create(exportDir);
	}
	
	// refresh trackSeqGrid
	// CHAIN OVER-HAUL Revist
	//scr_trackSeqGrid();

	// Save the CSVs to the folder
	scr_gridToCSV(obj_control.wordGrid, exportDir + "\\word.csv");
	scr_gridToCSV(obj_control.unitGrid, exportDir + "\\unit.csv");
	scr_gridToCSV(obj_chain.linkGrid, exportDir + "\\link.csv");
	scr_gridToCSV(obj_chain.cliqueGrid, exportDir + "\\clique.csv");
	//scr_gridToCSV(obj_chain.rezChainGrid, exportDir + "\\rez.csv");
	//scr_gridToCSV(obj_chain.trackSeqGrid, exportDir + "\\track.csv");
	//scr_gridToCSV(obj_chain.trackChainGrid, exportDir + "\\trackChain.csv");
	//scr_gridToCSV(obj_chain.stackChainGrid, exportDir + "\\stack.csv");


}
