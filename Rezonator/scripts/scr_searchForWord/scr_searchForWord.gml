/*
	scr_searchForWord();
	
	Last Updated: 2018-09-11
	
	Called from: obj_chain
	
	Purpose: search entire wordGrid for given word, then create a new lineGrid that features every line containing that word
	
	Mechanism: loop through unitGrid looking at every wordIDList for searched word, if that row in unitGrid contains searched word,
				add that row to new lineGrid
	
	Author: Terry DuBois
*/

var wordToFind = get_string("Type string to find", "");

if (string_length(wordToFind) < 1) {
	exit;
}

var tempSearchGrid = ds_grid_create(ds_grid_width(lineGrid), ds_grid_height(lineGrid));

ds_grid_copy(tempSearchGrid, lineGrid);


// create new searchGrid so we can populate it from scratch
ds_grid_destroy(searchGrid);
searchGrid = ds_grid_create(ds_grid_width(lineGrid), 0);
ds_grid_destroy(hitGrid);
hitGrid = ds_grid_create(hitGridWidth, 0);

var hitIDCounter = 1;

// loop through unitGrid, so we can get the wordID list of every unit
for (var i = 0; i < ds_grid_height(unitGrid); i++) {
	var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, i);
	var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, i);
	var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, i);
	var currentUnitStart = ds_grid_get(unitGrid, unitGrid_colUnitStart, i);
	var currentUnitEnd = ds_grid_get(unitGrid, unitGrid_colUnitEnd, i);
	
	// now we loop through every word in wordID list to see if matches our search word
	for (var j = 0; j < ds_list_size(currentWordIDList); j++) {
		var currentWordID = ds_list_find_value(currentWordIDList, j);
		var currentWordToken = ds_grid_get(wordGrid, wordGrid_colWordToken, currentWordID - 1);
		var currentWordTranscript = ds_grid_get(wordGrid, wordGrid_colWordTranscript, currentWordID - 1);
		
		// if the word matches, we will add another row to the serachGrid and add all of this word's unit information
		if (string_lower(wordToFind) == string_lower(currentWordToken) or string_lower(wordToFind) == string_lower(currentWordTranscript)) {
			
			ds_grid_resize(searchGrid, lineGridWidth, ds_grid_height(searchGrid) + 1);
			var currentRowSearchGrid = ds_grid_height(searchGrid) - 1;
			
			ds_grid_set(searchGrid, lineGrid_colDisplayRow, currentRowSearchGrid, currentRowSearchGrid);
			ds_grid_set(searchGrid, lineGrid_colLineState, currentRowSearchGrid, 0);
			ds_grid_set(searchGrid, lineGrid_colUnitID, currentRowSearchGrid, i + 1);
			ds_grid_set(searchGrid, lineGrid_colPixelY, currentRowSearchGrid, room_height + gridSpaceVertical);
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
				var hitGridCurrentDisplayCol = k - j;
				
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
		}
	}
}

// check if we actually got any matches (check height of searchGrid)
if (ds_grid_height(searchGrid) > 0) {
	filterGridActive = false;
	searchGridActive = true;
	currentActiveLineGrid = searchGrid;
	currentCenterDisplayRow = 0;
	wordLeftMarginDest = window_get_width() / 2;
}
else {
	show_message("found zero matches");
	searchGridActive = false;
	filterGridActive = false;
	currentActiveLineGrid = lineGrid;
	preSwitchSearchDisplayRow = currentCenterDisplayRow;
	currentCenterDisplayRow = preSwitchDisplayRow;
	wordLeftMarginDest = 170;
}

ds_grid_destroy(tempSearchGrid);
