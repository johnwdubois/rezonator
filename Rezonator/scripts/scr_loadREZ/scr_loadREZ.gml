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
	RezDirString = global.rezonatorDirString + "\\Data\\SBCorpus\\Rez";
	if (os_type == os_macosx) {
		RezDirString = global.rezonatorDirString + "/Data/SBCorpus/Rez";
	}
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
	game_restart();
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
		game_restart();
		exit;
	}
	
	var list = ds_map_find_value(wrapper, "ROOT");
	
	if (is_undefined(list)) {
		show_message("Error loading " + fileName);
		game_restart();
		exit;
	}
	
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
				

				
				global.importGridColNameList = ds_map_find_value(map, "importGridColNameList");
				
				global.tokenImportColNameList = ds_map_find_value(map, "tokenImportColNameList")
				var tempList = ds_list_create();
				if(global.tokenImportColNameList == undefined){
					global.tokenImportColNameList = tempList;
					ds_list_add(global.tokenImportColNameList, "UnitID", "WordID", "text", "transcript");
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
				scr_loadAnotherREZ(global.tokenImportGrid, map, "tokenImport");
				scr_loadAnotherREZ(global.unitImportGrid, map, "unitImport");
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
if (ds_list_size(global.tokenImportColNameList) > 4) {
	global.tokenImportGridWidth = ds_list_size(global.tokenImportColNameList);
	with (obj_gridViewer) {
		alarm[2] = 1;
	}
}

if (ds_grid_height(global.tokenImportGrid) <= ds_grid_height(obj_control.wordGrid)) {
	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(obj_control.wordGrid));
}


if(ds_grid_width(global.importCSVGrid) > 0){
	scr_fillTokenImportGridCSV();
}
else{
	scr_fillTokenImportGrid();
}