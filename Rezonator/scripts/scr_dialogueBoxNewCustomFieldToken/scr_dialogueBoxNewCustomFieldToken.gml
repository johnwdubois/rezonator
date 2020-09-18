function scr_dialogueBoxNewCustomFieldToken() {
	var newField = obj_control.inputText;

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

	scr_tokenSelection(newField);


}
