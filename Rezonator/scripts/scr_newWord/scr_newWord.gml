var unitID = argument[0];
var wordSeq = argument[1];

if (unitID == -1 or wordSeq == -1 or gridView or currentActiveLineGrid == searchGrid) {
	exit;
}

//var wordIDListUnitGrid = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1);

// Ask the user for the new word, if this is not a chunk
if(argument_count == 2) {
	var wordTranscript = get_string("Type in new word", "example");
}
var wordToken = wordTranscript;

if (string_length(wordTranscript) < 1) {
	exit;
}

obj_control.moveCounter++;

ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;

var wordID = ds_grid_height(obj_control.wordGrid);


ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, unitID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, wordSeq + 1);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, wordToken);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, wordTranscript);

scr_loadDynamicWordGridIndividual(ds_grid_height(obj_control.wordGrid) - 1);


var rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), unitID);
if (rowInLineGrid < 0 or rowInLineGrid >= ds_grid_height(obj_control.lineGrid)) {
	exit;
}


var wordIDListLineGrid = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, rowInLineGrid);



ds_list_insert(wordIDListLineGrid, wordSeq + 1, wordID);
ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1, wordIDListLineGrid);




for (var i = wordSeq + 2; i < ds_list_size(wordIDListLineGrid); i++) {
	var currentWordID = ds_list_find_value(wordIDListLineGrid, i);
	var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
	var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
	
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1, currentWordSeq + 1);	
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol + 1);
}

// Aquire the newly set wordID list in the Unit Grid 
var wordIDListUnitGrid = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1);

// THIS ONLY WORKS FOR CHUNKS
// Check the wordID right before the new word, if it is not at the end of a line we check to see if it is in a box
if (ds_list_find_index(wordIDListUnitGrid,wordID) != (ds_list_size(wordIDListUnitGrid) - 1)) {
	
	// Find the ID of the word in front of the new word
	var prevWordID = ds_list_find_value(wordIDListUnitGrid, ds_list_find_index(wordIDListUnitGrid,wordID) - 1);
	if (prevWordID != undefined) {
		
		// Access the inBoxList from the dynWordGrid
		var prevInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, prevWordID - 1);
		
		// For each box the prev word is in, check if the prev word is not the last word in the box
		for(var boxListLoop = 0; boxListLoop < ds_list_size(prevInBoxList); boxListLoop++) {

			
			var currentBox = ds_list_find_value(prevInBoxList, boxListLoop);
			var currentBoxWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentBox - 1);

			if(ds_list_find_index(currentBoxWordList, prevWordID) != (ds_list_size(currentBoxWordList) - 1)) {

				// Insert new word into that box list, and add to the new word's inBoxList
				ds_list_insert(currentBoxWordList, ds_list_find_index(currentBoxWordList, prevWordID) + 1, wordID);
				ds_list_add(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, wordID - 1), currentBox);
			}
		}
	}
}