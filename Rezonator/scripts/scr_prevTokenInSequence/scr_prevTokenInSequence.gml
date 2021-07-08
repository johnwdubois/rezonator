/*
	Purpose: return the previous word within the word sequence
*/
function scr_prevTokenInSequence(tokenID) {
	
	// get token submap and make sure it exists
	var tokenSubMap = global.nodeMap[? tokenID];
	if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) return "";
	
	// get token's unit
	var unitID = tokenSubMap[? "unit"];
	
	// get discourseTokenSeq and discourse tokenList
	var discourseTokenSeq = tokenSubMap[? "discourseTokenSeq"];
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var discourseTokenList = discourseSubMap[? "tokenList"];
	
	// get previous token
	if (scr_checkNativeJustification()) {
		if (discourseTokenSeq > 0) {
		
			// go back one step in discourseTokenList, and then check if that token is in the same unit
			// we go -2 because discourseTokenSeq is 1-indexed
			var previousTokenID = discourseTokenList[| discourseTokenSeq - 2];
			var previousTokenSubMap = global.nodeMap[? previousTokenID];
			if (scr_isNumericAndExists(previousTokenSubMap, ds_type_map)) {
				var previousUnitID = previousTokenSubMap[? "unit"];
				return (previousUnitID == unitID) ? previousTokenID : "";
			}
		}
	}
	else {
		if (discourseTokenSeq < ds_list_size(discourseTokenList) - 1) {
		
			// go back one step in discourseTokenList, and then check if that token is in the same unit
			var previousTokenID = discourseTokenList[| discourseTokenSeq];
			var previousTokenSubMap = global.nodeMap[? previousTokenID];
			if (scr_isNumericAndExists(previousTokenSubMap, ds_type_map)) {
				var previousUnitID = previousTokenSubMap[? "unit"];
				return (previousUnitID == unitID) ? previousTokenID : "";
			}
		}
	}
	
	
	// if could not find anything, return blank string
	return "";

}
