/*
	scr_searchForWord();
	
	Last Updated: 2019-06-24
	
	Called from: obj_chain
	
	Purpose: search entire wordGrid for given word, then create a new lineGrid that features every line containing that word
	
	Mechanism: loop through unitGrid looking at every wordIDList for searched word, if that row in unitGrid contains searched word,
				add that row to new lineGrid
	
	Author: Terry DuBois, Georgio Klironomos, Brady Moore
*/

var wordToFind = argument[0];

// Get the word's string from the user
//var wordToFind = get_string("Type string to find", "");

// Safety check, make sure something was inputted
if (string_length(wordToFind) < 1) {
	exit;
}


// Keep a temporary grid
var tempSearchGrid = ds_grid_create(ds_grid_width(lineGrid), ds_grid_height(lineGrid));

ds_grid_copy(tempSearchGrid, lineGrid);


// Fill backup grids in case the new word is not found
var oldSearch = ds_grid_create(ds_grid_width(searchGrid), ds_grid_height(searchGrid));
ds_grid_copy(oldSearch, searchGrid);
var oldHit = ds_grid_create(ds_grid_width(hitGrid), ds_grid_height(hitGrid));
ds_grid_copy(oldHit, hitGrid);


// creating list of words if user inputed multiple words
listOfWords = ds_list_create();
ds_list_copy( listOfWords, scr_splitString(wordToFind, "&"));

// if user input regEx string
var firstChar =  string_copy( wordToFind, 0,1);
RegEx = ds_list_create();

var regExString = "(\@)*";// "(^|\[)\\+(\\0-9|\@)*\\+(^|\])";// "(\\0-9|\@|\[|\])*"; //finds laughter
//var regExString = "(\\a-z|\\A-Z)*"; //finds all words  "(\a-z|\A-Z|\0-9|_|.|-)*"
ds_list_copy(RegEx,  scr_regularExpressionCreate( regExString ) ); //"(^|\[)\\+(\0-9|\@)*\\+(^|\])"  "(\@)*"
		
if (!is_string(scr_regularExpressionCreate(wordToFind)) && obj_control.regExCheck) {
	ds_list_copy(RegEx, scr_regularExpressionCreate(wordToFind));
}
else {
	if(obj_control.regExCheck) {
		show_message(scr_regularExpressionCreate(wordToFind));
	}
}

// display RegEx in debug
//		obj_control.moveCounter = scr_regularExpressionCreate( regExString) ;
if(is_string(scr_regularExpressionCreate(wordToFind))){
obj_control.regExCheck = false;
}

// create new searchGrid so we can populate it from scratch
ds_grid_destroy(searchGrid);
searchGrid = ds_grid_create(ds_grid_width(lineGrid), 0);
ds_grid_destroy(hitGrid);
hitGrid = ds_grid_create(hitGridWidth, 0);

hitIDCounter = 1;

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
		
			// loop through all words in list
			for (var l = 0; l < ds_list_size(listOfWords); l++) {
									
				if !ds_list_empty(listOfWords) {
					wordToFind = ds_list_find_value(listOfWords, l);
			}
				
			if (obj_control.regExCheck) {
				if (scr_regularExpressionMatch(RegEx, currentWordTranscript)) {
					
					scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

				}
			}
			
			else {
				// if statement for boolean logic and search selection	
				if (obj_control.caseSensitive and not obj_control.transcriptSearch and not obj_control.inChainBool) {
					if (wordToFind == currentWordToken) {
				
							scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and not obj_control.caseSensitive and not obj_control.inChainBool) {
					if (string_lower(wordToFind) == string_lower(currentWordTranscript)) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and obj_control.caseSensitive and not obj_control.inChainBool) {
					if ( wordToFind == currentWordTranscript ) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and obj_control.caseSensitive and obj_control.inChainBool) {
				
				var inChain = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
					
					if ( wordToFind == currentWordTranscript and inChain == 1) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

					}
				}
				else if (not obj_control.transcriptSearch and not obj_control.caseSensitive and obj_control.inChainBool) {
				
					var inChain = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
				
					if (string_lower(wordToFind) == string_lower(currentWordToken) and inChain == 1 or string_lower(wordToFind) == string_lower(currentWordTranscript) and inChain == 1) {
				
					
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and not obj_control.caseSensitive and obj_control.inChainBool) {
				
					var inChain = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
				
					if (string_lower(wordToFind) == string_lower(currentWordTranscript) and inChain == 1) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

					}
				}
				else if (not obj_control.transcriptSearch and obj_control.caseSensitive and obj_control.inChainBool) {
				
					var inChain = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
				
					if (wordToFind == currentWordToken and inChain == 1 or wordToFind == currentWordTranscript and inChain == 1) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);	

					}
				}
				else{
					// if the word matches, we will add another row to the serachGrid and add all of this word's unit information
					//if (scr_regularExpressionMatch(RegEx, currentWordTranscript)) {
					//if (string_lower(wordToFind) == string_lower(currentWordToken) or string_lower(wordToFind) == string_lower(currentWordTranscript) or scr_regularExpressionMatch(RegEx, currentWordTranscript)) {
					if (string_lower(wordToFind) == string_lower(currentWordToken) or string_lower(wordToFind) == string_lower(currentWordTranscript) ) {
					
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, hitIDCounter);		

					}
				}
			}
		}
	}
}

// check if we actually got any matches (check height of searchGrid)
if (ds_grid_height(searchGrid) > 0) {
	
	// If matches were found, switch the user over to the search view 
	filterGridActive = false;
	searchGridActive = true;
	scr_unFocusAllChains();
	with(obj_control) {
		highlightedSearchRow = 0;// Reset the highlight with a new search
	}
	currentActiveLineGrid = searchGrid;
	currentCenterDisplayRow = 0;
	wordLeftMarginDest = window_get_width() / 2;
	moveCounter ++;
}
else {
	// If matches weren't found, keep the user's place
	show_message("Search string not found");
	if (ds_grid_height(oldSearch) > 0) {
		ds_grid_copy(searchGrid, oldSearch);
		ds_grid_copy( hitGrid, oldHit);
	}
	else {
		searchGridActive = false;
		filterGridActive = false;
		currentActiveLineGrid = lineGrid;
		preSwitchSearchDisplayRow = currentCenterDisplayRow;
		currentCenterDisplayRow = preSwitchDisplayRow;
		wordLeftMarginDest = 170;
	}
}

ds_grid_destroy(tempSearchGrid);