//show_message("here")

var grid = argument0;
var rowInChainGrid =  argument1;

//var displayColList = ds_list_create();
var displayColGridWidth = 2;
var displayColGrid_colWordID = 0;
var displayColGrid_colDisplayCol = 1;
var displayColGrid = ds_grid_create(displayColGridWidth, 0);

var wordIDList = ds_grid_get(grid, chainGrid_colWordIDList, rowInChainGrid);

if (ds_list_size(wordIDList) < 1) {
	exit;
}



// find the leftmost word in the word list for this chain
var furthestBackWord = ds_list_find_value(wordIDList, 0);
for (var i = 1; i < ds_list_size(wordIDList); i++) {
	var currentWordID = ds_list_find_value(wordIDList, i);
	var currentWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1);
	if (not currentWordAligned) {
		continue;
	}
	var currentWordStretch = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, currentWordID - 1);
	if (currentWordStretch) {
		continue;
	}
	var furthestBackDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestBackWord - 1);
	var currentWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
	if (currentWordDisplayCol < furthestBackDisplayCol) {
		furthestBackWord = currentWordID;
	}
}









var unitIDList = ds_list_create();

for (var i = 0; i < ds_list_size(wordIDList); i++) {
	var currentWordID = ds_list_find_value(wordIDList, i);
	var currentWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1);
	var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
	if (ds_list_size(unitIDList) > 0) {
		if (ds_list_find_index(unitIDList, currentUnitID) > -1) {
			continue;
		}
	}
	if (not currentWordAligned) {
		continue;
	}
	var currentWordStretch = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, currentWordID - 1);
	if (currentWordStretch) {
		continue;
	}
	var currentWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
	
	ds_list_add(unitIDList, currentUnitID);
	
	//ds_list_add(displayColList, currentWordDisplayCol);
	ds_grid_resize(displayColGrid, displayColGridWidth, ds_grid_height(displayColGrid) + 1);
	ds_grid_set(displayColGrid, displayColGrid_colWordID, ds_grid_height(displayColGrid) - 1, currentWordID);
	ds_grid_set(displayColGrid, displayColGrid_colDisplayCol, ds_grid_height(displayColGrid) - 1, currentWordDisplayCol);
}
ds_list_destroy(unitIDList);

if (ds_grid_height(displayColGrid) < 2) {
	ds_grid_destroy(displayColGrid);
	exit;
}
ds_grid_sort(displayColGrid, displayColGrid_colDisplayCol, true);

var firstDisplayColWordIDList = ds_list_create();
var displayColGridFirst_wordID = ds_grid_get(displayColGrid, displayColGrid_colWordID, 0);
ds_list_add(firstDisplayColWordIDList, displayColGridFirst_wordID);

var displayColGridFirst_displayCol = ds_grid_get(displayColGrid, displayColGrid_colDisplayCol, 0);
var displayColGridLast_displayCol = ds_grid_get(displayColGrid, displayColGrid_colDisplayCol, ds_grid_height(displayColGrid) - 1);

var rowInDisplayColGrid = 1;
while (ds_grid_get(displayColGrid, displayColGrid_colDisplayCol, rowInDisplayColGrid) == displayColGridFirst_displayCol) {
	var currentWordID = ds_grid_get(displayColGrid, displayColGrid_colWordID, rowInDisplayColGrid);
	ds_list_add(firstDisplayColWordIDList, currentWordID);
	
	rowInDisplayColGrid++;
	if (rowInDisplayColGrid >= ds_grid_height(displayColGrid)) {
		break;
	}
}

ds_list_sort(firstDisplayColWordIDList, true);
var str = "";
for (var i = 0; i < ds_list_size(firstDisplayColWordIDList); i++) {
	var currentWordID = ds_list_find_value(firstDisplayColWordIDList, i);
	str += string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1)) + ", ";
}
//show_message(str);
//show_message(scr_getStringOfList(firstDisplayColWordIDList));

var displayColGridFirst_wordID = ds_list_find_value(firstDisplayColWordIDList, 0);


//show_message(string(displayColGridFirst_displayCol) + "," + string(displayColGridLast_displayCol));

if (displayColGridFirst_displayCol < displayColGridLast_displayCol) {
	/*
	var displayColGridFirst_str = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, displayColGridFirst_wordID - 1);
	show_message(displayColGridFirst_str);
	*/
	
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, displayColGridFirst_wordID - 1, false);
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, displayColGridFirst_wordID - 1, true);
}
else {
	//show_message("done");
	ds_grid_destroy(displayColGrid);
	ds_list_destroy(firstDisplayColWordIDList);
	exit;
}

ds_grid_destroy(displayColGrid);
ds_list_destroy(firstDisplayColWordIDList);



with (obj_chain) {
	alarm[6] = 2;
}