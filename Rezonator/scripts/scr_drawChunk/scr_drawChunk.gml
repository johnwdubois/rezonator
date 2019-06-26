/*
	scr_drawChunk();
	
	Last Updated: 2019-06-19
	
	Called from: obj_control
	
	Purpose: draw Chunk boxes around words
	
	Mechanism: loop through each row in chunkGrid, get the wordIDList from each chunk, and draw lines
				from word information
				
	Author: Georgio Klironomos
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

// loop through chunkGrid to get chain info
for (var i = 0; i < ds_grid_height(obj_chain.chunkGrid); i++) {
	
	// Make sure this Box is a Chunk
	if(ds_list_size(ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colWordIDList, i)) == 1) {
		
		// Grab the Chunk's list of contained words
		var currentWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, i);
		
		// Safety Check
		if(ds_list_size(currentWordList) < 1) {
				continue;
		}
		
		// Get the first and last word within the Chunk
		firstWordID = ds_list_find_value(currentWordList, 0);
		lastWordID = ds_list_find_value(currentWordList, ds_list_size(currentWordList)-1);
		
		// Get the Chunks Unit and Row
		var currentUnitID = ds_list_find_value(ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colWordIDList, i), 0);
		var currentDisplayRow = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID);
		if(currentDisplayRow == -1) {
			continue;	
		}

		// Set the Buffer to be initially large, so as to allow for nesting
		var wordRectBuffer = 6;
		if(ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, i) == true) {
			wordRectBuffer = 4;
		}
		
		// Set up the measurements for the drawn box
		displayLineY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentDisplayRow);
		var leftPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, firstWordID - 1);
		var rightPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, lastWordID - 1);
		// Get the string of the first word
		var firstWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, firstWordID - 1);
		// Get the string of the last word
		var lastWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, lastWordID - 1);
		
		topLeftX = leftPixelX - wordRectBuffer;
		topLeftY = displayLineY - (string_height(firstWordString) / 2) - wordRectBuffer;
		bottomLeftX = topLeftX;
		bottomLeftY = topLeftY + string_height(firstWordString) + (wordRectBuffer * 2);
		
		topRightX = rightPixelX + string_width(lastWordString) + (wordRectBuffer * 2);
		topRightY = topLeftY;
		bottomRightX = topRightX;
		bottomRightY = bottomLeftY;
		
		// Draw the Chunks visual representation
		draw_set_color(global.colorThemeSelected1);
		
		for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
			
				draw_rectangle(topLeftX - drawBorderLoop, topLeftY - drawBorderLoop, bottomRightX + drawBorderLoop, bottomRightY + drawBorderLoop, true);
		}
		
		//draw_rectangle(topLeftX, topLeftY, bottomRightX, bottomRightY, true);
		/*draw_line_width(topLeftX, topLeftY, bottomLeftX, bottomLeftY, 2);
		draw_line_width(topLeftX, topLeftY, topRightX, topRightY, 2);
		draw_line_width(topRightX, topRightY, bottomRightX, bottomRightY, 2);
		draw_line_width(bottomLeftX, bottomLeftY, bottomRightX, bottomRightY, 2);*/
	}
}

