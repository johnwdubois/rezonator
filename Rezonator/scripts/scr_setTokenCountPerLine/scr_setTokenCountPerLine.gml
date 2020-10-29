// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setTokenCountPerLine(){
	
	// loop through the blockGrid
	var blockGridHeight = ds_grid_height(global.blockGrid);
	for (var i = 0; i < blockGridHeight; i++) {
		
		// get this block's lineList
		var currentLineList = ds_grid_get(global.blockGrid, global.blockGrid_colLineList, i);
		var currentLineListSize = ds_list_size(currentLineList);
		var currentTokenCountList = ds_list_create();
		
		// loop through this block's lineList
		for (var j = 0; j < currentLineListSize; j++) {
			
			// tokenize this line
			var currentLine = ds_list_find_value(currentLineList, j);
			var currentStr = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, currentLine);
			var currentTokenList = scr_splitStringWhitespaceAndHyphen(currentStr);
			var currentTokenListSize = ds_list_size(currentTokenList);
			
			// store the amount of tokens in currentTokenCountList
			ds_list_add(currentTokenCountList, currentTokenListSize);
			ds_list_destroy(currentTokenList);
		}
		
		// set currentTokenCountList in blockGrid
		ds_grid_set(global.blockGrid, global.blockGrid_colTokenCountList, i, currentTokenCountList);
	}
	
}