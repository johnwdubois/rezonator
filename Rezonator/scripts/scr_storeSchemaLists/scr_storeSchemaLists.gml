function scr_storeSchemaLists() {
	//store neccessary items in the global lists needed in sch files

	var tempLevelList = ds_list_create();
	var tempFieldsList = ds_list_create();
			
	for (var i = 0 ; i < ds_grid_height(global.tagInfoGrid); i++) {
		ds_list_add(tempLevelList, ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i));
		ds_list_add(tempFieldsList, ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i));
	}
	ds_list_copy(global.previousLevelEstimates,tempLevelList);
	ds_list_copy(global.previousSpecialFields,tempFieldsList);
	ds_list_destroy(tempLevelList);
	ds_list_destroy(tempFieldsList);


}
