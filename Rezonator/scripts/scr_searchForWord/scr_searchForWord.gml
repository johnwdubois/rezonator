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
var tempSearchGrid = ds_grid_create(ds_grid_width(obj_control.lineGrid), ds_grid_height(obj_control.lineGrid));

ds_grid_copy(tempSearchGrid, obj_control.lineGrid);


// Fill backup grids in case the new word is not found
var oldSearch = ds_grid_create(ds_grid_width(obj_control.searchGrid), ds_grid_height(obj_control.searchGrid));
ds_grid_copy(oldSearch, obj_control.searchGrid);
var oldHit = ds_grid_create(ds_grid_width(obj_control.hitGrid), ds_grid_height(obj_control.hitGrid));
ds_grid_copy(oldHit, obj_control.hitGrid);


// creating list of words if user inputed multiple words
obj_control.listOfWords = ds_list_create();
ds_list_copy( obj_control.listOfWords, scr_splitString(wordToFind, "&"));

// if user input regEx string
var firstChar =  string_copy( wordToFind, 0,1);
obj_control.RegEx = ds_list_create();

var regExString = "(\@)*";// "(^|\[)\\+(\\0-9|\@)*\\+(^|\])";// "(\\0-9|\@|\[|\])*"; //finds laughter
//var regExString = "(\\a-z|\\A-Z)*"; //finds all words  "(\a-z|\A-Z|\0-9|_|.|-)*"
ds_list_copy(obj_control.RegEx,  scr_regularExpressionCreate( regExString ) ); //"(^|\[)\\+(\0-9|\@)*\\+(^|\])"  "(\@)*"
		
if (!is_string(scr_regularExpressionCreate(wordToFind)) && obj_control.regExCheck) {
	ds_list_copy(obj_control.RegEx, scr_regularExpressionCreate(wordToFind));
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
ds_grid_destroy(obj_control.searchGrid);
obj_control.searchGrid = ds_grid_create(ds_grid_width(obj_control.lineGrid), 0);
ds_grid_destroy(obj_control.hitGrid);
obj_control.hitGrid = ds_grid_create(obj_control.hitGridWidth, 0);

obj_control.hitIDCounter = 1;

// loop through unitGrid, so we can get the wordID list of every unit
for (var i = 0; i < ds_grid_height(obj_control.unitGrid); i++) {
	var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, i);
	var currentDiscoID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, i);
	var currentUtteranceID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, i);
	var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, i);
	var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, i);
	

			
		// now we loop through every word in wordID list to see if matches our search word
		for (var j = 0; j < ds_list_size(currentWordIDList); j++) {
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
			var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
		
			// Prevent the Search from picking up dead words
			var currentWordGridRow = currentWordID - 1;
			var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordGridRow);
			if(currentWordState == obj_control.wordStateDead) {
		
				continue;
			}
		
			// loop through all words in list
			for (var l = 0; l < ds_list_size(obj_control.listOfWords); l++) {
									
				if !ds_list_empty(obj_control.listOfWords) {
					wordToFind = ds_list_find_value(obj_control.listOfWords, l);
				}
				
				if (obj_control.regExCheck) {
					if (scr_regularExpressionMatch(obj_control.RegEx, currentWordTranscript)) {
					
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
			
				else {
				// if statement for boolean logic and search selection	
				if (obj_control.caseSensitive and not obj_control.transcriptSearch and not obj_control.inChainBool) {
					if (wordToFind == currentWordToken) {
				
							scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and not obj_control.caseSensitive and not obj_control.inChainBool) {
					if (string_lower(wordToFind) == string_lower(currentWordTranscript)) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and obj_control.caseSensitive and not obj_control.inChainBool) {
					if ( wordToFind == currentWordTranscript ) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and obj_control.caseSensitive and obj_control.inChainBool) {
				
					var focusedRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
					var inChain = -10;
					if(focusedRow > -1){
						var chainWordIdList = ds_list_create(); 
						ds_list_copy(chainWordIdList, ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, focusedRow))
						inChain = ds_list_find_index(chainWordIdList, currentWordID);
					}
					
					if ( wordToFind == currentWordTranscript and inChain > -1) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
				else if (not obj_control.transcriptSearch and not obj_control.caseSensitive and obj_control.inChainBool) {
				
					//var inChain = ds_grid_get(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentWordID - 1);
					var focusedRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
					var inChain = -10;
					if(focusedRow > -1){
						var chainWordIdList = ds_list_create(); 
						ds_list_copy(chainWordIdList, ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, focusedRow))
						inChain = ds_list_find_index(chainWordIdList, currentWordID);
					}
				
					if (string_lower(wordToFind) == string_lower(currentWordToken) and inChain > -1 or string_lower(wordToFind) == string_lower(currentWordTranscript) and inChain == 1) {
				
					
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
				else if (obj_control.transcriptSearch and not obj_control.caseSensitive and obj_control.inChainBool) {
				
					var focusedRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
					var inChain = -10;
					if(focusedRow > -1){
						var chainWordIdList = ds_list_create(); 
						ds_list_copy(chainWordIdList, ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, focusedRow))
						inChain = ds_list_find_index(chainWordIdList, currentWordID);
					}
				
					if (string_lower(wordToFind) == string_lower(currentWordTranscript) and inChain > -1) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
				else if (not obj_control.transcriptSearch and obj_control.caseSensitive and obj_control.inChainBool) {
				
					var focusedRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
					var inChain = -10;
					if(focusedRow > -1){
						var chainWordIdList = ds_list_create(); 
						ds_list_copy(chainWordIdList, ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, focusedRow))
						inChain = ds_list_find_index(chainWordIdList, currentWordID);
					}
				
					if (wordToFind == currentWordToken and inChain == 1 or wordToFind == currentWordTranscript and inChain > -1) {
				
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);	

					}
				}
				else{
					// if the word matches, we will add another row to the serachGrid and add all of this word's unit information
					//if (scr_regularExpressionMatch(RegEx, currentWordTranscript)) {
					//if (string_lower(wordToFind) == string_lower(currentWordToken) or string_lower(wordToFind) == string_lower(currentWordTranscript) or scr_regularExpressionMatch(RegEx, currentWordTranscript)) {
					if (string_lower(wordToFind) == string_lower(currentWordToken) or string_lower(wordToFind) == string_lower(currentWordTranscript) ) {
					
						scr_addToSearchGrid(i, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		

					}
				}
			}
		}
	}
}

if(obj_control.newWordDeleted) {
	exit;
}

// check if we actually got any matches (check height of searchGrid)
if (ds_grid_height(obj_control.searchGrid) > 0) {
	
	// If matches were found, switch the user over to the search view 
	obj_control.filterGridActive = false;
	obj_control.searchGridActive = true;
	scr_unFocusAllChains();
	with(obj_control) {
		obj_control.highlightedSearchRow = 0;// Reset the highlight with a new search
	}
	obj_control.currentActiveLineGrid = obj_control.searchGrid;
	obj_control.scrollPlusYDest = 0;
	obj_control.wordLeftMarginDest = window_get_width() / 2;
	obj_control.moveCounter ++;
}
else {
	// If matches weren't found, keep the user's place
	show_message("Search string not found");
	if (ds_grid_height(oldSearch) > 0) {
		ds_grid_copy(obj_control.searchGrid, oldSearch);
		ds_grid_copy( obj_control.hitGrid, oldHit);
	}
	else {
		obj_control.searchGridActive = false;
		obj_control.filterGridActive = false;
		obj_control.currentActiveLineGrid = obj_control.lineGrid;
		obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;
		obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
		obj_control.wordLeftMarginDest = 170;
	}
}

ds_grid_destroy(tempSearchGrid);