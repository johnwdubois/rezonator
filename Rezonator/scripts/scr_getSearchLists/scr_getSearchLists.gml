

function scr_getSearchLists(searchTermList) {
	
	var listOfResultLists = ds_list_create();
	
	var searchedTokensList = searchTermList;
	var searchedTokensListSize = ds_list_size(searchedTokensList);
	
	// get list of units to be searched
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	if (!scr_isNumericAndExists(unitList, ds_type_list)) {
		show_debug_message("scr_getSearchLists unitList does not exist");
		exit;
	}
	var unitListSize = ds_list_size(unitList);
	
	var searchUnitList = ds_list_create();
	var searchTokenList = ds_list_create();
	
	
	
	
	if (obj_control.regExCheck) {
		// if user input regEx string
		obj_control.RegEx = ds_list_create();

		var regExFromString = scr_regularExpressionCreate(searchTermList[|0]);
		if (scr_isNumericAndExists(regExFromString, ds_type_list) && obj_control.regExCheck) {
			ds_list_copy(obj_control.RegEx, scr_regularExpressionCreate(searchTermList[|0]));
		}
	}
	
	show_debug_message(string(obj_chain.currentFocusedChainID))
	
	var focusedChainTokenIDList = ds_list_create();
	var trackChainTokenIDList = ds_list_create();
	var rezChainTokenIDList = ds_list_create();
	var stackChainTokenIDList = ds_list_create();
	var chainTokenIDList = ds_list_create();
	
	if (obj_control.searchRange == "option_current-chain") {
		focusedChainTokenIDList = scr_getTokensOfChain(obj_chain.currentFocusedChainID);
	}
	else if (obj_control.searchRange != "option_current-chain" && obj_control.searchRange != "option_doc") {
		
		var listOfChains = "";
		if (obj_control.searchRange == "menu_stacks_pl") {
			listOfChains = global.nodeMap[? "stackList"];
			var listToAddTo = stackChainTokenIDList;
		}
		else if (obj_control.searchRange == "menu_rez_chains_pl") {
			listOfChains = global.nodeMap[? "resonanceList"];
			var listToAddTo = rezChainTokenIDList;
		}
		else if (obj_control.searchRange == "option_trails") {
			listOfChains = global.nodeMap[? "trailList"];
			var listToAddTo = trackChainTokenIDList;
		}
		else {
			show_debug_message("NO RANGE GIVEN")
			listOfChains = global.nodeMap[? "resonanceList"];
			var listToAddTo = rezChainTokenIDList;
		}
		
		var chainListSize = ds_list_size(listOfChains);
		for (var i = 0 ; i < chainListSize; i++) {
			var currentTokenList = scr_getTokensOfChain(listOfChains[| i]);
			var tokenListSize = ds_list_size(currentTokenList);
			for (var j = 0 ; j < tokenListSize; j++) {
				ds_list_add(listToAddTo,currentTokenList[| j]);
			}	
			
		}
		show_debug_message(scr_getStringOfList(rezChainTokenIDList));
	}

	

	
	for (var i = 0; i < searchedTokensListSize; i++) {
		
		var currentSearchToken = searchedTokensList[| i];
		
		// loop over units & tokens to find tokens that match the search
		for (var j = 0; j < unitListSize; j++) {
			
			var currentUnit = unitList[| j];
			var currentUnitSubMap = global.nodeMap[? currentUnit];
			var entryList = currentUnitSubMap[? "entryList"];
			var entryListSize = ds_list_size(entryList);
			

			// loop over the entries for this unit and check their tokens
			for (var k = 0; k < entryListSize; k++) {
				
				// get token for this entry
				var currentEntry = entryList[| k];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				var currentToken = currentEntrySubMap[? "token"];
				var currentTokenSubMap = global.nodeMap[? currentToken];
				
				
				// get tagmap for this token
				var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
				var currentDisplayStr = currentTokenTagMap[? obj_control.searchField];
				
				// check if this token's display string matches our searched token
				var caseSensitiveMatch = (currentDisplayStr == currentSearchToken);
				var nonCaseSensitiveMatch = (string_lower(currentDisplayStr) == string_lower(currentSearchToken));


				// check for current chain range
				if (obj_control.searchRange != "option_doc") {
					
					if (obj_control.searchRange == "menu_stacks_pl") {
						ds_list_copy(chainTokenIDList, stackChainTokenIDList);
					}
					else if (obj_control.searchRange == "menu_rez_chains_pl") {
						ds_list_copy(chainTokenIDList, rezChainTokenIDList);
					}
					else if (obj_control.searchRange == "option_trails") {
						ds_list_copy(chainTokenIDList, trackChainTokenIDList);
					}
					else if (obj_control.searchRange == "option_current-chain") {
						ds_list_copy(chainTokenIDList, focusedChainTokenIDList);
					}
					
					
					if (scr_isNumericAndExists(chainTokenIDList, ds_type_list)) {
						var inChainMatch = (ds_list_find_index(chainTokenIDList, currentToken) >= 0)
						if (inChainMatch) {
							// reg ex check
							if (obj_control.regExCheck) {
								if (scr_isNumericAndExists(obj_control.RegEx, ds_type_list)) {
									var regExMatch = (scr_regularExpressionMatch(obj_control.RegEx, currentDisplayStr));
									if (regExMatch) {
										scr_addToListOnce(searchUnitList, currentUnit);
										scr_addToListOnce(searchTokenList, currentToken);
									}
								}
							}
							else if (obj_control.caseSensitive) {
								if (caseSensitiveMatch) {
									scr_addToListOnce(searchUnitList, currentUnit);
									scr_addToListOnce(searchTokenList, currentToken);
								}
							}
							else {
								if (nonCaseSensitiveMatch) {
									scr_addToListOnce(searchUnitList, currentUnit);
									scr_addToListOnce(searchTokenList, currentToken);
								}
							}
						}
					}	
				}
				// Doc search
				else {
					// reg ex check
					if (obj_control.regExCheck) {
						if (scr_isNumericAndExists(obj_control.RegEx, ds_type_list)) {
							var regExMatch = (scr_regularExpressionMatch(obj_control.RegEx, currentDisplayStr));
							if (regExMatch) {
								scr_addToListOnce(searchUnitList, currentUnit);
								scr_addToListOnce(searchTokenList, currentToken);
							}
						}
					}

					// case sensitive check
					else if (obj_control.caseSensitive) { 
						if (caseSensitiveMatch) {
							scr_addToListOnce(searchUnitList, currentUnit);
							scr_addToListOnce(searchTokenList, currentToken);
						}
					}
					else if (nonCaseSensitiveMatch || caseSensitiveMatch) {
						scr_addToListOnce(searchUnitList, currentUnit);
						scr_addToListOnce(searchTokenList, currentToken);
					}
				}
			}
		}
	}


	
	ds_list_add(listOfResultLists,searchUnitList);
	ds_list_add(listOfResultLists,searchTokenList);

	scr_sortSearchLists(listOfResultLists);
	
	return listOfResultLists;

}