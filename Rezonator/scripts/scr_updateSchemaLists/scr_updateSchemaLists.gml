function scr_updateSchemaLists() {
	//re-store neccessary items in the global lists needed in sch files
	obj_importMapping.levelEstimateColumnSelected = global.tagInfoGrid_colLevelSchema;
	for(var i = 0 ; i < ds_list_size(global.previousLevelEstimates); i++){
			
		if(i < ds_grid_height(global.tagInfoGrid)){		
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, i,ds_list_find_value(global.previousLevelEstimates,i));
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i,ds_list_find_value(global.previousLevelEstimates,i));
		}

	}

	for(var i = 0 ; i < ds_list_size(global.previousSpecialFields); i++){
			
		if(i < ds_grid_height(global.tagInfoGrid)){			
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, ds_list_find_value(global.previousSpecialFields,i));
		}

	}
	
	with (obj_importMapping) {
		alarm[4] = 2;
	}

}
