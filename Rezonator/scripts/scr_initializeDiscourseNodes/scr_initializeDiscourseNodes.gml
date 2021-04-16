// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_initializeDiscourseNodes(){
	
	show_debug_message("scr_initializeDiscourseNodes() ... START " + scr_printTime());
	
	// create discourse node
	var currentDiscourseNode = scr_addToNodeMap("Discourse");
	var currentDiscourseSubMap = global.nodeMap[? currentDiscourseNode];
	global.discourseNode = currentDiscourseNode;
	
	var unitList = ds_list_create();
	var tokenList = ds_list_create();
	var displayUnitList = ds_list_create();
	
	
	var tokenSeq = 1;
	
	var unitGrid = obj_control.unitGrid;
	var unitGridHeight = ds_grid_height(unitGrid);
	for (var i = 0; i < unitGridHeight; i++) {
		
		// get data for current unit
		var currentWordIDList = ds_grid_get(unitGrid, obj_control.unitGrid_colWordIDList, i);
		var currentPID = ds_grid_get(unitGrid, obj_control.unitGrid_colpID, i);
		var currentSpeakerColor = ds_grid_get(unitGrid, obj_control.unitGrid_colParticipantColor, i);
		
		
		var currentUnitNode = scr_addToNodeMap("unit");
		var currentUnitSubMap = global.nodeMap[? currentUnitNode];
		
		
		// get list of tokens
		var currentEntryList = ds_list_create();
		if (scr_isNumericAndExists(currentWordIDList, ds_type_list)) {
			var currentWordIDListSize = ds_list_size(currentWordIDList);
			for (var j = 0; j < currentWordIDListSize; j++) {
				
				// make token node
				var currentTokenNode = scr_addToNodeMap("token");
				var currentTokenSubMap = global.nodeMap[? currentTokenNode];
				ds_map_add(currentTokenSubMap, "tokenSeq", tokenSeq);
				ds_map_add(currentTokenSubMap, "displayCol", j);
				ds_map_add(currentTokenSubMap, "pixelX", 0);
				ds_map_add(currentTokenSubMap, "unit", currentUnitNode);
				ds_map_add_list(currentTokenSubMap, "inChainsList", ds_list_create());
				
				// make tag map for token & copy tags from tokenImportGrid
				var tagMap = ds_map_create();
				ds_map_add_map(currentTokenSubMap, "tagMap", tagMap);
				var tokenImportColNameListSize = ds_list_size(global.tokenImportColNameList);
				for (var k = 2; k < tokenImportColNameListSize; k++) {
					var currentField = string(global.tokenImportColNameList[| k]);
					var currentTag = ds_grid_get(global.tokenImportGrid, k, tokenSeq - 1);
					ds_map_add(tagMap, currentField, currentTag);
				}
				
				//add each token to the totoal token's List
				ds_list_add(tokenList, currentTokenNode);
				
				// make entry node
				var currentEntryNode = scr_addToNodeMap("entry");
				var currentEntrySubMap = global.nodeMap[? currentEntryNode];
				ds_map_add(currentEntrySubMap, "token", currentTokenNode);
				ds_map_add(currentEntrySubMap, "unit", currentUnitNode);
				
				ds_list_add(currentEntryList, currentEntryNode);
				
				tokenSeq++;
			}
		}
		

		
		// make tag map for unit & copy tags from unitImportGrid
		var tagMap = ds_map_create();
		ds_map_add_map(currentUnitSubMap, "tagMap", tagMap);
		var unitImportColNameListSize = ds_list_size(global.unitImportColNameList);
		for (var j = 1; j < unitImportColNameListSize; j++) {
			var currentField = string(global.unitImportColNameList[| j]);
			var currentTag = ds_grid_get(global.unitImportGrid, j, i);
			ds_map_add(tagMap, currentField, currentTag);
		}
		
		// add values to unit node
		ds_map_add(currentUnitSubMap, "unitSeq", i + 1);
		ds_map_add_list(currentUnitSubMap, "entryList", currentEntryList);
		ds_map_add_list(currentUnitSubMap, "inChainsList", ds_list_create());
		ds_map_add(currentUnitSubMap, "pixelY", 0);
		ds_map_add(currentUnitSubMap, "pID", currentPID);
		ds_map_add(currentUnitSubMap, "speakerColor", currentSpeakerColor);
		
		//add each token to the totoal token's List
		ds_list_add(unitList, currentUnitNode);
	}
	
	
	
	// copy unitList into displayUnitList
	ds_list_copy(displayUnitList, unitList);
	
	// attach core lists to discourse map
	ds_map_add(currentDiscourseSubMap, "unitList", unitList);
	ds_map_add(currentDiscourseSubMap, "tokenList", tokenList);
	ds_map_add(currentDiscourseSubMap, "displayUnitList", displayUnitList);
	obj_control.displayUnitList = displayUnitList;
	
	// set default displayTokenField
	global.displayTokenField = "~text";
	global.speakerField = "~Participant";
	
	show_debug_message("scr_initializeDiscourseNodes() ... END " + scr_printTime());
	

}