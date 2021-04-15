// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getUnitText(unitSubMap){
	
	// get entryList for this unit
	var unitText = "";
	var entryList = unitSubMap[? "entryList"];
	var entryListSize = ds_list_size(entryList);
	var i = 0;
	
	repeat (entryListSize) {
		
		// get display string for this token
		var currentEntry = entryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentTagMap = currentTokenSubMap[? "tagMap"];
		var currentDisplayStr = currentTagMap[? global.displayTokenField];
				
		// concatenate the UnitText string
		if (is_string(currentDisplayStr)) unitText += scr_adaptFont(currentDisplayStr, "M");
		if (i < entryListSize - 1) unitText += " ";
		
		i++;
	}
	
	return unitText;
}