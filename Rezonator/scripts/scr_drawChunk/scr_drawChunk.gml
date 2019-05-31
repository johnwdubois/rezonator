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

var minWordWidth = 9999999;
var linePlusX = 0;

// loop through rezChainGrid to get chain info
for (var i = 0; i < ds_grid_height(boxChainGrid); i++) {
	if(ds_grid_get(boxChainGrid, chainGrid_colChainState, i) == 1) {
		var currentWordList = ds_grid_get(boxChainGrid, boxChainGrid_colBoxWordIDList, i);
		firstWordID = ds_list_find_value(currentWordList, 0);
		lastWordID = ds_list_find_value(currentWordList, ds_list_size(currentWordList)-1);
		
		//topLeftX = 
	}
}

