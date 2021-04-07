function scr_exportGrids() {
	
	// Get the default name for the CSV folder
	var filenameNoExt = filename_change_ext(global.fileSaveName, "");
	var exportDirDefault = filenameNoExt + " CSV Export";
	show_debug_message("scr_exportGrids() ... exportDirDefault: " + string(exportDirDefault));
	
	// User will specify a name and a location for the CSV folder
	var exportDir = get_save_filename_ext("CSV Folder|", exportDirDefault, program_directory, scr_get_translation("msg_save_csv"));
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
	
	// refresh trackGrid and rezGrid
	scr_exportChainEntryGrid(obj_chain.trackGrid);
	scr_exportChainEntryGrid(obj_chain.rezGrid);

	// make temporary pick/quickpick grid (so we can add an extra col)
	var tempPickGrid = scr_exportLineTempGrid(obj_control.filterGrid);
	var tempQuickPickGrid = scr_exportLineTempGrid(obj_control.quickFilterGrid);
	
	// make temporary chain grids
	var tempRezChainGrid = scr_exportChainTempGrid(ds_map_find_value(global.nodeMap, "rezChainList"));
	var tempTrackChainGrid = scr_exportChainTempGrid(ds_map_find_value(global.nodeMap, "trackChainList"));
	var tempStackChainGrid = scr_exportChainTempGrid(ds_map_find_value(global.nodeMap, "stackChainList"));
	var tempChunkGrid = scr_exportChunkTempGrid();
	
	// header list for temp chaingrids
	var tempChainGridHeaderList = ds_list_create();
	ds_list_add(tempChainGridHeaderList, "chainID", "type", "name", "filter", "align");
	
	var tempChunkGridHeaderList = ds_list_create();
	ds_list_add(tempChunkGridHeaderList, "chunkID", "tokenList", "Display Text");
	
	var tempLineGridHeaderList = ds_list_create();
	for (var i = 0; i < ds_grid_width(obj_control.filterGrid); i++) {
		ds_list_add(tempLineGridHeaderList, scr_getColNameString(obj_control.filterGrid, i));
	}
	ds_list_add(tempLineGridHeaderList, "lineText");

	// Save the CSVs to the folder
	scr_gridToCSV(obj_control.searchGrid, exportDir + "\\search.csv", tempLineGridHeaderList);
	scr_gridToCSV(obj_control.wordGrid, exportDir + "\\word.csv");
	scr_gridToCSV(obj_control.unitGrid, exportDir + "\\unit.csv");
	scr_gridToCSV(obj_chain.trackGrid, exportDir + "\\track.csv");
	scr_gridToCSV(obj_chain.rezGrid, exportDir + "\\rez.csv");
	scr_gridToCSV(tempRezChainGrid, exportDir + "\\rezChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempTrackChainGrid, exportDir + "\\trackChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempStackChainGrid, exportDir + "\\stackChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempPickGrid, exportDir + "\\pick.csv", tempLineGridHeaderList);
	scr_gridToCSV(tempQuickPickGrid, exportDir + "\\quickPick.csv", tempLineGridHeaderList);
	scr_gridToCSV(tempChunkGrid, exportDir + "\\Chunks.csv", tempChunkGridHeaderList);

	// destroy temp grids
	ds_grid_destroy(tempRezChainGrid);
	ds_grid_destroy(tempTrackChainGrid);
	ds_grid_destroy(tempStackChainGrid);
	ds_grid_destroy(tempPickGrid);
	ds_grid_destroy(tempQuickPickGrid);
	ds_grid_destroy(tempChunkGrid);
	
	// destroy temp header lists
	ds_list_destroy(tempChainGridHeaderList);
	ds_list_destroy(tempLineGridHeaderList);
}
