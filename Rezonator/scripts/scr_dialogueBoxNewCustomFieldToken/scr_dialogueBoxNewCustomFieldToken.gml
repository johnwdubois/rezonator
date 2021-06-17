function scr_dialogueBoxNewCustomFieldToken() {
	
	var newField = obj_control.inputText;
	
	// add new field to the list of token fields
	ds_list_add(obj_control.tokenFieldList, newField);
	
	//add to nav window list if
	var sizeOfNavTokenList = ds_list_size(obj_control.navTokenFieldList);
	if(sizeOfNavTokenList < 6){
		ds_list_add(obj_control.navTokenFieldList, newField);
	}
	
	// create a new submap for this field
	var newFieldMap = ds_map_create();
	ds_map_add_list(newFieldMap, "tagSet", ds_list_create());
	var newFieldMapTypeList = ds_list_create();
	ds_list_add(newFieldMapTypeList, "token", "chunk");
	ds_map_add_list(newFieldMap, "targetList", newFieldMapTypeList);
	
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
	
	if(sizeOfNavTokenList == 6){
		scr_tokenSelection(newField);
	}
	


}
