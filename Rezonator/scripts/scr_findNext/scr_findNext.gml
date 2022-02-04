

function scr_findNext(givenTokenID, previous){
	var newTokenID = "";
	
	if(scr_isNumericAndExists( global.searchMap, ds_type_map)){
		// get the search list & make sure it exists
		var searchSubMap = global.searchMap[? obj_panelPane.functionSearchList_searchSelected];
		if (scr_isNumericAndExists(searchSubMap, ds_type_map)) {
			

			var tokenDisplayList = searchSubMap[?"displayTokenList"];
			var tokenDisplayListSize = ds_list_size(tokenDisplayList);
	

			
			var givenTokenIndex = ds_list_find_index(tokenDisplayList, givenTokenID);
			
			if(previous){
				if( givenTokenIndex > 0 ){
					newTokenID = tokenDisplayList[|givenTokenIndex-1];
				}
				else{
					newTokenID = tokenDisplayList[|tokenDisplayListSize-1];
				}
			}
			else{
				if( givenTokenIndex < tokenDisplayListSize-1 ){
					newTokenID = tokenDisplayList[|givenTokenIndex+1];
				}
				else{
					newTokenID = tokenDisplayList[|0];
				}
			}
			
		}
	}
	
	
	
	return newTokenID
}