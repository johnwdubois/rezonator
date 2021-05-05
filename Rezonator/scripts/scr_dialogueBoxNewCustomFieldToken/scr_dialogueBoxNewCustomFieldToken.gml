function scr_dialogueBoxNewCustomFieldToken() {
	
	var newField = obj_control.inputText;
	
	// add new field to the list of token fields
	ds_list_add(obj_control.tokenFieldList, newField);
	
	// create a new submap for this field
	var newFieldMap = ds_map_create();
	ds_map_add_list(newFieldMap, "tagSet", ds_list_create());
	
	// add our new field's submap to the tagMap
	var tagMap = global.nodeMap[? "tokenTagMap"];
	ds_map_add_map(tagMap, newField, newFieldMap);
	
	
	// loop over all tokens and give their tagmaps this new field
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var tokenList = discourseSubMap[? "tokenList"];
	if (scr_isNumericAndExists(tokenList, ds_type_list)) {
		
		var tokenListSize = ds_list_size(tokenList);
		for (var i = 0; i < tokenListSize; i++) {
			
			// get the current token's tagmap
			var currentToken = tokenList[| i];
			var currentTokenSubMap = global.nodeMap[? currentToken];
			var currentTagMap = currentTokenSubMap[? "tagMap"];
			
			// add the new field to this tagmap, with the default value being ""
			if (!ds_map_exists(currentTagMap, newField)) {
				ds_map_add(currentTagMap, newField, "");
			}
		}
	}
	
	
	scr_tokenSelection(newField);
	
	
	
	

	/*
	// add new marker to tokenImportGrid
	global.tokenImportGridWidth++;
	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(global.tokenImportGrid));
	ds_grid_set_region(global.tokenImportGrid, global.tokenImportGridWidth - 1, 0, global.tokenImportGridWidth - 1, ds_grid_height(global.tokenImportGrid), "");
	
	// add new marker to tokenImportColNameList
	ds_list_add(global.tokenImportColNameList, newField);
	with (obj_gridViewer) {
		alarm[2] = 1;
	}
	
	// add new marker to tokenImportTagMap
	var tagList = ds_list_create();
	ds_list_add(tagList, "Add new Tag");
	ds_map_add_list(global.tokenImportTagMap, newField, tagList);
	
	// add new marker to customLabelGrid
	ds_grid_resize(global.customLabelGrid, ds_grid_width(global.customLabelGrid), ds_grid_height(global.customLabelGrid) + 1);
	ds_grid_set(global.customLabelGrid, global.customLabelGrid_colLevel, ds_grid_height(global.customLabelGrid) - 1, global.levelToken);
	ds_grid_set(global.customLabelGrid, global.customLabelGrid_colMarker, ds_grid_height(global.customLabelGrid) - 1, obj_control.inputText);
	var emptyList = ds_list_create();
	ds_grid_set(global.customLabelGrid, global.customLabelGrid_colTagList, ds_grid_height(global.customLabelGrid) - 1, emptyList);
	ds_grid_sort(global.customLabelGrid, global.customLabelGrid_colLevel, true);
	*/


}
