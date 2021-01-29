function scr_addToSearchGrid(currentUnitID, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, jCounter) {
	/*
		scr_addToSearchGrid();
	
		Last Updated: 2019-07-2
	
		Called from: obj_Control
	
		Purpose: add all found words to search grid
	
		Mechanism: loop through unitGrid looking at every wordIDList for searched word, if that row in unitGrid contains searched word,
					add that row to new lineGrid
	
		Author: Terry DuBois, Georgio Klironomos, Brady Moore
	*/
	
	show_debug_message("scr_addToSearchGrid() ... currentUnitID: " + string(currentUnitID) + ", currentWordID: " + string(currentWordID) + ", jCounter: " + string(jCounter));

	ds_grid_resize(obj_control.searchGrid, obj_control.lineGridWidth, ds_grid_height(obj_control.searchGrid) + 1);
	var currentRowSearchGrid = ds_grid_height(obj_control.searchGrid) - 1;
			
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colDisplayRow, currentRowSearchGrid, currentRowSearchGrid);
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, currentRowSearchGrid, 0);
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colUnitID, currentRowSearchGrid, currentUnitID);
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colPixelY, currentRowSearchGrid, currentRowSearchGrid * (obj_control.gridSpaceVertical));
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, currentRowSearchGrid, currentRowSearchGrid * (obj_control.gridSpaceVertical));
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colDiscoID, currentRowSearchGrid, currentDiscoID);
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineNumberLabel, currentRowSearchGrid, currentUtteranceID);
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colUnitStart, currentRowSearchGrid, currentUnitStart);
	ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colUnitEnd, currentRowSearchGrid, currentUnitEnd);
			
	var currentHitIDList = ds_list_create();
			
	// add all the words in this unit to the searchGrid
	var currentWordIDListSize = ds_list_size(currentWordIDList);
	for (var k = 0; k < currentWordIDListSize; k++) {
				
		var hitGridCurrentWordID = ds_list_find_value(currentWordIDList, k);
		var hitGridCurrentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		var hitGridCurrentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
		var hitGridCurrentHitBool = false;
				
		if (hitGridCurrentWordID == currentWordID) {
			hitGridCurrentHitBool = true;
		}
		var hitGridCurrentDisplayCol = k - jCounter;
				
		ds_grid_resize(obj_control.hitGrid, obj_control.hitGridWidth, ds_grid_height(obj_control.hitGrid) + 1);
		var currentRowHitGrid = ds_grid_height(obj_control.hitGrid) - 1;

				
		ds_grid_set(obj_control.hitGrid, obj_control.hitGrid_colWordID, currentRowHitGrid, hitGridCurrentWordID);
		ds_grid_set(obj_control.hitGrid, obj_control.hitGrid_colUnitID, currentRowHitGrid, hitGridCurrentUnitID);
		ds_grid_set(obj_control.hitGrid, obj_control.hitGrid_colHitID, currentRowHitGrid, obj_control.hitIDCounter);
		ds_grid_set(obj_control.hitGrid, obj_control.hitGrid_colWordState, currentRowHitGrid, hitGridCurrentWordState);
		ds_grid_set(obj_control.hitGrid, obj_control.hitGrid_colHitBool, currentRowHitGrid, hitGridCurrentHitBool);
		ds_grid_set(obj_control.hitGrid, obj_control.hitGrid_colDisplayCol, currentRowHitGrid, hitGridCurrentDisplayCol);
				
				
		ds_list_add(currentHitIDList, obj_control.hitIDCounter);
		obj_control.hitIDCounter++;
	}
			
	ds_grid_set(obj_control.searchGrid, obj_control.searchGrid_colHitIDList, currentRowSearchGrid, currentHitIDList);
				





}
