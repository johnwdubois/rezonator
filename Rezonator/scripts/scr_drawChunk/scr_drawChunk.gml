/*
	scr_drawChunk();
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: draw rezChains and move words on screen according to the rezChains
	
	Mechanism: loop through each row in rezChainGrid, get the wordIDList from each chain, and draw lines
				from word information
				
	Author: Terry DuBois
*/

draw_set_font(fnt_main);

var displayLineY = undefined;

var topLeftX = undefined;
var topLeftY = undefined;
var bottomLeftX = undefined;
var bottomLeftY = undefined;

var topRightX = undefined;
var topRightY = undefined;
var bottomRightX = undefined;
var bottomRightY = undefined;

var firstWordID = -1;
var lastWordID = -1;

// loop through rezChainGrid to get chain info
for (var i = 0; i < ds_grid_height(chunkGrid); i++) {
	if(ds_grid_get(chunkGrid, chainGrid_colChainState, i) == 1) {
		var currentWordList = ds_grid_get(chunkGrid, chunkGrid_colBoxWordIDList, i);
		if(ds_list_size(currentWordList) < 1) {
				continue;
		}
		firstWordID = ds_list_find_value(currentWordList, 0);
		lastWordID = ds_list_find_value(currentWordList, ds_list_size(currentWordList)-1);
		var currentUnitID = ds_list_find_value(ds_grid_get(chunkGrid, chainGrid_colWordIDList, i), 0);
		var currentDisplayRow = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID);
		if(currentDisplayRow == -1) {
			continue;	
		}

		var wordRectBuffer = 2;
		displayLineY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentDisplayRow);
		var leftPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, firstWordID - 1);
		var rightPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, lastWordID - 1);
		// get the string of this word to draw to the main screen
		var firstWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, firstWordID - 1);
		// get the string of this word to draw to the main screen
		var lastWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, lastWordID - 1);
		
		topLeftX = leftPixelX - 4;
		topLeftY = displayLineY - (string_height(firstWordString) / 2) - wordRectBuffer;
		bottomLeftX = topLeftX;
		bottomLeftY = topLeftY + string_height(firstWordString) + (wordRectBuffer * 2);
		
		topRightX = rightPixelX + string_width(lastWordString) + (wordRectBuffer * 2);
		topRightY = topLeftY;
		bottomRightX = topRightX;
		bottomRightY = bottomLeftY;
		
		draw_set_color(c_gray);
		draw_line_width(topLeftX, topLeftY, bottomLeftX, bottomLeftY, 2);
		draw_line_width(topLeftX, topLeftY, topRightX, topRightY, 2);
		draw_line_width(topRightX, topRightY, bottomRightX, bottomRightY, 2);
		draw_line_width(bottomLeftX, bottomLeftY, bottomRightX, bottomRightY, 2);
		
	}
}

