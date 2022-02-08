function scr_dialogueBoxNewCustomFieldUnit() {
	
	var newField = obj_control.inputText;
	if (!is_string(newField) || string_length(string(newField)) < 1) {
		show_debug_message("new field is invalid or blank string, exiting...");
		exit;
	}
	
	// add new field to the list of unit fields
	if (ds_list_find_index(obj_control.unitFieldList, newField) != -1) exit;
	scr_addToListOnce(obj_control.unitFieldList, newField);
	scr_sortList(obj_control.unitFieldList)
	
	// create a new submap for this field
	var newFieldMap = ds_map_create();
	ds_map_add_list(newFieldMap, "tagSet", ds_list_create());
	
	//add to nav window list
	scr_addToListOnce(obj_control.navUnitFieldList, newField);
	
	
	// add our new field's submap to the tagMap
	var tagMap = global.nodeMap[? "unitTagMap"];
	ds_map_add_map(tagMap, newField, newFieldMap);
	
	
	// loop over all units and give their tagmaps this new field
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	if (scr_isNumericAndExists(unitList, ds_type_list)) {
		
		var unitListSize = ds_list_size(unitList);
		for (var i = 0; i < unitListSize; i++) {
			
			// get the current unit's tagmap
			var currentUnit = unitList[| i];
			var currentUnitSubMap = global.nodeMap[? currentUnit];
			var currentTagMap = currentUnitSubMap[? "tagMap"];
			
			// add the new field to this tagmap, with the default value being ""
			if (!ds_map_exists(currentTagMap, newField)) {
				ds_map_add(currentTagMap, newField, "");
			}
		}
	}
	

}
