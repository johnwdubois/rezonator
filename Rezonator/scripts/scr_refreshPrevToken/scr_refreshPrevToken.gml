

function scr_refreshPrevToken() {
	
	// recalculate prevToken for all tokens
	var docSubMap = global.nodeMap[? global.discourseNode];
	var tokenList = docSubMap[? "tokenList"];
	if (scr_isNumericAndExists(tokenList, ds_type_list)) {
		var tokenListSize = ds_list_size(tokenList);
		for (var i = 0; i < tokenListSize; i++) {
			var currentToken = tokenList[| i];
			var currentTokenSubMap = global.nodeMap[? currentToken];
			if (scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) {
				if (ds_map_exists(currentTokenSubMap, "prevToken")) {
					ds_map_delete(currentTokenSubMap, "prevToken");
				}
			}
		}
	}
	
}