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
	var grid = ds_grid_create(5, 0);
	
	for (var i = 0; i < chainListSize; i++) {
		// get current chain
		var currentChain = ds_list_find_value(chainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// get chain info
		var currentChainType = ds_map_find_value(currentChainSubMap, "type");
		var currentChainName = ds_map_find_value(currentChainSubMap, "chainName");
		var currentChainFilter = ds_map_find_value(currentChainSubMap, "filter");
		
		// put info in grid
		ds_grid_resize(grid, ds_grid_width(grid), ds_grid_height(grid) + 1);
		ds_grid_set(grid, grid_colChainID, ds_grid_height(grid) - 1, currentChain);
		ds_grid_set(grid, grid_colType, ds_grid_height(grid) - 1, currentChainType);
		ds_grid_set(grid, grid_colName, ds_grid_height(grid) - 1, currentChainName);
		ds_grid_set(grid, grid_colFilter, ds_grid_height(grid) - 1, currentChainFilter);
		
		// put alignment in export grids if this is a rez or track
		if (currentChainType == "rezChain" || currentChainType == "trackChain") {
			var currentChainAlign = ds_map_find_value(currentChainSubMap, "alignChain");
			ds_grid_set(grid, grid_colAlign, ds_grid_height(grid) - 1, currentChainAlign);
		}
	}
	
	return grid;
	
}