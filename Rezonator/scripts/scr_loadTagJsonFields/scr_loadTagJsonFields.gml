function scr_loadTagJsonFields(originalTagMap, originalFieldList, tagMapJson, nodeType) {

	if (!scr_isNumericAndExists(originalTagMap, ds_type_map)  or !scr_isNumericAndExists(tagMapJson, ds_type_map)) {
		exit;
	}

	// get tokenList & unitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	
	// we will keep track of all the new fields encountered, so we can add them to the nodes later
	var newFieldList = ds_list_create();
	
	// load the tagMapJson from the json
	var tagMapJsonSize = ds_map_size(tagMapJson);
	//show_debug_message("tags found from map: " + string(tagMapJsonSize));
	var currentJsonField = ds_map_find_first(tagMapJson);
	for (var i = 0; i < tagMapJsonSize; i++) {
		
		show_debug_message("scr_loadTagJson ... currentJsonField: " + string(currentJsonField) + ", nodeType: " + string(nodeType));

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
		
		//show_debug_message("scr_loadTagJson ... currentJsonTagSet: " + scr_getStringOfList(currentJsonTagSet));
		
		
		if (ds_map_exists(originalTagMap, currentJsonField)) {
			
			if (nodeType == "token") {
				if (!scr_isNumericAndExists(currentJsonMap, ds_type_map)) {continue;}
				var typeList = currentJsonMap[? "targetList"];
				show_debug_message("field in map TOKEN targetList: " + scr_getStringOfList(typeList));
				if (ds_list_find_index(typeList, "token") >= 0) {
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
			}
			else if (nodeType == "chunk") {
				if (!scr_isNumericAndExists(currentJsonMap, ds_type_map)) {continue;}
				var typeList = currentJsonMap[? "targetList"];
				show_debug_message("field in map CHUNK targetList: " + scr_getStringOfList(typeList));
				if (ds_list_find_index(typeList, "chunk") >= 0) {
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
			}
			else{
				show_debug_message("exists in map!");
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
		}
		else {

			
			//check for chunk fields when loading token map
			if (nodeType == "token") {
				if (!scr_isNumericAndExists(currentJsonMap, ds_type_map)) {continue;}
				var typeList = currentJsonMap[? "targetList"];
				show_debug_message("field not in map TOKEN targetList: " + scr_getStringOfList(typeList));
				if (ds_list_find_index(typeList, "token") >= 0) {
					// if this field is not in the originalTagMap at all, we will add its entire submap
					ds_map_add_map(originalTagMap, currentJsonField, currentJsonMap);
					scr_addToListOnce(originalFieldList, currentJsonField);
					scr_addToListOnce(newFieldList, currentJsonField);
				}
			}
			else if (nodeType == "chunk") {

				if (!scr_isNumericAndExists(currentJsonMap, ds_type_map)) {continue;}
				var typeList = currentJsonMap[? "targetList"];
				show_debug_message("field not in map CHUNK targetList: " + scr_getStringOfList(typeList));
				if (ds_list_find_index(typeList, "chunk") >= 0) {
					// if this field is not in the originalTagMap at all, we will add its entire submap
					ds_map_add_map(originalTagMap, currentJsonField, currentJsonMap);
					scr_addToListOnce(originalFieldList, currentJsonField);
					scr_addToListOnce(newFieldList, currentJsonField);
				}
			}
			else{
				show_debug_message("does not exist in map!");
				// if this field is not in the originalTagMap at all, we will add its entire submap
				ds_map_add_map(originalTagMap, currentJsonField, currentJsonMap);
				scr_addToListOnce(originalFieldList, currentJsonField);
				scr_addToListOnce(newFieldList, currentJsonField);
			}
		}
		
		currentJsonField = ds_map_find_next(tagMapJson, currentJsonField);
	}
	
	var newFieldListSize = ds_list_size(newFieldList);
	show_debug_message("NEW FIELD LIST: "+ scr_getStringOfList(newFieldList))
	
	if (nodeType == "token") {
		for (var i = 0; i < newFieldListSize; i++) {
			show_debug_message("field: "+ string(newFieldList[|i]));
			scr_addNewFieldToNodes("token", newFieldList[|i]);
		}
	}
	else if (nodeType == "unit") {
		for (var i = 0; i < newFieldListSize; i++) {
			scr_addNewFieldToNodes("unit", newFieldList[|i]);
		}
	}
	else if (nodeType == "chunk") {
	}
	
	
	/*
	var chainField = false;
	var entryField = false;
	var linkField = false;
	if (nodeType == "chain" || nodeType == "entry" || nodeType == "link") {
		if (nodeType == "chain") chainField = true;
		if (nodeType == "entry") entryField = true;
		if (nodeType == "link") { linkField = true;
			nodeType = global.nodeMap[? "treeList"];
		}
		else{
			nodeType = global.nodeMap[? "nodeType"];
		}
	}
	

		
	// loop through the given nodeType to add new fields
	var nodeTypeSize = ds_list_size(nodeType);
	var newFieldListSize = ds_list_size(newFieldList);
	//show_debug_message(""+string(newFieldListSize))
	for (var i = 0; i < nodeTypeSize; i++) {
		var currentNode = nodeType[| i];
		if (linkField) {		
			var currentSubMap = global.treeMap[? currentNode];
		}
		else{
			var currentSubMap = global.nodeMap[? currentNode];
		}
		var currentNodeType = currentSubMap[? "type"];
		
		if (chainField && (currentNodeType != "resonance" && currentNodeType != "trail" && currentNodeType != "stack")) {
			continue;
		}
		if (entryField && (currentNodeType != "rez" && currentNodeType != "track" && currentNodeType != "card")) {
			continue;
		}
		if (linkField && (currentNodeType != "link")) {
			continue;
		}
		
		
		var currentTagMap = currentSubMap[? "tagMap"]
			
		// add new fields to every node's tagMap
		for (var j = 0; j < newFieldListSize; j++) {
			var currentNewField = newFieldList[| j];
			currentTagMap[? currentNewField] = "";
		}
	}
	*/

	ds_list_destroy(newFieldList);

}