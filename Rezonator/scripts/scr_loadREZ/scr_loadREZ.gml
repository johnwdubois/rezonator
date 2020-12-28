function scr_loadREZ() {
	/*
		scr_loadRez();
	
		Last Updated: 2020-01-01
	
		Called from: obj_fileLoader
	
		Purpose: Load data from a Rez file into Rezonator
	
		Mechanism: Separate the JSON string into its different maps, then load the data from those maps into all the grids.
	
		Author: Terry DuBois
	*/
	var RezDirString = global.currentDirString;
	if(!global.wheresElmo){
		var delimiter = (os_type == os_macosx) ? "/" : "\\";
		RezDirString = global.rezonatorDirString + delimiter + "Data" + delimiter + "SBCorpus" + delimiter + "REZ";
	}

	if (!global.wheresElmo and global.previousRezDirectory != "") {
		RezDirString = global.previousRezDirectory;
	
		// trimming the spaces off of RezDirString
		var charAt = string_length(RezDirString);
		while (string_char_at(RezDirString, charAt) == " " and charAt > 0) {
			charAt--;
		}
		RezDirString = string_delete(RezDirString, charAt, string_length(RezDirString) - charAt);
	}







	if (directory_exists(global.rezonatorDirString)) {
		var fileName = get_open_filename_ext("REZ file|*.rez", "", RezDirString, "Open REZ");
	}
	else {
		var fileName = get_open_filename_ext("REZ file|*.rez", "", program_directory, "Open REZ");
	}

	if (fileName == "" or not file_exists(fileName)) {
		room_goto(rm_openingScreen);
		exit;
	}
	else{
		global.previousRezDirectory = filename_path(fileName);
	}




	global.fileSaveName = fileName;
	if (filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "\\") {
		global.fileSaveName = "";
	}

	var newInstList = ds_list_create();

	if (file_exists(fileName)) {
		var wrapper = scr_loadJSONBuffer(fileName);
	
		if (not ds_exists(wrapper, ds_type_map)) {
			show_message("Error loading " + fileName);
			room_goto(rm_openingScreen);
			exit;
		}
	
		var list = ds_map_find_value(wrapper, "ROOT");
	
		if (is_undefined(list)) {
			show_message("Error loading " + fileName);
			room_goto(rm_openingScreen);
			exit;
		}
	
		global.openedREZFile = true;
	
		//show_message("global.tokenImportGridWidth: " + string(ds_grid_width(global.tokenImportGrid)) + ", global.tokenImportGridHeight: " + string(ds_grid_height(global.tokenImportGrid)));
	
		var listSize = ds_list_size(list);
		for (var i = 0; i < listSize; i++) {
			var map = ds_list_find_value(list, i);
		
			var objectIndex = ds_map_find_value(map, "objectIndex");
		
		
			with (asset_get_index(objectIndex)) {
				if (objectIndex == "obj_control") {
					obj_control.currentCenterDisplayRow = 0;
			
					obj_fileLoader.subLineGridBeginning = ds_map_find_value(map, "subLineGridBeginning");
					obj_fileLoader.subLineGridEnd = ds_map_find_value(map, "subLineGridEnd");
					global.importGridWidth = ds_map_find_value(map, "importGridWidth");
					global.importCSVGridWidth = ds_map_find_value(map, "importCSVGridWidth");
				
					global.unitImportUnitDelimColName = ds_map_find_value(map, "unitImportUnitDelimColName");
					global.unitImportTurnDelimColName = ds_map_find_value(map, "unitImportTurnDelimColName");
					global.wordImportWordDelimColName = ds_map_find_value(map, "wordImportWordDelimColName");
					global.unitImportTranslationColName = ds_map_find_value(map, "unitImportTranslationColName");
					global.unitImportSpeakerColName = ds_map_find_value(map, "unitImportSpeakerColName");
					global.unitImportUnitEndColName = ds_map_find_value(map, "unitImportUnitEndColName");
					global.unitImportUnitStartColName = ds_map_find_value(map, "unitImportUnitStartColName");
					global.tokenImportTranscriptColName = ds_map_find_value(map, "tokenImportTranscriptColName");
					global.tokenImportDisplayTokenColName = ds_map_find_value(map, "tokenImportDisplayTokenColName");
					
					if(global.tokenImportDisplayTokenColName == undefined ){
						global.tokenImportDisplayTokenColName = "~text";
					}
					

				
					global.importGridColNameList = ds_map_find_value(map, "importGridColNameList");
				
					global.tokenImportColNameList = ds_map_find_value(map, "tokenImportColNameList");
					global.wordImportColNameList = ds_map_find_value(map, "wordImportColNameList");
					global.unitImportColNameList = ds_map_find_value(map, "unitImportColNameList");
					obj_control.currentDisplayTokenColsList = ds_map_find_value(map, "currentDisplayTokenColsList");
					obj_control.currentDisplayUnitColsList = ds_map_find_value(map, "currentDisplayUnitColsList");
				
					if (ds_map_find_value(map, "showParticipantName") != undefined) {
						obj_control.showParticipantName = ds_map_find_value(map, "showParticipantName");
					}
				
					if (global.tokenImportColNameList == undefined) {
						global.tokenImportColNameList = ds_list_create();
					}
					else {
						global.tokenImportGridWidth = ds_list_size(global.tokenImportColNameList);
					}
					
					if (global.wordImportColNameList == undefined) {
						global.wordImportColNameList = ds_list_create();
					}
					else {
						global.wordImportGridWidth = ds_list_size(global.wordImportColNameList);
					}
					
					if (global.unitImportColNameList == undefined) {
						global.unitImportColNameList = ds_list_create();
					}
					else {
						global.unitImportGridWidth = ds_list_size(global.unitImportColNameList);
					}
					
				
					global.tokenImportTagMap = ds_map_find_value(map, "tokenImportTagMap");
					global.unitImportTagMap = ds_map_find_value(map, "unitImportTagMap");
				
					if (global.tokenImportTagMap == undefined) {
						global.tokenImportTagMap = ds_map_create();
					}
					else {
						global.tokenTagMapFilled = true;
					}
					if (global.unitImportTagMap == undefined) {
						global.unitImportTagMap = ds_map_create();
					}
					else {
						global.unitTagMapFilled = true;
					}
					
					// check if the stackTagMap is available in the REZ file
					// if it is, we will take the stackTagMap in the REZ file
					// if it is not, we will stick with the one we've already created
					var stackMapFromREZ = ds_map_find_value(map, "stackTagMap");
					if (!is_undefined(stackMapFromREZ)) {
						 global.stackTagMap = ds_map_find_value(map, "stackTagMap");
					}
				
				
				
					if (global.tokenImportColNameList == undefined) {
						var tempList = ds_list_create();
						global.tokenImportColNameList = tempList;
						ds_list_add(global.tokenImportColNameList, "~UnitID", "~TokenID", "~text", "~transcript");
					}
					if (global.wordImportColNameList == undefined) {
						var tempList = ds_list_create();
						global.wordImportColNameList = tempList;
						ds_list_add(global.wordImportColNameList, "~UnitID", "~WordID");
					}
					if (global.unitImportColNameList == undefined) {
						var tempList2 = ds_list_create();
						global.unitImportColNameList = tempList2;
						ds_list_add(global.tokenImportColNameList, "~UnitID", "~Participant");
					}
					if (global.importGridColNameList == undefined) {
						var tempList3 = ds_list_create();
						global.importGridColNameList = tempList3;
					}
					if (obj_control.currentDisplayTokenColsList == undefined) {
						var tempList4 = ds_list_create();
						obj_control.currentDisplayTokenColsList = tempList4;
						ds_list_add(obj_control.currentDisplayTokenColsList,2,4,5,6,7);

					}
					if (obj_control.currentDisplayUnitColsList == undefined) {
						var tempList5 = ds_list_create();
						obj_control.currentDisplayUnitColsList = tempList5;
						ds_list_add(obj_control.currentDisplayUnitColsList,1,2,3,4,5);
					}
				
				

			
					/*
					scr_loadREZGridReset(global.fileLineRipGrid, map, "fileLineRipGrid");
					scr_loadREZGridReset(tempWordGrid, map, "wordGrid");
					scr_loadREZGridReset(dynamicWordGrid, map, "dynaWordGrid");
					scr_loadREZGridReset(wordDrawGrid, map, "wordDrawGrid");
					scr_loadREZGridReset(unitGrid, map, "unitGrid");
					scr_loadREZGridReset(lineGrid, map, "lineGrid");
					*/
				
					originalWordGridHeight = ds_grid_height(wordGrid);
					originalUnitGridHeight = ds_grid_height(unitGrid);
					originalLineGridHeight = ds_grid_height(lineGrid);
				
					scr_loadAnotherREZ(global.fileLineRipGrid, map, "fileLineRipGrid");
					scr_loadAnotherREZ(wordGrid, map, "wordGrid");
					scr_loadAnotherREZ(dynamicWordGrid, map, "dynaWordGrid");
					scr_loadAnotherREZ(wordDrawGrid, map, "wordDrawGrid");
					scr_loadAnotherREZ(unitGrid, map, "unitGrid");
					scr_loadAnotherREZ(lineGrid, map, "lineGrid");
					scr_loadAnotherREZ(global.importGrid, map, "importGrid");
					scr_loadAnotherREZ(global.importCSVGrid, map, "importCSVGrid");
					scr_loadAnotherREZ(obj_control.morphGrid, map, "morphGrid");
					ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, 0);
					ds_grid_resize(global.wordImportGrid, global.wordImportGridWidth, 0);
					ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, 0);
				
					scr_loadAnotherREZ(global.tokenImportGrid, map, "tokenImport");
					scr_loadAnotherREZ(global.wordImportGrid, map, "wordImport");
					scr_loadAnotherREZ(global.unitImportGrid, map, "unitImport");
					scr_loadAnotherREZ(global.discoImportGrid, map, "discoImport");
					scr_loadAnotherREZ(global.customLabelGrid, map, "CustomLabelGrid");
				
				
			
				
				
					global.totalUnitAmount = scr_getTotalUnitAmount();
				}
				else if (objectIndex == "obj_chain") {
				
					scr_loadREZGridReset(obj_chain.linkGrid, map, "linkGrid");
					scr_loadREZGridReset(obj_chain.rezChainGrid, map, "rezChainGrid");
					scr_loadREZGridReset(obj_chain.trackChainGrid, map, "trackChainGrid");
					scr_loadREZGridReset(obj_chain.stackChainGrid, map, "stackChainGrid");
					scr_loadREZGridReset(obj_chain.chunkGrid, map, "chunkChainGrid");
					scr_loadREZGridReset(obj_chain.unitInStackGrid, map, "unitInStackGrid");
					scr_loadREZGridReset(obj_chain.cliqueGrid, map, "cliqueGrid");
					scr_loadREZGridReset(obj_chain.goldStandardGrid, map, "goldStandardGrid");
				
				
					// Set the cliqueDisplayGrid to the correct height
					ds_grid_resize(obj_chain.cliqueDisplayGrid, obj_chain.chainGridWidth, ds_grid_height(obj_chain.cliqueGrid));
				
					obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
					scr_refreshChainGrid();
					obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
					scr_refreshChainGrid();
					obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
					scr_refreshChainGrid();
				
					obj_chain.chainColorID[1] = ds_map_find_value(map, "chainColorID1");
					obj_chain.chainColorID[2] = ds_map_find_value(map, "chainColorID2");
					obj_chain.chainColorID[3] = ds_map_find_value(map, "chainColorID3");
				
				
				}
			}		
		}
	}

	ds_list_destroy(newInstList);

	obj_chain.currentChainID = ds_grid_get_max(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(obj_chain.linkGrid));
	obj_chain.linkIDCounter = ds_grid_get_max(obj_chain.linkGrid, obj_chain.linkGrid_colLinkID, 0, obj_chain.linkGrid_colLinkID, ds_grid_height(obj_chain.linkGrid));
	obj_chain.cliqueIDCounter = ds_grid_get_max(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colCliqueID, 0, obj_chain.cliqueGrid_colCliqueID, ds_grid_height(obj_chain.cliqueGrid));
	obj_chain.rezChainNameCounter = ds_grid_height(obj_chain.rezChainGrid);
	obj_chain.trackChainNameCounter = ds_grid_height(obj_chain.trackChainGrid);
	obj_chain.stackChainNameCounter = ds_grid_height(obj_chain.stackChainGrid);
	obj_chain.placeChainNameCounter = ds_grid_height(obj_chain.placeChainGrid);
	obj_control.chunkID = ds_grid_get_max(obj_chain.chunkGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.chunkGrid));
	if (!is_numeric(obj_control.chunkID)) {
		obj_control.chunkID = 0;
	}
	show_debug_message("scr_loadREZ() ... obj_control.chunkID: " + string(obj_control.chunkID));

	scr_refreshVizLinkGrid();

	if(ds_grid_height(obj_control.lineGrid) > 1) {
	
		var newGridSpaceVertical = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, 1) - ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, 0); 
		if(newGridSpaceVertical < 60) {
			scr_refreshLineGridPixelY();
			newGridSpaceVertical = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, 1) - ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, 0); 
		}
		if(newGridSpaceVertical != obj_control.gridSpaceVertical) {
			obj_control.gridSpaceVertical = newGridSpaceVertical;
			obj_control.prevGridSpaceVertical = newGridSpaceVertical;
			obj_control.filterPrevGridSpaceVertical = newGridSpaceVertical;
			obj_control.searchPrevGridSpaceVertical = newGridSpaceVertical;
		}
	}

	if(obj_fileLoader.subLineGridBeginning != undefined and obj_fileLoader.subLineGridEnd != undefined ){
		if(obj_fileLoader.subLineGridBeginning > -1 and obj_fileLoader.subLineGridEnd > -1){
			scr_gridDeleteRange(obj_control.lineGrid, obj_control.lineGrid_colUnitID, obj_fileLoader.subLineGridBeginning, obj_fileLoader.subLineGridEnd);
			var lineGridHeight = ds_grid_height(obj_control.lineGrid);
			for (var i = 0; i < lineGridHeight; i++)
			{
				ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
				ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
			}
			scr_refreshLineGridDisplayRow(obj_control.lineGrid);
		}
	}

	ds_grid_copy(obj_control.lineGridBackup, obj_control.lineGrid);
	//scr_refreshLineGridDisplayRow(obj_control.lineGridBackup);


	// update tokenImport
	if (ds_list_size(global.tokenImportColNameList) > 4 || ds_list_size(global.unitImportColNameList) > 0) {
		if (ds_list_size(global.tokenImportColNameList) > 4) {
			global.tokenImportGridWidth = ds_list_size(global.tokenImportColNameList);
		}
		if (ds_list_size(global.unitImportColNameList) > 0) {
			global.unitImportGridWidth = ds_list_size(global.unitImportColNameList);
		}
		with (obj_gridViewer) {
			alarm[2] = 1;
		}
	}

	if (ds_grid_height(global.tokenImportGrid) <= ds_grid_height(obj_control.wordGrid)) {
		ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(obj_control.wordGrid));
	}
	if (ds_grid_height(global.unitImportGrid) <= ds_grid_height(obj_control.unitGrid)) {
		ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, ds_grid_height(obj_control.unitGrid));
	}


	if (ds_grid_width(global.importCSVGrid) <= 0) {
		//scr_fillTokenImportGrid();
	}


}
