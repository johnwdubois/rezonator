// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportDiscourseTempGrid(headerList, fieldList){
	
	// get list of all nodes
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var listKey = (fieldList == obj_control.tokenFieldList) ? "tokenList" : "unitList";
	var nodeList = discourseSubMap[? listKey];
	if (!scr_isNumericAndExists(nodeList, ds_type_list)) {
		show_debug_message("scr_exportDiscourseTempGrid, nodeList does not exist");
		exit;
	}
	var nodeListSize = ds_list_size(nodeList);
	var headerListSize = ds_list_size(headerList);
	
	
	// the headerList contains some default values concatenated with the fieldList, so we can
	// find the first column that the tokenFieldList starts on with this calculation
	var firstFieldCol = headerListSize - ds_list_size(fieldList);
	
	// create the export token grid
	var exportGrid = ds_grid_create(ds_list_size(headerList), nodeListSize);
		
	// loop over all nodes and copy their data into the exportGrid
	for (var i = 0; i < nodeListSize; i++) {
		
		var currentNode = nodeList[| i];
		var currentNodeSubMap = global.nodeMap[? currentNode];
		var currentType = currentNodeSubMap[? "type"];
		
		var currentUnit = (currentType == "unit") ? currentNode : currentNodeSubMap[? "unit"];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		
		
		var currentTagMap = currentNodeSubMap[? "tagMap"];
		
		
		// collect data for this token
		for (var j = 0; j < headerListSize; j++) {
			
			var currentHeader = headerList[| j];
			var cellValue = "";
			
			if (j < firstFieldCol) {
				if (fieldList == obj_control.tokenFieldList) {
					// default export data for tokens
					if (currentHeader == "tokenID") cellValue = string(currentNode);
					else if (currentHeader == "tokenOrder") cellValue = string(currentNodeSubMap[? "tokenOrder"]);
					else if (currentHeader == "unitID") cellValue = string(currentUnit);
					else if (currentHeader == "unitSeq") cellValue = string(currentUnitSubMap[? "unitSeq"]);
				}
				else if (fieldList == obj_control.unitFieldList) {
					// default export data for units
					if (currentHeader == "unitID") cellValue = string(currentNode);
					else if (currentHeader == "unitSeq") cellValue = string(currentUnitSubMap[? "unitSeq"]);
					else if (currentHeader == "participant") cellValue = string(currentTagMap[? global.participantField]);
					else if (currentHeader == "unitStart") cellValue = string(currentTagMap[? "unitStart"]);
					else if (currentHeader == "unitEnd") cellValue = string(currentTagMap[? "unitEnd"]);
				}
			}
			else {
				// tag data
				cellValue = string(currentTagMap[? currentHeader]);
			}
			
			// set the current cell's value in the token export grid
			//if (cellValue == "undefined") cellValue = "";
			ds_grid_set(exportGrid, j, i, cellValue);
		}
	}
	
	return(exportGrid);
}