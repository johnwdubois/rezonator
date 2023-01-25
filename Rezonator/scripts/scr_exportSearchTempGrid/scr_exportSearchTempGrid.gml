

function scr_exportSearchTempGrid() {
	
	var grid = ds_grid_create(3, 0);
	var grid_colName = 0;
	var grid_colSearchedWords = 1;
	var grid_colHitTokens = 2;
	
	var searchList = global.nodeMap[? "searchNodeList"];
	if (!scr_isNumericAndExists(searchList, ds_type_list)) {
		return grid;
	}
	
	var searchListSize = ds_list_size(searchList);
	ds_grid_resize(grid, 3, searchListSize);
	ds_grid_clear(grid, "");
	
	for (var i = 0; i < searchListSize; i++) {
		
		var currentSearch = searchList[| i];
		var currentSearchSubMap = global.searchMap[? currentSearch];
		if (!scr_isNumericAndExists(currentSearchSubMap, ds_type_map)) continue;
		
		var currentSearchName = currentSearchSubMap[? "name"];
		var currentSearchedWords = currentSearchSubMap[? "searchTermList"];
		var currentHitTokens = currentSearchSubMap[? "displayTokenList"];
		
		grid[# grid_colName, i] = currentSearchName;
		grid[# grid_colSearchedWords, i] = scr_getStringOfList(currentSearchedWords);
		grid[# grid_colHitTokens, i] = scr_getStringOfList(currentHitTokens);
	}
	
	return grid;
	
	
	
}