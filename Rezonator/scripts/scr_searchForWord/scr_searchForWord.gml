function scr_searchForWord() {
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
	//var firstChar =  string_copy( wordToFind, 0,1);
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
	var unitGridHeight = ds_grid_height(obj_control.unitGrid);
	for (var i = 0; i < unitGridHeight; i++) {
		var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, i);
		var currentDiscoID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, i);
		var currentUtteranceID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, i);
		var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, i);
		var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, i);
	
		if(obj_fileLoader.subLineGridBeginning != undefined) {
			if(obj_fileLoader.subLineGridBeginning > -1) {
				var unitInLineGrid = ds_grid_value_exists(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), i + 1);
				if(not unitInLineGrid) {
					continue;	
				}
			}
		}
			
			// now we loop through every word in wordID list to see if matches our search word
			//var currentWordIDListSize = ds_list_size(currentWordIDList);
			for (var j = 0; j < ds_list_size(currentWordIDList); j++) {
				var currentWordID = ds_list_find_value(currentWordIDList, j);
				if(obj_control.wordView == 2){
					var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView-2);
				}
				else{				
					var colIndex =  ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView-3);
				}

			
				var currentWordToken = ds_grid_get(global.tokenImportGrid, colIndex, currentWordID - 1);
				var currentWordTranscript = ds_grid_get(global.tokenImportGrid, colIndex, currentWordID - 1);
		
				// Prevent the Search from picking up dead words
				var currentWordGridRow = currentWordID - 1;
				var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordGridRow);
				if(currentWordState == obj_control.wordStateDead or currentWordState == obj_control.wordStateChunk) {
		
					continue;
				}
		
				// loop through all words in list
				var listOfWordsSize = ds_list_size(obj_control.listOfWords);
				for (var l = 0; l < listOfWordsSize; l++) {
									
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
		obj_control.clearSearch = false;
		scr_unFocusAllChains();
		obj_control.currentActiveLineGrid = obj_control.searchGrid;
		obj_toolPane.currentMode = obj_toolPane.setModeSearch;
		ds_grid_set_region(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.searchGrid), 0);
		ds_grid_set(obj_control.searchGrid, obj_control.lineGrid_colLineState, 0, 1);
		var currentUnitID = ds_grid_get(obj_control.searchGrid, obj_control.lineGrid_colUnitID, 0);
		with (obj_panelPane) {
			functionChainList_lineGridRowFocused = 0;
			functionChainContents_BGColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentUnitID - 1);
			functionChainList_currentTab = functionChainList_tabLine;
			// Y value not in a grid for read tab, have to store somewhere
			/*for (var i = 0; i < instance_number(obj_panelPane); i++) {
				var currentPane = instance_find(obj_panelPane, i);
				if (currentPane.currentFunction == obj_panelPane.functionChainList) {
					draw_set_font(global.fontChainList);
					var strHeight = string_height("0") * 1.5;
					currentPane.scrollPlusYDest = y + currentPane.functionChainList_tabHeight + currentPane.scrollPlusY + (strHeight * drawLineLoop);
				}
			}*/
						
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
		show_message("Search string not found");
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

	ds_grid_destroy(tempSearchGrid);


}
