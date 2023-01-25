

function scr_createTokenNode(discourseTokenSeq, textToDisplay, newTokenSeq, newDisplayCol, unitID) {
	// make token node
	var currentTokenNode = scr_addToNodeMap("token");
	var currentTokenSubMap = global.nodeMap[? currentTokenNode];
	ds_map_add(currentTokenSubMap, "docTokenSeq", discourseTokenSeq);
	ds_map_add(currentTokenSubMap, "tokenOrder", newTokenSeq);
	ds_map_add(currentTokenSubMap, "relativeOrder", newTokenSeq);
	ds_map_add(currentTokenSubMap, "place", "N/A");
	ds_map_add(currentTokenSubMap, "displayCol", newDisplayCol);
	ds_map_add(currentTokenSubMap, "void", 1);
	ds_map_add(currentTokenSubMap, "pixelX", 0);
	ds_map_add(currentTokenSubMap, "searched", false);
	ds_map_add(currentTokenSubMap, "unit", unitID);
	ds_map_add(currentTokenSubMap, "doc", global.discourseNode);
	ds_map_add_list(currentTokenSubMap, "inChainsList", ds_list_create());
	ds_map_add_list(currentTokenSubMap, "inChunkList", ds_list_create());
	ds_map_add_list(currentTokenSubMap, "inEntryList", ds_list_create());
				
	// make tag map for token & copy tags from tokenImportGrid
	var tagMap = ds_map_create();
	ds_map_add_map(currentTokenSubMap, "tagMap", tagMap);
	var tokenImportColNameListSize = ds_list_size(obj_control.tokenFieldList);
	for (var i = 0; i < tokenImportColNameListSize; i++) {
		var currentField = string(obj_control.tokenFieldList[| i]);
		var currentTag = "";
		
		if (obj_control.splitToken) {
			if (currentField == obj_control.splitTokenField) {
				currentTag = textToDisplay
			}
			else if (obj_control.splitTokenCopyTags) {
				var rightClickTokenSubMap = global.nodeMap[? obj_control.rightClickID];
				var rightClickTokenTagMap = rightClickTokenSubMap[? "tagMap"];
				
				currentTag = rightClickTokenTagMap[? currentField];
			}
		}
		else {
			if (currentField == global.displayTokenField) {
				currentTag = textToDisplay
			}
		}
		
		ds_map_add(tagMap, currentField, currentTag);
	}
		
	return currentTokenNode;
}