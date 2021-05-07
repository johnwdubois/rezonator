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
	
	// create header list for entryGrid
	var tempEntryGridHeaderList = ds_list_create();
	ds_list_add(tempEntryGridHeaderList, "chainID", "chainName", "chainSeq", "trackSeq", "tokenID", "isChunk", "chunkID", "text", "transcript", "unitText");
	var tempTokenGridHeaderList = ds_list_create();
	ds_list_add(tempTokenGridHeaderList, "tokenID", "tokenOrder", "unitID", "unitSeq");
	
	var tempUnitGridHeaderList = ds_list_create();
	ds_list_add(tempUnitGridHeaderList, "unitID", "unitSeq", "speaker", "unitStart", "unitEnd");
	
	var tokenFieldSize = ds_list_size(obj_control.tokenFieldList);
	for (var i = 0; i < tokenFieldSize; i++) {
		ds_list_add(tempEntryGridHeaderList, obj_control.tokenFieldList[| i]);
		ds_list_add(tempTokenGridHeaderList, obj_control.tokenFieldList[| i]);
	}
	
	var unitImportColNameListSize = ds_list_size(global.unitImportColNameList);
	for (var i = 2; i < unitImportColNameListSize; i++) {
		ds_list_add(tempUnitGridHeaderList, global.unitImportColNameList[| i]);
	}
	
	var chainEntryFieldListSize = ds_list_size(global.chainEntryFieldList);
	for (var i = 0; i < chainEntryFieldListSize; i++) {
		ds_list_add(tempEntryGridHeaderList, global.chainEntryFieldList[| i]);
	}
	
	//make temp unit and token grid with all tag info
	var tempTokenGrid = scr_exportDiscourseTempGrid(tempTokenGridHeaderList, obj_control.tokenFieldList);
	var tempUnitGrid = scr_exportDiscourseTempGrid(tempUnitGridHeaderList, obj_control.unitFieldList);
	
	// make temp entry grids for track & rez
	var tempTrackGrid = scr_exportChainEntryGrid(global.nodeMap[? "trackChainList"], tempEntryGridHeaderList);
	var tempRezGrid = scr_exportChainEntryGrid(global.nodeMap[? "rezChainList"], tempEntryGridHeaderList);

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
	scr_gridToCSV(tempTokenGrid, exportDir + "\\token.csv", tempTokenGridHeaderList);
	scr_gridToCSV(tempUnitGrid, exportDir + "\\unit.csv", tempUnitGridHeaderList);
	scr_gridToCSV(tempTrackGrid, exportDir + "\\track.csv", tempEntryGridHeaderList);
	scr_gridToCSV(tempRezGrid, exportDir + "\\rez.csv", tempEntryGridHeaderList);
	scr_gridToCSV(tempRezChainGrid, exportDir + "\\rezChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempTrackChainGrid, exportDir + "\\trackChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempStackChainGrid, exportDir + "\\stackChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempPickGrid, exportDir + "\\pick.csv", tempLineGridHeaderList);
	scr_gridToCSV(tempQuickPickGrid, exportDir + "\\quickPick.csv", tempLineGridHeaderList);
	scr_gridToCSV(tempChunkGrid, exportDir + "\\chunk.csv", tempChunkGridHeaderList);

	// destroy temp grids
	ds_grid_destroy(tempTokenGrid);
	ds_grid_destroy(tempUnitGrid);
	ds_grid_destroy(tempRezChainGrid);
	ds_grid_destroy(tempTrackChainGrid);
	ds_grid_destroy(tempStackChainGrid);
	ds_grid_destroy(tempPickGrid);
	ds_grid_destroy(tempQuickPickGrid);
	ds_grid_destroy(tempChunkGrid);
	ds_grid_destroy(tempTrackGrid);
	ds_grid_destroy(tempRezGrid);
	
	
	// destroy temp header lists
	ds_list_destroy(tempChainGridHeaderList);
	ds_list_destroy(tempLineGridHeaderList);
}
