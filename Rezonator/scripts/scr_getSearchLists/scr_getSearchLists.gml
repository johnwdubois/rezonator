// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getSearchLists(searchTermList){
	
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
	
	
	
	
	if(obj_control.regExCheck){
		// if user input regEx string
		obj_control.RegEx = ds_list_create();

		var regExFromString = scr_regularExpressionCreate(searchTermList[|0]);
		if (scr_isNumericAndExists(regExFromString, ds_type_list) && obj_control.regExCheck) {
			ds_list_copy(obj_control.RegEx, scr_regularExpressionCreate(searchTermList[|0]));
		}
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
				var currentDisplayStr = currentTokenTagMap[? global.displayTokenField];
				
				// check if this token's display string matches our searched token
				var caseSensitiveMatch = (currentDisplayStr == currentSearchToken && obj_control.caseSensitive);
				var nonCaseSensitiveMatch = (string_lower(currentDisplayStr) == string_lower(currentSearchToken));
				if(obj_control.caseSensitive){
					if (caseSensitiveMatch) {
						scr_addToListOnce(searchUnitList, currentUnit);
						scr_addToListOnce(searchTokenList, currentToken);
					}
				}
				else if (obj_control.regExCheck) {
					if (scr_isNumericAndExists(obj_control.RegEx, ds_type_list)){
						var regExMatch = (scr_regularExpressionMatch(obj_control.RegEx, currentDisplayStr));
						if(regExMatch){
							scr_addToListOnce(searchUnitList, currentUnit);
							scr_addToListOnce(searchTokenList, currentToken);
						}
					}
				}
				else{
					if(nonCaseSensitiveMatch || caseSensitiveMatch){
						scr_addToListOnce(searchUnitList, currentUnit);
						scr_addToListOnce(searchTokenList, currentToken);
					}
				}
			}
		}
	}
	obj_control.regExCheck = false;
	
	ds_list_add(listOfResultLists,searchUnitList);
	ds_list_add(listOfResultLists,searchTokenList);
	
	return listOfResultLists;

}