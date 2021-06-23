// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_importGridToNodeMap_fieldsRowUnit(row){




	// make sure row is still in range
	if (row >= importGridHeight) exit;
	
	
	var entryList = ds_list_create();
	
	// make a new unit node for this row
	var unitNode = scr_addToNodeMap("unit");
	var unitSubMap = global.nodeMap[? unitNode];
	ds_list_add(unitList, unitNode);
	
	// make tag map for unit
	var unitTagMap = ds_map_create();
	ds_map_add_map(unitSubMap, "tagMap", unitTagMap);
	
	// add values to unit node
	ds_map_add(unitSubMap, "unitSeq", importGridRow + 1);
	ds_map_add_list(unitSubMap, "entryList", entryList);
	ds_map_add_list(unitSubMap, "inChainsList", ds_list_create());
	ds_map_add(unitSubMap, "pixelY", 0);
	ds_map_add(unitSubMap, "pID", 0);
	ds_map_add(unitSubMap, "speakerColor", 0);
	ds_map_add(unitSubMap, "filter", false);
	ds_map_add(unitSubMap, "active", true);
	if (!ds_map_exists(unitSubMap, "unitStart")) ds_map_add(unitSubMap, "unitStart", "");
	if (!ds_map_exists(unitSubMap, "unitEnd")) ds_map_add(unitSubMap, "unitEnd", "");

	if(row == 0){
		var unitFieldMap = global.nodeMap[?"unitTagMap"];
		var newUnitFieldMap = ds_map_create();
		ds_map_add_map(unitFieldMap, "unitStr", newUnitFieldMap);
		ds_map_add_list(newUnitFieldMap, "tagSet", ds_list_create());
		for(var i = 0 ; i < ds_list_size(global.importGridColNameList); i++){
			var fieldName = ds_list_find_index(global.importGridColNameList, i);
			if(ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLevel,fieldName) == "unit"){
				ds_list_add(global.unitFieldList, ds_list_find_value(global.importGridColNameList, i));
			}
		}
		
		var tokenFieldMap = global.nodeMap[?"tokenTagMap"];
		var newTokenFieldMap = ds_map_create();
		ds_map_add_map(tokenFieldMap, "~text", newTokenFieldMap);
		ds_map_add_list(newTokenFieldMap, "tagSet", ds_list_create());
		for(var i = 0 ; i < ds_list_size(global.importGridColNameList); i++){
			var fieldName = ds_list_find_index(global.importGridColNameList, i);
			if(ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLevel,fieldName) == "token"){
				ds_list_add(global.tokenFieldList, ds_list_find_value(global.importGridColNameList, i));
			}
			
		}
		ds_list_add(global.tokenFieldList, "~text");
		
	}
	
	
	//split display token col to make the unit's tokens
	var displayUnitStr = ds_grid_get(global.importGrid, indexOfDisplayToken, row);
	var splitList = scr_splitStringImport(displayUnitStr, " ");
	
	var tokenTagMapList = ds_list_create();
	
	if (scr_isNumericAndExists(splitList, ds_type_list)) {
		var splitListSize = ds_list_size(splitList);
		for (var i = 0; i < splitListSize; i++) {
				
			
			// make token node
			var currentTokenNode = scr_addToNodeMap("token");
			var currentTokenSubMap = global.nodeMap[? currentTokenNode];
			ds_map_add(currentTokenSubMap, "discourseTokenSeq", ds_list_size(tokenList) + 1);
			ds_map_add(currentTokenSubMap, "tokenSeq", i + 1);
			ds_map_add(currentTokenSubMap, "displayCol", i);
			ds_map_add(currentTokenSubMap, "void", 1);
			ds_map_add(currentTokenSubMap, "pixelX", 0);
			ds_map_add(currentTokenSubMap, "border", "");
			ds_map_add(currentTokenSubMap, "searched", false);
			ds_map_add(currentTokenSubMap, "unit", unitNode);
			ds_map_add_list(currentTokenSubMap, "inChainsList", ds_list_create());
			ds_map_add_list(currentTokenSubMap, "inChunkList", ds_list_create());
			
			// make tag map for token
			var currentTokenTagMap = ds_map_create();
			ds_map_add_map(currentTokenSubMap, "tagMap", currentTokenTagMap);
			ds_map_add(currentTokenTagMap, "~text", splitList[| i]);
			
			//add to list of token tag meps for other token fields
			ds_list_add(tokenTagMapList,currentTokenTagMap);
			
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

/*
	
	for(var i = 0; i < importGridWidth; i++){

		// get unit string and split it
		var unitStr = ds_grid_get(global.importGrid, i, row);
		var splitList = scr_splitStringImport(unitStr, " ");
		
		if (scr_isNumericAndExists(splitList, ds_type_list)) {
			var splitListSize = ds_list_size(splitList);
			for (var j = 0; j < splitListSize; j++) {
				
			
				// make token node
				var currentTokenNode = scr_addToNodeMap("token");
				var currentTokenSubMap = global.nodeMap[? currentTokenNode];
				ds_map_add(currentTokenSubMap, "discourseTokenSeq", ds_list_size(tokenList) + 1);
				ds_map_add(currentTokenSubMap, "tokenSeq", j + 1);
				ds_map_add(currentTokenSubMap, "displayCol", j);
				ds_map_add(currentTokenSubMap, "void", 1);
				ds_map_add(currentTokenSubMap, "pixelX", 0);
				ds_map_add(currentTokenSubMap, "border", "");
				ds_map_add(currentTokenSubMap, "searched", false);
				ds_map_add(currentTokenSubMap, "unit", unitNode);
				ds_map_add_list(currentTokenSubMap, "inChainsList", ds_list_create());
				ds_map_add_list(currentTokenSubMap, "inChunkList", ds_list_create());
			
				// make tag map for token
				var currentTokenTagMap = ds_map_create();
				ds_map_add_map(currentTokenSubMap, "tagMap", currentTokenTagMap);
				ds_map_add(currentTokenTagMap, "~text", splitList[| j]);
			
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
	}
	
*/
	
	ds_list_destroy(splitList);
	ds_list_destroy(tokenTagMapList);
	
	importGridRow++;
}