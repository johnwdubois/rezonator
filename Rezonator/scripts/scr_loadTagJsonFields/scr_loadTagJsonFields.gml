// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_loadTagJsonFields(originalTagMap, originalFieldList, tagMapJson, nodeList){
	
		// get tokenList & unitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	

	
	// we will keep track of all the new fields encountered, so we can add them to the nodes later
	var newFieldList = ds_list_create();
	
	// load the tagMapJson from the json
	var tagMapJsonSize = ds_map_size(tagMapJson);
	show_debug_message("tags found from map: " + string(tagMapJsonSize));
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
			
			if(nodeList == "token"){
				if(!scr_isNumericAndExists(currentJsonMap, ds_type_map)){continue;}
				var typeList = currentJsonMap[?"targetList"];
				if(ds_list_find_index(typeList, "token") >= 0){
					scr_addToListOnce(originalFieldList, currentJsonField);
				}
			}
			else if(nodeList == "chunk"){
				if(!scr_isNumericAndExists(currentJsonMap, ds_type_map)){continue;}
				var typeList = currentJsonMap[?"targetList"];
				if(ds_list_find_index(typeList, "chunk") >= 0){
					scr_addToListOnce(originalFieldList, currentJsonField);
				}
			}
			else{
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
			if(nodeList == "token"){
				if(!scr_isNumericAndExists(currentJsonMap, ds_type_map)){continue;}
				var typeList = currentJsonMap[?"targetList"];
				if(ds_list_find_index(typeList, "token") >= 0){
					// if this field is not in the originalTagMap at all, we will add its entire submap
					ds_map_add_map(originalTagMap, currentJsonField, currentJsonMap);
					scr_addToListOnce(originalFieldList, currentJsonField);
					scr_addToListOnce(newFieldList, currentJsonField);
				}
			}
			else if(nodeList == "chunk"){

				if(!scr_isNumericAndExists(currentJsonMap, ds_type_map)){continue;}
				var typeList = currentJsonMap[? "targetList"];
				if(ds_list_find_index(typeList, "chunk") >= 0){
					// if this field is not in the originalTagMap at all, we will add its entire submap
					ds_map_add_map(originalTagMap, currentJsonField, currentJsonMap);
					scr_addToListOnce(originalFieldList, currentJsonField);
					scr_addToListOnce(newFieldList, currentJsonField);
				}
			}
			else{
				// if this field is not in the originalTagMap at all, we will add its entire submap
				ds_map_add_map(originalTagMap, currentJsonField, currentJsonMap);
				scr_addToListOnce(originalFieldList, currentJsonField);
				scr_addToListOnce(newFieldList, currentJsonField);
			}
		}
		
		currentJsonField = ds_map_find_next(tagMapJson, currentJsonField);
	}
	
	
	if(nodeList == "token"){
		nodeList = discourseSubMap[? "tokenList"];
	}
	else if(nodeList == "unit"){
		nodeList = discourseSubMap[? "unitList"];
	}
	else if(nodeList == "chunk"){
		nodeList = global.nodeMap[? "chunkList"];
	}
	
	var chainField = false;
	var entryField = false;
	var linkField = false;
	if (nodeList == "chain" || nodeList == "entry" || nodeList == "link") {
		if (nodeList == "chain") chainField = true;
		if (nodeList == "entry") entryField = true;
		if (nodeList == "link"){ linkField = true;
			nodeList = global.nodeMap[? "treeList"];
		}
		else{
			nodeList = global.nodeMap[? "nodeList"];
		}
	}
	

		
	// loop through the given nodeList to add new fields
	var nodeListSize = ds_list_size(nodeList);
	var newFieldListSize = ds_list_size(newFieldList);
	show_debug_message(""+string(newFieldListSize))
	for (var i = 0; i < nodeListSize; i++) {
		var currentNode = nodeList[| i];
		if (linkField){		
			var currentSubMap = global.treeMap[? currentNode];
		}
		else{
			var currentSubMap = global.nodeMap[? currentNode];
		}
		var currentNodeType = currentSubMap[? "type"];
		
		if (chainField && (currentNodeType != "rezChain" && currentNodeType != "trackChain" && currentNodeType != "stackChain")) {
			continue;
		}
		if (entryField && (currentNodeType != "rez" && currentNodeType != "track" && currentNodeType != "stack")) {
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
	

	ds_list_destroy(newFieldList);

}