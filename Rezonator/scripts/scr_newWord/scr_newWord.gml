/*
	scr_newWord();
	
	Last Updated: 2019-06-25
	
	Called from: obj_control
	
	Purpose: Create a new word within the discourse based on user string input
	
	Mechanism: Place the new word and its attributes into each word grid
	
	Author: Terry DuBois, Georgio Klironomos
*/

// Take in the arguments, and check if this word is a Chunk word
var unitID = argument[0];
var wordSeq = argument[1];
var wordTranscript = argument[2];


// Safety check
if (unitID == -1 or wordSeq == -1 or obj_control.gridView or obj_control.currentActiveLineGrid == obj_control.searchGrid) {
	exit;
}




//var wordIDListUnitGrid = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1);

// Ask the user for the new word, if this is not a chunk
if(argument_count == 4) {
	// If it is a Chunk, combine the words within the Chunk for the transcript
	var chunkID = argument[3]; 
	var currentChunkRow = chunkID - 1;
	if(currentChunkRow < 0) {
		exit;
	}
	var chunkWordIDList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
	var wordTranscript = "";
	for(var transcriptLoop = 0; transcriptLoop < ds_list_size(chunkWordIDList); transcriptLoop++) {
		var chunkWordID = ds_list_find_value(chunkWordIDList, transcriptLoop);
		var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, chunkWordID - 1);
	
		// Check if the word is a ChunkWord
		if(currentWordState == obj_control.wordStateChunk) {
			continue;
		}
		wordTranscript += (ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, chunkWordID - 1) + " ");
	}
}
// Set the word's token
var wordToken = wordTranscript;

if (string_length(wordTranscript) < 1) {
	exit;
}

obj_control.moveCounter++;

// Set the WordGrid to take in the new word
ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;

var wordID = ds_grid_height(obj_control.wordGrid);
var utteranceID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1);

// Fill in the new row of the WordGrid
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, unitID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, currentRowWordGrid, utteranceID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, wordSeq + 1);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, wordToken);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, wordTranscript);

// Fill in the new row of the DynamicWordGrid
scr_loadDynamicWordGridIndividual(ds_grid_height(obj_control.wordGrid) - 1);

// Designate the new word as a new word or a Chunk word
if(argument_count == 3) {
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, ds_grid_height(obj_control.dynamicWordGrid) - 1, obj_control.wordStateNew);
}
else {
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, ds_grid_height(obj_control.dynamicWordGrid) - 1, obj_control.wordStateChunk);
}

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
if (ds_list_find_index(wordIDListUnitGrid,wordID) != (ds_list_size(wordIDListUnitGrid) - 1) || argument_count == 4) {
	
	// Find the ID of the word in front of the new word
	var prevWordID = ds_list_find_value(wordIDListUnitGrid, ds_list_find_index(wordIDListUnitGrid,wordID) - 1);
	if (prevWordID != undefined) {
		
		// Access the inchunkList from the dynWordGrid
		var prevInChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, prevWordID - 1);
		
		// For each chunk the prev word is in, check if the prev word is not the last word in the chunk
		for(var chunkListLoop = 0; chunkListLoop < ds_list_size(prevInChunkList); chunkListLoop++) {

			
			var currentChunkID = ds_list_find_value(prevInChunkList, chunkListLoop);
			var currentChunkRow = currentChunkID - 1;
			if(currentChunkRow < 0) {
				exit;
			}
			var currentChunkWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
			var newWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, wordID - 1);

			// Allow nesting chunks to be apended
			if(newWordState == obj_control.wordStateChunk || ds_list_find_index(currentChunkWordList, prevWordID) != (ds_list_size(currentChunkWordList) - 1)) {

				// Insert new word into that chunk list, and add to the new word's inChunkList
				ds_list_insert(currentChunkWordList, ds_list_find_index(currentChunkWordList, prevWordID) + 1, wordID);
				ds_list_add(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, wordID - 1), currentChunkID);
			}
		}
	}
}

// If the filter is active, refresh the FilterGrid to contain the newWord
if(obj_control.filterGridActive) {
	obj_toolPane.newWordInFilter = true;
	with (obj_control) {
		scr_renderFilter();
	}
}