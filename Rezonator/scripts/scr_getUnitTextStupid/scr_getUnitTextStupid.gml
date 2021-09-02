// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getUnitTextStupid(unitSubMap){
	
	// get entryList for this unit
	var unitText = "";
	var entryList = unitSubMap[? "entryList"];
	if(!scr_isNumericAndExists(entryList, ds_type_list)){return "";}
	var entryListSize = ds_list_size(entryList);
	var i = (obj_control.drawLineState == obj_control.lineState_ltr)? 0 : entryListSize-2;
	
	var repeatAmount = entryListSize - 1
	repeat (repeatAmount) {
		
		// get display string for this token
		var currentEntry = entryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentTagMap = currentTokenSubMap[? "tagMap"];
		var currentDisplayStr = string(currentTagMap[? global.displayTokenField]);
				
		// concatenate the UnitText string
		unitText += scr_adaptFont(currentDisplayStr, "M");
		
		if(obj_control.drawLineState == obj_control.lineState_ltr){ i++; }
		else{i--;}
	}
	
	var width = string_width(unitText) + (string_width(" ") * (proseSpaceHorizontal/10) * repeatAmount);
	
	return width;
}