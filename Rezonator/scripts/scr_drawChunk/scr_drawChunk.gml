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
for (var i = 0; i < ds_grid_height(boxChainGrid); i++) {
	if(ds_grid_get(boxChainGrid, chainGrid_colChainState, i) == 1) {
		var currentWordList = ds_grid_get(boxChainGrid, boxChainGrid_colBoxWordIDList, i);
		if(ds_list_size(currentWordList) < 1) {
				//show_message(scr_getStringOfList(currentWordList));
				continue;
		}
		firstWordID = ds_list_find_value(currentWordList, 0);
		lastWordID = ds_list_find_value(currentWordList, ds_list_size(currentWordList)-1);
		var currentUnitID = ds_list_find_value(ds_grid_get(boxChainGrid, chainGrid_colWordIDList, i), 0);
		var currentDisplayRow = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID);
		if(currentDisplayRow == -1) {
			continue;	
		}
		//currentDisplayRow = ds_grid_get(currentActiveLineGrid, lineGrid_colDisplayRow, currentDisplayRow);
		//	var currentLineY = ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawLineLoop);
		displayLineY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentDisplayRow);
		var leftPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, firstWordID - 1);
		var rightPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, lastWordID - 1);
		
		
		
		topLeftX = leftPixelX - 4;
		topLeftY = displayLineY - (obj_control.gridSpaceVertical/2);
		bottomLeftX = topLeftX;
		bottomLeftY = topLeftY + obj_control.gridSpaceVertical;
		
		topRightX = rightPixelX + obj_control.gridSpaceHorizontal - 6;
		topRightY = topLeftY;
		bottomRightX = topRightX;
		bottomRightY = bottomLeftY;
		
		
		draw_set_color(c_black);
		draw_line_width(topLeftX, topLeftY, bottomLeftX, bottomLeftY, 2);
		draw_line_width(topLeftX, topLeftY, topRightX, topRightY, 2);
		draw_line_width(topRightX, topRightY, bottomRightX, bottomRightY, 2);
		draw_line_width(bottomLeftX, bottomLeftY, bottomRightX, bottomRightY, 2);
		
	}
}

