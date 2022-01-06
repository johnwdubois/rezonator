// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportChainTempGrid(chainList){
	
	var chainListSize = ds_list_size(chainList);

	// set up grid
	var grid_colChainID = 0;
	var grid_colType = 1;
	var grid_colName = 2;
	var grid_colFilter = 3;
	var grid_colAlign = 4;
	var grid_colGapUnits = 5;
	var grid = ds_grid_create(6, 0);
	
	for (var i = 0; i < chainListSize; i++) {
		// get current chain
		var currentChain = ds_list_find_value(chainList, i);

		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		var tagMap = currentChainSubMap[? "tagMap"];
		// get chain info
		var currentChainType = ds_map_find_value(currentChainSubMap, "type");
		var currentChainName = ds_map_find_value(currentChainSubMap, "name");
		var currentChainFilter = ds_map_find_value(currentChainSubMap, "filter");
		
		// put info in grid
		ds_grid_resize(grid, ds_grid_width(grid), ds_grid_height(grid) + 1);

		ds_grid_set(grid, grid_colChainID, ds_grid_height(grid) - 1, currentChain);
		ds_grid_set(grid, grid_colType, ds_grid_height(grid) - 1, currentChainType);
		ds_grid_set(grid, grid_colName, ds_grid_height(grid) - 1, currentChainName);
		ds_grid_set(grid, grid_colFilter, ds_grid_height(grid) - 1, currentChainFilter);
		
		// put in stuff that is rez/track 
		if (currentChainType == "resonance" || currentChainType == "trail") {
			// alignment
			var currentChainAlign = ds_map_find_value(currentChainSubMap, "alignChain");
			ds_grid_set(grid, grid_colAlign, ds_grid_height(grid) - 1, currentChainAlign);
		}
		
		// get rid of align column if this is stack grid
		if (currentChainType == "stack" && ds_grid_width(grid) > 4) {
			//ds_grid_resize(grid, 4, ds_grid_height(grid));
		}
		
		// add entry tags to trackGrid
		var chainEntryFieldListSize = ds_list_size(global.chainFieldList);
		if(i == 0){
			ds_grid_resize(grid, ds_grid_width(grid)+chainEntryFieldListSize-1, ds_grid_height(grid));
		}

		for (var j = 0; j < chainEntryFieldListSize; j++) {

			var currentEntryField = global.chainFieldList[| j];
			var tag = "";
			if (ds_map_exists(tagMap, currentEntryField)) {
				tag = tagMap[? currentEntryField];
			}

			var currentCol = grid_colAlign + j + 1;
			ds_grid_set(grid, currentCol, ds_grid_height(grid) - 1, tag);
		}
	}
	
	return grid;
	
}