// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_splitTokenHelper(inputText){
	show_debug_message("Reached scr_splitTokenHelper..." + inputText);
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
		scr_newToken(tokenText, origTokenID)
		
		
		
		var tokenList = scr_getTokenList();
		var newTokenID = tokenList[|ds_list_find_index(tokenList, origTokenID) + 1];
		var newSubMap = global.nodeMap[?newTokenID];
		var newTagMap = newSubMap[?"tagMap"];
		
		origTagMap[?global.displayTokenField] = string_copy(origTagMap[?global.displayTokenField], 1, splitIndex - 1);
	}
	obj_control.before = beforeVal;
}