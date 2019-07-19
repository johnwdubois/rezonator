/*
	scr_addToSearchGrid();
	
	Last Updated: 2019-07-2
	
	Called from: obj_Control
	
	Purpose: add all found words to search grid
	
	Mechanism: loop through unitGrid looking at every wordIDList for searched word, if that row in unitGrid contains searched word,
				add that row to new lineGrid
	
	Author: Terry DuBois, Georgio Klironomos, Brady Moore
*/


var iCounter  = argument[0];
var currentDiscoID = argument[1];
var currentUtteranceID = argument[2];
var currentUnitStart = argument[3];
var currentUnitEnd = argument[4];
var currentWordIDList = argument[5];
var currentWordID = argument[6];
var jCounter =  argument[7]; 



ds_grid_resize(searchGrid, lineGridWidth, ds_grid_height(searchGrid) + 1);
var currentRowSearchGrid = ds_grid_height(searchGrid) - 1;
			
ds_grid_set(searchGrid, lineGrid_colDisplayRow, currentRowSearchGrid, currentRowSearchGrid);
ds_grid_set(searchGrid, lineGrid_colLineState, currentRowSearchGrid, 0);
ds_grid_set(searchGrid, lineGrid_colUnitID, currentRowSearchGrid, iCounter + 1);
ds_grid_set(searchGrid, lineGrid_colPixelY, currentRowSearchGrid, currentRowSearchGrid * (obj_control.gridSpaceVertical));
ds_grid_set(searchGrid, lineGrid_colPixelYOriginal, currentRowSearchGrid, currentRowSearchGrid * (obj_control.gridSpaceVertical));
ds_grid_set(searchGrid, lineGrid_colDiscoID, currentRowSearchGrid, currentDiscoID);
ds_grid_set(searchGrid, lineGrid_colLineNumberLabel, currentRowSearchGrid, currentUtteranceID);
ds_grid_set(searchGrid, lineGrid_colUnitStart, currentRowSearchGrid, currentUnitStart);
ds_grid_set(searchGrid, lineGrid_colUnitEnd, currentRowSearchGrid, currentUnitEnd);
			
var currentHitIDList = ds_list_create();
			
// add all the words in this unit to the searchGrid
for (var k = 0; k < ds_list_size(currentWordIDList); k++) {
				
	var hitGridCurrentWordID = ds_list_find_value(currentWordIDList, k);
	var hitGridCurrentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1);
	var hitGridCurrentWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordID - 1);
	var hitGridCurrentHitBool = false;
				
	if (hitGridCurrentWordID == currentWordID) {
		hitGridCurrentHitBool = true;
	}
	var hitGridCurrentDisplayCol = k - jCounter;
				
	ds_grid_resize(hitGrid, hitGridWidth, ds_grid_height(hitGrid) + 1);
	var currentRowHitGrid = ds_grid_height(hitGrid) - 1;

				
	ds_grid_set(hitGrid, hitGrid_colWordID, currentRowHitGrid, hitGridCurrentWordID);
	ds_grid_set(hitGrid, hitGrid_colUnitID, currentRowHitGrid, hitGridCurrentUnitID);
	ds_grid_set(hitGrid, hitGrid_colHitID, currentRowHitGrid, hitIDCounter);
	ds_grid_set(hitGrid, hitGrid_colWordState, currentRowHitGrid, hitGridCurrentWordState);
	ds_grid_set(hitGrid, hitGrid_colHitBool, currentRowHitGrid, hitGridCurrentHitBool);
	ds_grid_set(hitGrid, hitGrid_colDisplayCol, currentRowHitGrid, hitGridCurrentDisplayCol);
				
				
	ds_list_add(currentHitIDList, hitIDCounter);
	hitIDCounter++;
}
			
ds_grid_set(searchGrid, searchGrid_colHitIDList, currentRowSearchGrid, currentHitIDList);
				


