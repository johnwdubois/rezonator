// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getSearchUnitList(searchTermList){
	
	var searchedTokensList = searchTermList;
	var searchedTokensListSize = ds_list_size(searchedTokensList);
	
	// get list of units to be searched
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	if (!scr_isNumericAndExists(unitList, ds_type_list)) {
		show_debug_message("scr_getSearchUnitList unitList does not exist");
		exit;
	}
	var unitListSize = ds_list_size(unitList);
	
	var searchUnitList = ds_list_create();
	
	
	
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
				
				//reset seached value for all tokens
				currentTokenSubMap[?"searched"] = false;
				
				// get tagmap for this token
				var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
				var currentDisplayStr = currentTokenTagMap[? global.displayTokenField];
				
				// check if this token's display string matches our searched token
				var caseSensitiveMatch = (currentDisplayStr == currentSearchToken && obj_control.caseSensitive);
				var nonCaseSensitiveMatch = (string_lower(currentDisplayStr) == string_lower(currentSearchToken));
				
				if (caseSensitiveMatch || nonCaseSensitiveMatch) {
					scr_addToListOnce(searchUnitList, currentUnit);
					currentTokenSubMap[?"searched"] = true;
				}
			}
		}
	}
	
	
	return searchUnitList;

}