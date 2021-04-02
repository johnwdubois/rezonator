function scr_searchForWord(strToFind) {
	/*
		scr_searchForWord();
	
		Last Updated: 2019-06-24
	
		Called from: obj_chain
	
		Purpose: search entire wordGrid for given word, then create a new lineGrid that features every line containing that word
	
		Mechanism: loop through unitGrid looking at every tempWordIDList for searched word, if that row in unitGrid contains searched word,
					add that row to new lineGrid
	
		Author: Terry DuBois, Georgio Klironomos, Brady Moore
	*/
	
	show_debug_message("scr_searchForWord() ... strToFind: " + string(strToFind));

	// Safety check, make sure something was inputted
	if (string_length(strToFind) < 1) {
		exit;
	}

	// Fill backup grids in case the new word is not found
	var oldSearch = ds_grid_create(ds_grid_width(obj_control.searchGrid), ds_grid_height(obj_control.searchGrid));
	ds_grid_copy(oldSearch, obj_control.searchGrid);
	var oldHit = ds_grid_create(ds_grid_width(obj_control.hitGrid), ds_grid_height(obj_control.hitGrid));
	ds_grid_copy(oldHit, obj_control.hitGrid);

	// creating list of words if user inputed multiple words
	obj_control.listOfWords = ds_list_create();
	var listOfWordsInput = scr_splitString(strToFind, "&");
	ds_list_copy(obj_control.listOfWords, listOfWordsInput);
	ds_list_destroy(listOfWordsInput);

	// if user input regEx string
	obj_control.RegEx = ds_list_create();

	var regExString = "(\@)*";// "(^|\[)\\+(\\0-9|\@)*\\+(^|\])";// "(\\0-9|\@|\[|\])*"; //finds laughter
	//var regExString = "(\\a-z|\\A-Z)*"; //finds all words  "(\a-z|\A-Z|\0-9|_|.|-)*"
	ds_list_copy(obj_control.RegEx,  scr_regularExpressionCreate( regExString ) ); //"(^|\[)\\+(\0-9|\@)*\\+(^|\])"  "(\@)*"
		
	if (!is_string(scr_regularExpressionCreate(strToFind)) && obj_control.regExCheck) {
		ds_list_copy(obj_control.RegEx, scr_regularExpressionCreate(strToFind));
	}
	else {
		if (obj_control.regExCheck) {
			show_message(scr_regularExpressionCreate(strToFind));
		}
	}

	// display RegEx in debug
	//		obj_control.moveCounter = scr_regularExpressionCreate( regExString) ;
	if (is_string(scr_regularExpressionCreate(strToFind))) {
		obj_control.regExCheck = false;
	}

	// create new searchGrid so we can populate it from scratch
	ds_grid_destroy(obj_control.searchGrid);
	obj_control.searchGrid = ds_grid_create(ds_grid_width(obj_control.lineGrid), 0);
	ds_grid_destroy(obj_control.hitGrid);
	obj_control.hitGrid = ds_grid_create(obj_control.hitGridWidth, 0);

	obj_control.hitIDCounter = 1;
	

	// determine if there is a match in the currentFocusedChain
	var tempWordIDList = -1;
	var tempWordIDListSize = 0;
	var inChainMatchCaseSensitive = false;
	var inChainMatchNonCaseSensitive = false;
	
	// make a list of wordIDs from the currently focused chain
	// and if there is no currently focused chain, the list will be empty
	var focusedChainWordIDList = ds_list_create();
	if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID) && obj_chain.currentFocusedChainID != "") {
		ds_list_copy(focusedChainWordIDList, scr_getChainTempList(obj_chain.currentFocusedChainID, false));
	}
	
	// loop through unitGrid, so we can get the wordID list of every unit
	var unitGridHeight = ds_grid_height(obj_control.unitGrid);
	for (var i = 0; i < unitGridHeight; i++) {

		var currentUnitID = i + 1;
		var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, i);
		var currentDiscoID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, i);
		var currentUtteranceID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, i);
		var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, i);
		var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, i);
			
		// now we loop through every word in wordID list to see if matches our search word
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize; j++) {
			
			var currentWordID = ds_list_find_value(currentWordIDList, j);			
			var currentWordDisplayStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1);
			var currentWordMatches = false;
			
			// if we only care about the words in the focused chain, we will make sure currentWordID is in the chain before doing any string checks
			if (obj_control.inChainBool) {
				var currentWordInFocusedChain = (ds_list_find_index(focusedChainWordIDList, currentWordID) >= 0);
				if (!currentWordInFocusedChain) {
					continue;
				}
			}
			
			// Prevent the Search from picking up dead words
			var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
			if (currentWordState == obj_control.wordStateDead or currentWordState == obj_control.wordStateChunk) {
				continue;
			}
			
			// remove any newline characters from currentWordDisplayStr (so that the search isn't screwed up)
			currentWordDisplayStr = string_replace(currentWordDisplayStr, "\n", "");
			currentWordDisplayStr = string_replace(currentWordDisplayStr, "\r", "");
			
			// loop through all of the searched words to see if they match currentWordDisplayStr
			var listOfWordsSize = ds_list_size(obj_control.listOfWords);
			for (var k = 0; k < listOfWordsSize; k++) {
				
				strToFind = ds_list_find_value(obj_control.listOfWords, k);
				
				if (obj_control.regExCheck) {
					if (scr_regularExpressionMatch(obj_control.RegEx, currentWordDisplayStr)) {
						currentWordMatches = true;
					}
				}
				else {
					// determine if the current word has a non-regex match, either case-sensitive or non-case-sensitive
					var foundCaseSensitiveMatch = (strToFind == currentWordDisplayStr);
					var foundNonCaseSensitiveMatch = (string_lower(strToFind) == string_lower(currentWordDisplayStr));
					if (obj_control.caseSensitive) {
						if (foundCaseSensitiveMatch) {
							currentWordMatches = true;
						}
					}
					else {
						if (foundCaseSensitiveMatch || foundNonCaseSensitiveMatch) {
							currentWordMatches = true;
						}
					}
				}
			}
			
			// if any of the searched words matches currentWordDisplayStr, we will add this unit to the searchGrid
			if (currentWordMatches) {
				scr_addToSearchGrid(currentUnitID, currentDiscoID, currentUtteranceID, currentUnitStart, currentUnitEnd, currentWordIDList, currentWordID, j, obj_control.hitIDCounter);		
			}
		}
	}
	
	ds_list_destroy(focusedChainWordIDList);
	
	
	
	
	
	if (obj_control.newWordDeleted) {
		exit;
	}

	// check if we actually got any matches (check height of searchGrid)
	if (ds_grid_height(obj_control.searchGrid) > 0) {
	
		// If matches were found, switch the user over to the search view 
		//obj_control.filterGridActive = false;
		obj_control.searchGridActive = true;
		obj_control.clearSearch = false;
		scr_unFocusAllChains();
		obj_control.currentActiveLineGrid = obj_control.searchGrid;
		ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
		ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, 1);
		var currentUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, 0);
		with (obj_panelPane) {
			functionChainList_lineGridRowFocused = 0;
			functionChainContents_BGColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentUnitID - 1);
			functionChainList_currentTab = functionChainList_tabLine;
						
		}
		
		with(obj_control) {
			obj_control.highlightedSearchRow = 0;// Reset the highlight with a new search
		}
		obj_control.scrollPlusYDest = 0;
		obj_control.wordLeftMarginDest = window_get_width() / 2;
		obj_control.moveCounter ++;
		if (obj_control.gridView) {
			obj_control.gridView = false;
		}
	}
	else {
		// If matches weren't found, keep the user's place
		show_message(scr_get_translation("msg_string-notfound"));
		if (ds_grid_height(oldSearch) > 0) {
			ds_grid_copy(obj_control.searchGrid, oldSearch);
			ds_grid_copy( obj_control.hitGrid, oldHit);
			if (obj_control.gridView) {
				obj_control.gridView = false;
			}
		}
		else {
			obj_control.clearSearch = true;
			obj_control.searchGridActive = false;
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
			obj_toolPane.currentMode = obj_toolPane.setModeMain;
			obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;
			obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
			obj_control.wordLeftMarginDest = 170;
			with (obj_alarm) {
				alarm[0] = 5;
			}
		}
	}



}
