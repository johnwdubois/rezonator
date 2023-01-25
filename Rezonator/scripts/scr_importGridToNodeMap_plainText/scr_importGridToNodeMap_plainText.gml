

function scr_importGridToNodeMap_plainText(row) {

	// make sure row is still in range
	if (row >= importGridHeight) exit;
	
	// get unit string and split it
	var unitStr = ds_grid_get(global.importGrid, 0, row);
	var splitList = scr_splitStringImport(unitStr, " ", true);

	show_debug_message(scr_getStringOfList(splitList))
	scr_deleteFromList(splitList, "");
	scr_deleteFromList(splitList, " ");
	scr_deleteFromList(splitList, "\r");
	scr_deleteFromList(splitList, "\n");
	scr_deleteFromList(splitList, "\r\n");
	show_debug_message(scr_getStringOfList(splitList))
	
	// make a new unit node for this row
	var unitNode = scr_addToNodeMap("unit");
	var unitSubMap = global.nodeMap[? unitNode];
	ds_list_add(unitList, unitNode);
	
	var unitFieldMap = global.nodeMap[? "unitTagMap"];
	var tokenFieldMap = global.nodeMap[? "tokenTagMap"];
	if (row == 0) {
		
		var newUnitFieldMap = ds_map_create();
		ds_map_add_map(unitFieldMap, "~unitStr", newUnitFieldMap);
		ds_map_add_list(newUnitFieldMap, "tagSet", ds_list_create());
		ds_list_add(global.unitFieldList, "~unitStr");
		
		var newTokenFieldMap = ds_map_create();
		ds_map_add_map(tokenFieldMap, "~text", newTokenFieldMap);
		ds_map_add_list(newTokenFieldMap, "tagSet", ds_list_create());
		var targetList = ds_list_create();
		ds_map_add_list(newTokenFieldMap, "targetList", targetList);
		ds_list_add(targetList, "token", "chunk");
		global.displayTokenField = "~text";
		ds_list_add(global.tokenFieldList, "~text");
		
	}
	var entryList = ds_list_create();
	if (scr_isNumericAndExists(splitList, ds_type_list)) {
		var splitListSize = ds_list_size(splitList);
		for (var i = 0; i < splitListSize; i++) {
			
			// make token node
			var currentTokenOrder = i + 1;
			var currentTokenNode = scr_addToNodeMap("token");
			var currentTokenSubMap = global.nodeMap[? currentTokenNode];
			ds_map_add(currentTokenSubMap, "docTokenSeq", ds_list_size(tokenList) + 1);
			ds_map_add(currentTokenSubMap, "tokenOrder", currentTokenOrder);
			ds_map_add(currentTokenSubMap, "relativeOrder", currentTokenOrder);
			ds_map_add(currentTokenSubMap, "place", currentTokenOrder);
			ds_map_add(currentTokenSubMap, "displayCol", i);
			ds_map_add(currentTokenSubMap, "void", 1);
			ds_map_add(currentTokenSubMap, "pixelX", 0);
			ds_map_add(currentTokenSubMap, "searched", false);
			ds_map_add(currentTokenSubMap, "unit", unitNode);
			ds_map_add(currentTokenSubMap, "doc", global.discourseNode);
			ds_map_add_list(currentTokenSubMap, "inChainsList", ds_list_create());
			ds_map_add_list(currentTokenSubMap, "inChunkList", ds_list_create());
			ds_map_add_list(currentTokenSubMap, "inEntryList", ds_list_create());
			
			// make tag map for token
			var currentTokenTagMap = ds_map_create();
			ds_map_add_map(currentTokenSubMap, "tagMap", currentTokenTagMap);
			var currentTag = splitList[| i];
			currentTag = string_replace_all(currentTag, "\r", "");
			currentTag = string_replace_all(currentTag, "\n", "");
			ds_map_add(currentTokenTagMap, "~text", currentTag);
			scr_addAutoTag("~text", currentTag, tokenFieldMap);
			
			//check if token is rtl
			if (!global.RTLFound) {
				global.RTLFound = scr_isStrRTL(splitList[| i]);
			}
			
			//add each token to the total token's List
			ds_list_add(tokenList, currentTokenNode);
				
			// make entry node
			var currentEntryNode = scr_addToNodeMap("entry");
			var currentEntrySubMap = global.nodeMap[? currentEntryNode];
			ds_map_add(currentEntrySubMap, "token", currentTokenNode);
			ds_map_add(currentEntrySubMap, "unit", unitNode);
				
			ds_list_add(entryList, currentEntryNode);
		}
	}
	
	// make tag map for unit
	var unitTagMap = ds_map_create();
	ds_map_add_map(unitSubMap, "tagMap", unitTagMap);
	ds_map_add(unitTagMap, "~unitStr", unitStr);
	
	// add values to unit node
	ds_map_add(unitSubMap, "unitSeq", importGridRow + 1);
	ds_map_add_list(unitSubMap, "entryList", entryList);
	ds_map_add_list(unitSubMap, "inChainsList", ds_list_create());
	ds_map_add(unitSubMap, "pixelY", 0);
	ds_map_add(unitSubMap, "filter", false);
	ds_map_add(unitSubMap, "active", true);
	ds_map_add(unitSubMap, "doc", global.discourseNode);
	ds_map_add(unitSubMap, "participantID", "0");
	if (!ds_map_exists(unitSubMap, "unitStart")) ds_map_add(unitSubMap, "unitStart", "");
	if (!ds_map_exists(unitSubMap, "unitEnd")) ds_map_add(unitSubMap, "unitEnd", "");
	
	ds_list_destroy(splitList);
	


	importGridRow++;
}