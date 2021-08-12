// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_importGridToNodeMap_fieldsRowUnit(row){

	// make sure row is still in range
	if (row >= importGridHeight) exit;
	
	var entryList = ds_list_create();
	
	var speakerValue = "";
	

	// make a new unit node for this row
	var unitNode = scr_addToNodeMap("unit");
	var unitSubMap = global.nodeMap[? unitNode];
	ds_list_add(unitList, unitNode);
	
	// make tag map for unit
	var unitTagMap = ds_map_create();
	ds_map_add_map(unitSubMap, "tagMap", unitTagMap);
	
	
	// get current unit delimiter cell value
	if(indexOfSpeaker >= 0){
		speakerValue = global.importGrid[# indexOfSpeaker, row];
		if (speakerValue == "" || speakerValue == "0") speakerValue = prevFieldMap[? global.speakerField];
		else prevFieldMap[? global.speakerField] = speakerValue;
		
		ds_map_add(unitTagMap,global.speakerField, speakerValue);
	}
	
	
	
	// add values to unit node
	ds_map_add(unitSubMap, "unitSeq", importGridRow + 1);
	ds_map_add_list(unitSubMap, "entryList", entryList);
	ds_map_add_list(unitSubMap, "inChainsList", ds_list_create());
	ds_map_add(unitSubMap, "pixelY", 0);
	ds_map_add(unitSubMap, "pID", 0);
	ds_map_add(unitSubMap, "speakerColor", c_ltblue);
	ds_map_add(unitSubMap, "filter", false);
	ds_map_add(unitSubMap, "active", true);
	ds_map_add(unitSubMap, "doc", global.discourseNode);
	if (!ds_map_exists(unitSubMap, "unitStart")) ds_map_add(unitSubMap, "unitStart", "");
	if (!ds_map_exists(unitSubMap, "unitEnd")) ds_map_add(unitSubMap, "unitEnd", "");
	
	var unitFieldMap = global.nodeMap[?"unitTagMap"];
	var tokenFieldMap = global.nodeMap[?"tokenTagMap"];

	if(row == 0){

		//add all fields to appropriate field lists
		for(var i = 0 ; i < ds_list_size(global.importGridColNameList); i++){
			var fieldName = global.importGridColNameList[| i];
			if(global.fieldLevelMap[? fieldName] == "unit"){
				if(fieldName == "~blockID"){continue;}
				ds_list_add(global.unitFieldList, fieldName);
				
				var newUnitFieldMap = ds_map_create();
				ds_map_add_map(unitFieldMap,fieldName, newUnitFieldMap);
				ds_map_add_list(newUnitFieldMap, "tagSet", ds_list_create());
			}
			else if(global.fieldLevelMap[? fieldName] == "token" || global.fieldLevelMap[? fieldName] == "word"){
				ds_list_add(global.tokenFieldList, fieldName);
				
				var newTokenFieldMap = ds_map_create();
				ds_map_add_map(tokenFieldMap, fieldName, newTokenFieldMap);
				ds_map_add_list(newTokenFieldMap, "tagSet", ds_list_create());
				var targetSet = ds_list_create();
				ds_map_add_list(newTokenFieldMap, "targetList", targetSet);
				
				if (global.fieldLevelMap[? fieldName] == "word") {
					ds_list_add(targetSet, "chunk");
				}
				else {
					ds_list_add(targetSet, "token");
				}
			}
		}
	}
	
	
	
	
	
	// SPLIT CHUNKS for IGT
	var chunkSubMapList = ds_list_create();
	var chunkIDList = ds_list_create();
	if (indexOfWordDelim >= 0) {
		var displayUnitStr = ds_grid_get(global.importGrid, indexOfWordDelim, row);
		var wordSplitList = scr_splitStringImport(displayUnitStr, " ", true);

	
		if (scr_isNumericAndExists(wordSplitList, ds_type_list)) {
			var wordSplitListSize = ds_list_size(wordSplitList);
			for (var i = 0; i < wordSplitListSize; i++) {
				
			
				// make chunk node
				var currentChunkNode = scr_addToNodeMap("chunk");
				var currentChunkSubMap = global.nodeMap[? currentChunkNode];
				ds_map_add(currentChunkSubMap, "name", "Chunk " + string(ds_list_size(global.nodeMap[? "chunkList"]) + 1));
				ds_map_add(currentChunkSubMap, "nest", 1);
				ds_map_add_list(currentChunkSubMap, "inChainsList", ds_list_create());
				ds_map_add_list(currentChunkSubMap, "tokenList", ds_list_create());
			
				// make tag map for chunk
				var currentChunkTagMap = ds_map_create();
				ds_map_add_map(currentChunkSubMap, "tagMap", currentChunkTagMap);
				ds_map_add(currentChunkTagMap, global.wordDelimField, wordSplitList[| i]);
				scr_addAutoTag(global.wordDelimField, wordSplitList[| i], tokenFieldMap);
			
				//add this chunk's submap to our list of chunk maps
				ds_list_add(chunkSubMapList, currentChunkSubMap);
				ds_list_add(chunkIDList, currentChunkNode);
			
				//add each chunk to the chunk list
				ds_list_add(global.nodeMap[? "chunkList"], currentChunkNode);
				
			}
		}
	}
	
	

	
	
	
	var tokenCount = 0;
	
	
	//split display token col to make the unit's tokens
	var displayUnitStr = ds_grid_get(global.importGrid, indexOfDisplayToken, row);
	var splitList = scr_splitStringImport(displayUnitStr, " ", true);

	
	var tokenTagMapList = ds_list_create();
	
	if (scr_isNumericAndExists(splitList, ds_type_list)) {
		var splitListSize = ds_list_size(splitList);
		for (var i = 0; i < splitListSize; i++) {
			
			var currentChunkSubMap = chunkSubMapList[| i];
			var currentChunkTagMap = -1;
			if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map) && indexOfWordDelim >= 0) {
				currentChunkTagMap = currentChunkSubMap[? "tagMap"];
				if (scr_isNumericAndExists(currentChunkTagMap, ds_type_map)) {
					ds_map_add(currentChunkTagMap, global.displayTokenField, splitList[| i]);
				}
			}
			
			var hyphenSplitList = scr_splitStringWhitespaceAndHyphen(splitList[| i]);
			if (scr_isNumericAndExists(hyphenSplitList, ds_type_list)) {
				var hyphenSplitListSize = ds_list_size(hyphenSplitList);
				for (var j = 0; j < hyphenSplitListSize; j++) {
					
					tokenCount++;
					
					// make token node
					var currentTokenNode = scr_addToNodeMap("token");
					var currentTokenSubMap = global.nodeMap[? currentTokenNode];
					ds_map_add(currentTokenSubMap, "discourseTokenSeq", ds_list_size(tokenList) + 1);
					ds_map_add(currentTokenSubMap, "tokenSeq", tokenCount);
					ds_map_add(currentTokenSubMap, "displayCol", tokenCount - 1);
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
					ds_map_add(currentTokenTagMap, global.displayTokenField, hyphenSplitList[| j]);
					
					//check if token is rtl
					if (!global.RTLFound) {
						global.RTLFound = scr_isStrRTL(hyphenSplitList[| j]);
					}
					
					scr_addAutoTag(global.displayTokenField, hyphenSplitList[| j], tokenFieldMap);
					
					
					
					//add to list of token tag maps for other token fields
					ds_list_add(tokenTagMapList, currentTokenTagMap);
			
					//add each token to the total token's List
					ds_list_add(tokenList, currentTokenNode);
				
					// make entry node
					var currentEntryNode = scr_addToNodeMap("entry");
					var currentEntrySubMap = global.nodeMap[? currentEntryNode];
					ds_map_add(currentEntrySubMap, "token", currentTokenNode);
					ds_map_add(currentEntrySubMap, "unit", unitNode);
				
					ds_list_add(entryList, currentEntryNode);
					
					// add this token to chunk's token list
					if (indexOfWordDelim >= 0 && scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) {
						var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
						var currentChunkType = currentChunkSubMap[? "type"];
						if (scr_isNumericAndExists(currentChunkTokenList, ds_type_list)) {
							ds_list_add(currentChunkTokenList, currentTokenNode);
						}
						
						// add chunk to token's inChunkList
						ds_list_add(currentTokenSubMap[? "inChunkList"], chunkIDList[| i]);
					}
				}
			}
		}
	}
	
	
	
	

	for(var i = 0; i < importGridWidth; i++){
		
		tokenCount = 0;
		
		if(i == indexOfDisplayToken) {continue;}
		if(i == indexOfWordDelim) {continue;}

		// get unit string and split it
		var unitStr = ds_grid_get(global.importGrid, i, row);
		var splitList = scr_splitStringImport(unitStr, " ", true);

		var currentField = global.importGridColNameList[| i];
		var currentLevel = global.fieldLevelMap[? currentField];

	
		if(currentLevel == "token"){			
			if (scr_isNumericAndExists(splitList, ds_type_list)) {
				
				var splitListSize = ds_list_size(splitList);
				for (var j = 0; j < splitListSize; j++) {
					
					var currentWordTag = splitList[| j];
					
					// add this token field to chunk (not yet split on hyphens)
					var currentChunkSubMap = chunkSubMapList[| j];
					var currentChunkTagMap = -1;
					if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map) && indexOfWordDelim >= 0) {
						currentChunkTagMap = currentChunkSubMap[? "tagMap"];
						if (scr_isNumericAndExists(currentChunkTagMap, ds_type_map)) {
							ds_map_add(currentChunkTagMap, currentField, currentWordTag);
						}
					}
					
					
					// fill token node tag map
					var hyphenSplitList = scr_splitStringWhitespaceAndHyphen(currentWordTag);
					
					if (scr_isNumericAndExists(hyphenSplitList, ds_type_list)) {
						var hyphenSplitListSize = ds_list_size(hyphenSplitList);
						for (var k = 0; k < hyphenSplitListSize; k++) {
							
							var currentTokenTag = hyphenSplitList[| k];
							var currentTokenTagMap = tokenTagMapList[| tokenCount];
							if (scr_isNumericAndExists(currentTokenTagMap, ds_type_map)) {
								ds_map_add(currentTokenTagMap, currentField, currentTokenTag);
								scr_addAutoTag(currentField, currentTokenTag, tokenFieldMap);
							}
							
							tokenCount++;
						}
					}
				}
			}		
		}
		else if(currentLevel == "unit"){
			if(currentField == "~blockID" || currentField == global.speakerField){continue;}
			if(currentField == global.unitImportUnitStartColName){unitSubMap[?"unitStart"] = unitStr}
			if(currentField == global.unitImportUnitEndColName){unitSubMap[?"unitEnd"] = unitStr}
			ds_map_add(unitTagMap, currentField, unitStr);
			scr_addAutoTag(currentField, unitStr, unitFieldMap);
		}
		else if(currentLevel == "word"){
			
			var splitListSize = ds_list_size(splitList);
			for (var j = 0; j < splitListSize; j++) {				
				
				// add this word field to chunk
				var currentChunkSubMap = chunkSubMapList[| j];
				var currentChunkTagMap = -1;
				if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map) && indexOfWordDelim >= 0) {
					currentChunkTagMap = currentChunkSubMap[? "tagMap"];
					if (scr_isNumericAndExists(currentChunkTagMap, ds_type_map)) {
						ds_map_add(currentChunkTagMap, currentField, splitList[| j]);
						scr_addAutoTag(currentField, splitList[| j], tokenFieldMap);
					}
				}
			}
			
			
		}			
	}
	
	ds_list_destroy(splitList);
	ds_list_destroy(tokenTagMapList);
	ds_list_destroy(chunkSubMapList);
	ds_list_destroy(chunkIDList);
	
	importGridRow++;
	

}