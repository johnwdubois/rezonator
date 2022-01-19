

function scr_refreshDisplayColUnit(unitID){
	

	var startJustify = scr_checkNativeJustification();
	var maxColsOnScreen = scr_getMaxColsOnScreen();
	
	var unitSubMap = global.nodeMap[? unitID];
	if (!scr_isNumericAndExists(unitSubMap, ds_type_map)) exit;
	var currentEntryList = unitSubMap[? "entryList"];
	if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) exit;
	var currentEntryListSize = ds_list_size(currentEntryList);
	
	for (var i = 0; i < currentEntryListSize; i++) {
		var currentEntry = currentEntryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
			

		var currentDisplayCol = 0;
		if (startJustify) {
			currentDisplayCol = i;
		}
		else {
			currentDisplayCol = maxColsOnScreen - currentEntryListSize + i - 1;
		}
		currentTokenSubMap[? "displayCol"] = currentDisplayCol;
	}

}