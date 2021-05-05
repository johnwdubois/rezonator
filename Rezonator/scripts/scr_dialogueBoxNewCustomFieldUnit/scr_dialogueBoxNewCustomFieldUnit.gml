function scr_dialogueBoxNewCustomFieldUnit() {
	
	var newField = obj_control.inputText;
	
	// add new field to the list of token fields
	ds_list_add(obj_control.unitFieldList, newField);
	
	// create a new submap for this field
	var newFieldMap = ds_map_create();
	ds_map_add_list(newFieldMap, "tagSet", ds_list_create());
	
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
	
	
	
	
	scr_unitSelection(newField);
	
	
	
	/*
	var newField = obj_control.inputText;

	// add new marker to unitImportGrid
	global.unitImportGridWidth++;
	ds_grid_resize(global.unitImportGrid, global.unitImportGridWidth, ds_grid_height(global.unitImportGrid));
	ds_grid_set_region(global.unitImportGrid, global.unitImportGridWidth - 1, 0, global.unitImportGridWidth - 1, ds_grid_height(global.unitImportGrid), "");
	
	// add new marker to unitImportColNameList
	ds_list_add(global.unitImportColNameList, newField);
	with (obj_gridViewer) {
		alarm[2] = 1;
	}
	
	// add new marker to unitImportTagMap
	var tagList = ds_list_create();
	ds_list_add(tagList, "Add new Tag");
	ds_map_add_list(global.unitImportTagMap, newField, tagList);
	
	// add new marker to customLabelGrid
	ds_grid_resize(global.customLabelGrid, ds_grid_width(global.customLabelGrid), ds_grid_height(global.customLabelGrid) + 1);
	ds_grid_set(global.customLabelGrid, global.customLabelGrid_colLevel, ds_grid_height(global.customLabelGrid) - 1, global.levelUnit);
	ds_grid_set(global.customLabelGrid, global.customLabelGrid_colMarker, ds_grid_height(global.customLabelGrid) - 1, newField);
	var emptyList = ds_list_create();
	ds_grid_set(global.customLabelGrid, global.customLabelGrid_colTagList, ds_grid_height(global.customLabelGrid) - 1, emptyList);
	ds_grid_sort(global.customLabelGrid, global.customLabelGrid_colLevel, true);

	scr_unitSelection(newField);
	*/

}
