/*
	scr_loadRez();
	
	Last Updated: 2020-01-01
	
	Called from: obj_fileLoader
	
	Purpose: Load data from a Rez file into Rezonator
	
	Mechanism: Separate the JSON string into its different maps, then load the data from those maps into all the grids.
	
	Author: Terry DuBois
*/

//show_message(string(global.currentDirString));

var discourseDirString = global.currentDirString + "\\Discourse";
if (os_type == os_macosx) {
	discourseDirString = global.currentDirString + "/Discourse";
}


if (directory_exists(global.rezonatorDirString)) {
	var fileName = get_open_filename_ext("REZ file|*.rez", "", discourseDirString, "Open REZ");
}
else {
	var fileName = get_open_filename_ext("REZ file|*.rez", "", program_directory, "Open REZ");
}

if (fileName == "" or not file_exists(fileName)) {
	game_restart();
	exit;
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
	
	for (var i = 0; i < ds_list_size(list); i++) {
		var map = ds_list_find_value(list, i);
		
		var objectIndex = ds_map_find_value(map, "objectIndex");
		
		
		with (asset_get_index(objectIndex)) {
			if (objectIndex == "obj_control") {
				obj_control.currentCenterDisplayRow = 0;
			
				obj_fileLoader.subLineGridBeginning = ds_map_find_value(map, "subLineGridBeginning");
				obj_fileLoader.subLineGridEnd = ds_map_find_value(map, "subLineGridEnd");
				global.importToolboxGridWidth = ds_map_find_value(map, "importToolboxGridWidth");
				
				global.importToolboxGridColNameList = ds_map_find_value(map, "importToolboxGridColNameList");
			
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
				scr_loadAnotherREZ(global.importToolboxGrid, map, "toolboxGrid");
				scr_loadAnotherREZ(obj_control.morphGrid, map, "morphGrid");
				
				
				
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
		for (var i = 0; i < ds_grid_height(obj_control.lineGrid); i++)
		{
			ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
			ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
		}
		scr_refreshLineGridDisplayRow(obj_control.lineGrid);
	}
}

ds_grid_copy(obj_control.lineGridBackup, obj_control.lineGrid);
//scr_refreshLineGridDisplayRow(obj_control.lineGridBackup);