function scr_exportGrids() {
	
	// Get the default name for the CSV folder
	var filenameNoExt = filename_change_ext(global.fileSaveName, "");
	if(global.fileSaveName == "undefined" or is_undefined(global.fileSaveName)){
		filenameNoExt = filename_change_ext(global.importFilename, "");
	}
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
	
	var tempLinkGridHeaderList = ds_list_create();
	ds_list_add(tempLinkGridHeaderList, "linkID", "chainID", "source", "sourceClickTime", "goal", "goalClickTime");
	
	var tokenFieldSize = ds_list_size(obj_control.tokenFieldList);
	for (var i = 0; i < tokenFieldSize; i++) {
		ds_list_add(tempEntryGridHeaderList, obj_control.tokenFieldList[| i]);
		ds_list_add(tempTokenGridHeaderList, obj_control.tokenFieldList[| i]);
	}
	
	var unitFieldSize = ds_list_size(obj_control.unitFieldList);
	for (var i = 0; i < unitFieldSize; i++) {
		ds_list_add(tempUnitGridHeaderList, obj_control.unitFieldList[| i]);
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


	// make temporary export grids
	var tempRezChainGrid = scr_exportChainTempGrid(ds_map_find_value(global.nodeMap, "rezChainList"));
	var tempTrackChainGrid = scr_exportChainTempGrid(ds_map_find_value(global.nodeMap, "trackChainList"));
	var tempStackChainGrid = scr_exportChainTempGrid(ds_map_find_value(global.nodeMap, "stackChainList"));
	var tempChunkGrid = scr_exportChunkTempGrid();
	var tempSearchGrid = scr_exportSearchTempGrid();
	var tempLinkGrid = scr_exportLinkTempGrid();
	
	// header list for temp chaingrids
	var tempChainGridHeaderList = ds_list_create();
	ds_list_add(tempChainGridHeaderList, "chainID", "type", "name", "filter", "align");
	
	var tempChunkGridHeaderList = ds_list_create();
	ds_list_add(tempChunkGridHeaderList, "chunkID", "tokenList", "Display Text");
	var chunkFieldListSize = ds_list_size(obj_control.chunkFieldList);
	for (var i = 0; i < chunkFieldListSize; i++) {
		ds_list_add(tempChunkGridHeaderList, obj_control.chunkFieldList[| i]);
	}
	var tempSearchGridHeaderList = ds_list_create();
	ds_list_add(tempSearchGridHeaderList, "name", "searched words", "hit tokens");
	


	// Save the CSVs to the folder
	scr_gridToCSV(tempSearchGrid, exportDir + "\\search.csv", tempSearchGridHeaderList);
	scr_gridToCSV(tempTokenGrid, exportDir + "\\token.csv", tempTokenGridHeaderList);
	scr_gridToCSV(tempUnitGrid, exportDir + "\\unit.csv", tempUnitGridHeaderList);
	scr_gridToCSV(tempTrackGrid, exportDir + "\\track.csv", tempEntryGridHeaderList);
	scr_gridToCSV(tempRezGrid, exportDir + "\\rez.csv", tempEntryGridHeaderList);
	scr_gridToCSV(tempRezChainGrid, exportDir + "\\rezChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempTrackChainGrid, exportDir + "\\trackChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempStackChainGrid, exportDir + "\\stackChain.csv", tempChainGridHeaderList);
	scr_gridToCSV(tempChunkGrid, exportDir + "\\chunk.csv", tempChunkGridHeaderList);
	scr_gridToCSV(tempLinkGrid, exportDir + "\\link.csv", tempLinkGridHeaderList);

	// destroy temp grids
	ds_grid_destroy(tempSearchGrid);
	ds_grid_destroy(tempTokenGrid);
	ds_grid_destroy(tempUnitGrid);
	ds_grid_destroy(tempRezChainGrid);
	ds_grid_destroy(tempTrackChainGrid);
	ds_grid_destroy(tempStackChainGrid);
	ds_grid_destroy(tempChunkGrid);
	ds_grid_destroy(tempTrackGrid);
	ds_grid_destroy(tempRezGrid);
	ds_grid_destroy(tempLinkGrid);
	
	
	// destroy temp header lists
	ds_list_destroy(tempChainGridHeaderList);
	ds_list_destroy(tempSearchGridHeaderList);
}