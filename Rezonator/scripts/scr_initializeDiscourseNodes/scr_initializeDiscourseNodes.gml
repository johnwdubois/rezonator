// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_initializeDiscourseNodes(){
	
	show_debug_message("scr_initializeDiscourseNodes ... START " + scr_printTime());
	
	// create discourse node
	var currentDiscourseNode = scr_addToNodeMap("Discourse");
	var currentDiscourseSubMap = global.nodeMap[? currentDiscourseNode];
	global.discourseNode = currentDiscourseNode;
	
	var unitList = ds_list_create();
	var tokenList = ds_list_create();
	var displayUnitList = ds_list_create();
	
	
	var tokenTagMap = ds_map_create();
	var unitTagMap  = ds_map_create();
	
	
	var discourseTokenSeq = 1;
	
	var unitGrid = obj_control.unitGrid;
	var unitGridHeight = ds_grid_height(unitGrid);
	for (var i = 0; i < unitGridHeight; i++) {
		
		// get data for current unit
		var currentWordIDList = ds_grid_get(unitGrid, obj_control.unitGrid_colWordIDList, i);
		var currentPID = ds_grid_get(unitGrid, obj_control.unitGrid_colpID, i);
		var currentSpeakerColor = ds_grid_get(unitGrid, obj_control.unitGrid_colParticipantColor, i);
		
		
		var currentUnitNode = scr_addToNodeMap("unit");
		var currentUnitSubMap = global.nodeMap[? currentUnitNode];
		
		//if this is first unit set it to be focused
		if(i == 0){
			with(obj_panelPane){
				functionChainList_focusedUnitIndex = i;
				functionChainList_focusedUnit = currentUnitNode;
			}
		}
		
		
		// get list of tokens
		var currentEntryList = ds_list_create();
		if (scr_isNumericAndExists(currentWordIDList, ds_type_list)) {
			var currentWordIDListSize = ds_list_size(currentWordIDList);
			for (var j = 0; j < currentWordIDListSize; j++) {
				
				// make token node
				var currentTokenNode = scr_addToNodeMap("token");
				var currentTokenSubMap = global.nodeMap[? currentTokenNode];
				ds_map_add(currentTokenSubMap, "discourseTokenSeq", discourseTokenSeq);
				ds_map_add(currentTokenSubMap, "tokenSeq", j + 1);
				ds_map_add(currentTokenSubMap, "displayCol", j);
				ds_map_add(currentTokenSubMap, "void", 1);
				ds_map_add(currentTokenSubMap, "pixelX", 0);
				ds_map_add(currentTokenSubMap, "border", "");
				ds_map_add(currentTokenSubMap, "searched", false);
				ds_map_add(currentTokenSubMap, "unit", currentUnitNode);
				ds_map_add_list(currentTokenSubMap, "inChainsList", ds_list_create());
				ds_map_add_list(currentTokenSubMap, "inChunkList", ds_list_create());
				
				// make tag map for token & copy tags from tokenImportGrid
				var tagMap = ds_map_create();
				ds_map_add_map(currentTokenSubMap, "tagMap", tagMap);
				var tokenImportColNameListSize = ds_list_size(global.tokenImportColNameList);
				for (var k = 2; k < tokenImportColNameListSize; k++) {
					var currentField = string(global.tokenImportColNameList[| k]);
					var currentTag = ds_grid_get(global.tokenImportGrid, k, discourseTokenSeq - 1);
					ds_map_add(tagMap, currentField, currentTag);
					
					
					
					
					
					if(i == 0){
						var currentTokenFieldMap = ds_map_create();
						ds_map_add_map(tokenTagMap, currentField, currentTokenFieldMap);
						ds_map_add_list(currentTokenFieldMap, "tagSet", ds_list_create());
						var currentTokenFieldMapTypeList = ds_list_create();
						ds_list_add(currentTokenFieldMapTypeList, "token", "chunk");
						ds_map_add_list(currentTokenFieldMap, "targetList", currentTokenFieldMapTypeList);
						
						if(k < 8 and (ds_list_find_index(obj_control.navTokenFieldList, currentField) == -1) ){
							if(k == 3 and (global.tokenImportTranscriptColName == "" or global.tokenImportTranscriptColName == undefined)){}
							else{
								ds_list_add(obj_control.navTokenFieldList, currentField);
								ds_list_add(obj_control.navChunkFieldList, currentField);
							}
						}
					}
					else{
						var currentTokenFieldMap = tokenTagMap[?currentField];
						var currentTagList = currentTokenFieldMap[? "tagSet"];
						if(currentTag != "" && ds_list_size(currentTagList) < 50){
							scr_addToListOnce(currentTagList, currentTag);
						}
					}
	
							
					
				}
				

				
				
				//add each token to the totoal token's List
				ds_list_add(tokenList, currentTokenNode);
				
				// make entry node
				var currentEntryNode = scr_addToNodeMap("entry");
				var currentEntrySubMap = global.nodeMap[? currentEntryNode];
				ds_map_add(currentEntrySubMap, "token", currentTokenNode);
				ds_map_add(currentEntrySubMap, "unit", currentUnitNode);
				
				ds_list_add(currentEntryList, currentEntryNode);
				
				discourseTokenSeq++;
			}
		}
		

		
		// make tag map for unit & copy tags from unitImportGrid
		var tagMap = ds_map_create();
		ds_map_add_map(currentUnitSubMap, "tagMap", tagMap);
		var unitImportColNameListSize = ds_list_size(global.unitImportColNameList);
		for (var j = 1; j < unitImportColNameListSize; j++) {
			var currentField = string(global.unitImportColNameList[| j]);
			var currentTag = ds_grid_get(global.unitImportGrid, j, i);
			
			//show_debug_message("scr_initializeDiscourseNodes... currentField: " + string(currentField));
			
			ds_map_add(tagMap, currentField, currentTag);
			
			if(currentField == global.unitImportUnitStartColName){
				ds_map_add(currentUnitSubMap, "unitStart", currentTag);
			}
			if(currentField == global.unitImportUnitEndColName){
				ds_map_add(currentUnitSubMap, "unitEnd", currentTag);
			}
			if (currentField == global.speakerField) {
				if (is_string(currentTag)) {
					if (string_length(currentTag) >= 1) {
						//show_debug_message("scr_initializeDiscourseNodes ... showSpeakerName is true!");
						scr_showSpeakerName(true);
					}
				}
			}
			
			if(i == 0){
				var currentUnitFieldMap = ds_map_create();
				ds_map_add_map(unitTagMap, currentField, currentUnitFieldMap);
				ds_map_add_list(currentUnitFieldMap, "tagSet", ds_list_create());
				if(j < 7 and ds_list_find_index(obj_control.navUnitFieldList, currentField) == -1){
					ds_list_add(obj_control.navUnitFieldList, currentField);
				}
			}
			else{
				var currentUnitFieldMap = unitTagMap[? currentField];
				var currentTagList = currentUnitFieldMap[? "tagSet"];
				if (currentTag != "" && ds_list_size(currentTagList) < 50) {
					scr_addToListOnce(currentTagList, currentTag);
				}
				

			}
		}

		// add values to unit node
		ds_map_add(currentUnitSubMap, "unitSeq", i + 1);
		ds_map_add_list(currentUnitSubMap, "entryList", currentEntryList);
		ds_map_add_list(currentUnitSubMap, "inChainsList", ds_list_create());
		ds_map_add(currentUnitSubMap, "pixelY", 0);
		ds_map_add(currentUnitSubMap, "pID", currentPID);
		ds_map_add(currentUnitSubMap, "speakerColor", currentSpeakerColor);
		ds_map_add(currentUnitSubMap, "filter", false);
		ds_map_add(currentUnitSubMap, "active", true);
		if (!ds_map_exists(currentUnitSubMap, "unitStart")) ds_map_add(currentUnitSubMap, "unitStart", "");
		if (!ds_map_exists(currentUnitSubMap, "unitEnd")) ds_map_add(currentUnitSubMap, "unitEnd", "");
		
		//add each token to the totoal token's List
		ds_list_add(unitList, currentUnitNode);
	}
	
	
	
	// copy unitList into displayUnitList
	ds_list_copy(displayUnitList, unitList);
	
	// attach core lists to discourse map
	ds_map_add_list(currentDiscourseSubMap, "unitList", unitList);
	ds_map_add_list(currentDiscourseSubMap, "tokenList", tokenList);
	ds_map_add_list(currentDiscourseSubMap, "displayUnitList", displayUnitList);
	obj_control.displayUnitList = displayUnitList;
	
	//copy import grid field lists
	var sizeOfTokenImportList = ds_list_size(global.tokenImportColNameList);
	for(var j = 2; j < sizeOfTokenImportList; j++){
		ds_list_add(obj_control.tokenFieldList, global.tokenImportColNameList[|j]);
	}
	var sizeOfUnitImportList = ds_list_size(global.unitImportColNameList);
	for(var j = 1; j < sizeOfUnitImportList; j++){
		ds_list_add(obj_control.unitFieldList, global.unitImportColNameList[|j]);
	}
	
	ds_map_add_map(global.nodeMap, "tokenTagMap", tokenTagMap);
	ds_map_add_map(global.nodeMap, "unitTagMap", unitTagMap);
	
	ds_list_add(global.nodeMap[? "nodeList"], "tokenTagMap");
	ds_list_add(global.nodeMap[? "nodeList"], "unitTagMap");
	
	
	
	// create the SEARCH MAP
	global.searchMap = ds_map_create();

	// add searchNodeList to nodeMap
	ds_map_add_list(global.nodeMap, "searchNodeList", ds_list_create());

	// add search map to nodeMap
	ds_map_add_map(global.nodeMap, "searchMap", global.searchMap);
	
	// add search map to nodeList
	ds_list_add(global.nodeMap[? "nodeList"], "searchMap");

	
	
	// set default displayTokenField
	global.displayTokenField = "~text";
	global.speakerField = "~Participant";
	
	show_debug_message("scr_initializeDiscourseNodes ... END " + scr_printTime());
	

}