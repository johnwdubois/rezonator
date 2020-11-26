function scr_updateSchemaLists() {
	//re-store neccessary items in the global lists needed in sch files

	for(var i = 0 ; i < ds_list_size(global.previousLevelEstimates); i++){
			
		if(i < ds_grid_height(global.tagInfoGrid)){		
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i,ds_list_find_value(global.previousLevelEstimates,i));
		}

	}
	//show_message(scr_getStringOfList(global.previousSpecialFields))
	for(var i = 0 ; i < ds_list_size(global.previousSpecialFields); i++){
			
		if(i < ds_grid_height(global.tagInfoGrid)){		
			var setString = string(ds_list_find_value(global.previousSpecialFields,i));
			if(setString == "Unit Delimiter"){
				global.unitImportUnitDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);

			}
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, setString);
		}

	}


}
