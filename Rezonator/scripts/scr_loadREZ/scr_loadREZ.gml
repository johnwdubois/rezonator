if (directory_exists_ns(global.rezonatorDirString)) {
	var fileName = get_open_filename_ext("REZ file|*.rez", "", global.rezonatorDirString, "Open REZ");
}
else {
	var fileName = get_open_filename_ext("REZ file|*.rez", "", program_directory, "Open REZ");
}

if (fileName == "" or not file_exists(fileName)) {
	game_restart();
	exit;
}

global.fileSaveName = fileName;

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
				
				scr_loadREZGridReset(global.fileLineRipGrid, map, "fileLineRipGrid");
				scr_loadREZGridReset(wordGrid, map, "wordGrid");
				scr_loadREZGridReset(dynamicWordGrid, map, "dynaWordGrid");
				scr_loadREZGridReset(wordDrawGrid, map, "wordDrawGrid");
				scr_loadREZGridReset(unitGrid, map, "unitGrid");
				scr_loadREZGridReset(lineGrid, map, "lineGrid");
				
				global.totalUnitAmount = scr_getTotalUnitAmount();
			}
			else if (objectIndex == "obj_chain") {
				
				scr_loadREZGridReset(obj_chain.linkGrid, map, "linkGrid");
				scr_loadREZGridReset(obj_chain.rezChainGrid, map, "rezChainGrid");
				scr_loadREZGridReset(obj_chain.trackChainGrid, map, "trackChainGrid");
				scr_loadREZGridReset(obj_chain.stackChainGrid, map, "stackChainGrid");
				scr_loadREZGridReset(obj_chain.unitInStackGrid, map, "unitInStackGrid");
				scr_loadREZGridReset(obj_chain.cliqueGrid, map, "cliqueGrid");
				
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
scr_refreshVizLinkGrid();