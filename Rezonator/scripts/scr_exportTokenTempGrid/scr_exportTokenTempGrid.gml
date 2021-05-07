// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportTokenTempGrid(headerList){
	
	// get list of all tokens
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var tokenList = discourseSubMap[? "tokenList"];
	if (!scr_isNumericAndExists(tokenList, ds_type_list)) {
		show_debug_message("scr_exportTokenTempGrid, tokenList does not exist");
		exit;
	}
	var tokenListSize = ds_list_size(tokenList);
	var headerListSize = ds_list_size(headerList);
	
	// the headerList contains some default values concatenated with the tokenFieldList, so we can
	// find the first column that the tokenFieldList starts on with this calculation
	var firstTokenFieldCol = headerListSize - ds_list_size(obj_control.tokenFieldList);
	
	// create the export token grid
	var exportGrid = ds_grid_create(ds_list_size(headerList), tokenListSize);
		
	// loop over all tokens and copy their data into the exportGrid
	for (var i = 0; i < tokenListSize; i++) {
		
		var currentToken = tokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentUnit = currentTokenSubMap[? "unit"];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		
		
		var currentTokenOrder = currentTokenSubMap[? "tokenSeq"];
		var currentUnitSeq = currentUnitSubMap[? "unitSeq"];
		
		
		
		var currentTagMap = currentTokenSubMap[? "tagMap"];
		
		
		// collect data for this token
		for (var j = 0; j < headerListSize; j++) {
			
			var currentHeader = headerList[| j];
			var cellValue = "";
			
			if (j < firstTokenFieldCol) {
				// default export data "tokenID", "tokenOrder", "unitID", "unitSeq"
				if (currentHeader == "tokenID") cellValue = string(currentToken);
				else if (currentHeader == "tokenOrder") cellValue = string(currentTokenOrder);
				else if (currentHeader == "unitID") cellValue = string(currentUnit);
				else if (currentHeader == "unitSeq") cellValue = string(currentUnitSeq);
			}
			else {
				// token tag data
				cellValue = string(currentTagMap[? currentHeader]);
			}
			
			// set the current cell's value in the token export grid
			ds_grid_set(exportGrid, j, i, cellValue);
		}
	}
	
	return(exportGrid);
}