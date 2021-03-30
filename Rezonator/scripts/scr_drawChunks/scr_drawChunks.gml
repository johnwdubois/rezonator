// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawChunks(){
	
	// loop through all the chunks currently on screen, and draw them!
	var chunkShowListSize = ds_list_size(chunkShowList);
	for (var i = 0; i < chunkShowListSize; i++) {
		
		// get submap of chunk and make sure it exists
		var currentChunkID = chunkShowList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunkID];
		if (!is_numeric(currentChunkSubMap)) continue;
		if (!ds_exists(currentChunkSubMap, ds_type_map)) continue;
		
		// get tokenList of current chunk
		var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
		if (!is_numeric(currentChunkTokenList)) continue;
		if (!ds_exists(currentChunkTokenList, ds_type_list)) continue;
		
		// get first & last token of chunk
		var currentChunkFirstTokenID = currentChunkTokenList[| 0];
		var currentChunkLastTokenID = currentChunkTokenList[| ds_list_size(currentChunkTokenList) - 1];
		
		// get x coordinates of words
		var firstTokenLeftX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentChunkFirstTokenID - 1);		
		var lastTokenLeftX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentChunkLastTokenID - 1);
		var lastTokenDisplayStr = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentChunkLastTokenID - 1));
		var lastTokenStrWidth = string_width(lastTokenDisplayStr);
		var lastTokenRightX = lastTokenLeftX + lastTokenStrWidth;
		var displayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentChunkFirstTokenID - 1);
		
		scr_adaptFont(lastTokenDisplayStr, "M");
		var strHeight = string_height(lastTokenDisplayStr);
		
		// set rect coordinates for chunk
		var chunkRectX1 = firstTokenLeftX - 10;
		var chunkRectY1 = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, displayRow) - strHeight;
		var chunkRectX2 = lastTokenRightX + 10;
		var chunkRectY2 = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, displayRow) + strHeight;
		
		
		draw_set_color(global.colorThemeSelected2);
		draw_set_alpha(1);
		scr_drawRectWidth(chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2, 4);

		
	
	}
	
	
}