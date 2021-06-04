// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_loadTagJsonFields(originalTagMap, originalFieldList, tagMapJson, nodeList){
	
	
	// we will keep track of all the new fields encountered, so we can add them to the nodes later
	var newFieldList = ds_list_create();
	
	// load the tagMapJson from the json
	var tagMapJsonSize = ds_map_size(tagMapJson);
	var currentJsonField = ds_map_find_first(tagMapJson);
	for (var i = 0; i < tagMapJsonSize; i++) {
		
		show_debug_message("scr_loadTagJson ... currentJsonField: " + string(currentJsonField));
		
		// get the submap for the current field in the json file
		var currentJsonMap = tagMapJson[? currentJsonField];
		if (!scr_isNumericAndExists(currentJsonMap, ds_type_map)) {
			currentJsonField = ds_map_find_next(tagMapJson, currentJsonField);
			continue;
		}
		var currentJsonTagSet = currentJsonMap[? "tagSet"];
		if (!scr_isNumericAndExists(currentJsonTagSet, ds_type_list)) {
			currentJsonField = ds_map_find_next(tagMapJson, currentJsonField);
			continue;
		}
		var currentJsonTagSetSize = ds_list_size(currentJsonTagSet);
		
		show_debug_message("scr_loadTagJson ... currentJsonTagSet: " + scr_getStringOfList(currentJsonTagSet));
		
		
		if (ds_map_exists(originalTagMap, currentJsonField)) {
			// if this field is already in the originalTagMap, we will add any tag from the json that is not already there
			var originalFieldSubMap = originalTagMap[? currentJsonField];
			var originalTagSet = originalFieldSubMap[? "tagSet"];
			if (scr_isNumericAndExists(originalTagSet, ds_type_list)) {
				for (var j = 0; j < currentJsonTagSetSize; j++) {
					var currentJsonTag = currentJsonTagSet[| j];
					scr_addToListOnce(originalTagSet, currentJsonTag);
				}
			}
		}
		else {
			// if this field is not in the originalTagMap at all, we will add its entire submap
			ds_map_add_map(originalTagMap, currentJsonField, currentJsonMap);
			ds_list_add(originalFieldList, currentJsonField);
			ds_list_add(newFieldList, currentJsonField);
		}
		
		currentJsonField = ds_map_find_next(tagMapJson, currentJsonField);
	}
	
	
	
	var chainField = false;
	var entryField = false;
	if (nodeList == "chain" || nodeList == "entry") {
		if (nodeList == "chain") chainField = true;
		if (nodeList == "entry") entryField = true;
		nodeList = global.nodeMap[? "nodeList"];
	}
	

		
	// loop through the given nodeList to add new fields
	var nodeListSize = ds_list_size(nodeList);
	var newFieldListSize = ds_list_size(newFieldList);
	for (var i = 0; i < nodeListSize; i++) {
		var currentNode = nodeList[| i];
		var currentSubMap = global.nodeMap[? currentNode];
		var currentNodeType = currentSubMap[? "type"];
		
		if (chainField && (currentNodeType != "rezChain" && currentNodeType != "trackChain" && currentNodeType != "stackChain")) {
			continue;
		}
		if (entryField && (currentNodeType != "rez" && currentNodeType != "track" && currentNodeType != "stack")) {
			continue;
		}
		
		
		var currentTagMap = currentSubMap[? "tagMap"]
			
		// add new fields to every node's tagMap
		for (var j = 0; j < newFieldListSize; j++) {
			var currentNewField = newFieldList[| j];
			currentTagMap[? currentNewField] = "";
		}
	}

	ds_list_destroy(newFieldList);

}