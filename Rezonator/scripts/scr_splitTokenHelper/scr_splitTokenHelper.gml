function scr_splitTokenHelper(inputText){
	
	
	show_debug_message("Reached scr_splitTokenHelper..." + inputText);
	
	var splitField = obj_control.splitTokenField;
	var origTokenID = obj_control.rightClickID;
	var origSubMap = global.nodeMap[?origTokenID];
	var origTagMap = origSubMap[?"tagMap"];
	var beforeVal = obj_control.before;
	obj_control.before = false;
	if(string_count(" ", inputText) > 0){
		var splitIndex = string_pos(" ", inputText);
		if(splitIndex == string_length(inputText) or splitIndex == 0){
			exit;
		}
		var tokenText = string_copy(inputText, splitIndex + 1, string_length(inputText) - splitIndex);
		scr_newToken(tokenText, origTokenID);
		
		
		
		var tokenList = scr_getTokenList();
		var newTokenID = tokenList[| ds_list_find_index(tokenList, origTokenID) + 1];
		var newSubMap = global.nodeMap[? newTokenID];
		var newTagMap = newSubMap[? "tagMap"];
		
		origTagMap[? splitField] = string_copy(origTagMap[? splitField], 1, splitIndex - 1);
		
		
		// create chunk of both tokens
		ds_list_clear(obj_control.inRectTokenIDList);
		ds_list_add(obj_control.inRectTokenIDList, origTokenID, newTokenID);
		ds_list_clear(obj_control.inRectUnitIDList);
		var origUnitID = origSubMap[? "unit"];
		ds_list_add(obj_control.inRectUnitIDList, origUnitID);
		obj_control.mouseoverPanelPane = false;
		scr_createChunk();
	}
	obj_control.before = beforeVal;
}