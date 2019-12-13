if (ds_grid_height(global.importToolboxGrid) < 1) {
	exit;
}


// check to make sure we at least have a "gw" column and a "mph" column
var gwCol = -1;
var mphCol = -1;
for (var i = 0; i < global.importToolboxGridWidth; i++) {
	var currentColName = string_lower(global.importToolboxGridColName[i]);
	if (currentColName == "gw") {
		gwCol = i;
	}
	else if (currentColName == "mph") {
		mphCol = i;
	}
}
if (gwCol < 0 or gwCol >= ds_grid_width(global.importToolboxGrid)
or mphCol < 0 or mphCol >= ds_grid_width(global.importToolboxGrid)) {
	exit;
}


// loop through toolbox grid and create row for every mph, and sort gw info into correct row
for (var i = 0; i < ds_grid_height(global.importToolboxGrid); i++) {
	var currentMphFullStr = string(ds_grid_get(global.importToolboxGrid, mphCol, i));
	var currentGwFullStr = string(ds_grid_get(global.importToolboxGrid, gwCol, i))
	var currentMphList = scr_splitStringToolbox(currentMphFullStr);
	var currentGwList = scr_splitStringToolbox(currentGwFullStr);
	
	//show_message(scr_getStringOfList(currentMphList));
	//show_message(scr_getStringOfList(currentGwList));
	for (var j = 0; j < ds_list_size(currentMphList); j++) {
		var currentMph = ds_list_find_value(currentMphList, j);
		var affix = 0;
		// check if currentMph has hyphen/affix at beginning or end of string
		if (string_char_at(currentMph, 1) == "-") {
			affix = 1;
		}
		else if (string_char_at(currentMph, string_length(currentMph)) == "-") {
			affix = -1;
		}
		
		ds_grid_resize(obj_control.morphemeGrid, obj_control.morphemeGridWidth, ds_grid_height(obj_control.morphemeGrid) + 1);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitID, ds_grid_height(obj_control.morphemeGrid) - 1, i + 1);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colWordID, ds_grid_height(obj_control.morphemeGrid) - 1, ds_grid_height(obj_control.morphemeGrid));
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colMph, ds_grid_height(obj_control.morphemeGrid) - 1, currentMph);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colAffix, ds_grid_height(obj_control.morphemeGrid) - 1, affix);
	}
	
	var currentGwIndex = 0;
	for (var j = 0; j < ds_list_size(currentMphList); j++) {
		
		var currentRow = ds_grid_height(obj_control.morphemeGrid) - ds_list_size(currentMphList) + j;
		var currentGw = ds_list_find_value(currentGwList, currentGwIndex);
		
		var currentAffix = ds_grid_get(obj_control.morphemeGrid, obj_control.morphemeGrid, currentRow);
		if (currentAffix < 0) {
			ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colGw, currentRow, currentGw);
			currentGw++;
		}
		
	}
}

/*
for (var i = 0; i < ds_grid_height(global.importToolboxGrid); i++) {
	
	var currentToolboxMph = ds_grid_get(global.importToolboxGrid, global.importToolboxGrid_colMph, i);
	var currentToolboxMgl = ds_grid_get(global.importToolboxGrid, global.importToolboxGrid_colMgl, i);
	var currentToolboxLg = ds_grid_get(global.importToolboxGrid, global.importToolboxGrid_colLg, i);
	var currentToolboxId = ds_grid_get(global.importToolboxGrid, global.importToolboxGrid_colId, i);
	var currentToolboxPs = ds_grid_get(global.importToolboxGrid, global.importToolboxGrid_colPs, i);
	
	
	var currentMphList = scr_splitStringToolbox(currentToolboxMph);
	var currentMglList = scr_splitStringToolbox(currentToolboxMgl);
	var currentLgList = scr_splitStringToolbox(currentToolboxLg);
	var currentIdList = scr_splitStringToolbox(currentToolboxId);
	var currentPsList = scr_splitStringToolbox(currentToolboxPs);

	
	for (var j = 0; j < ds_list_size(currentMphList); j++) {
		var currentMph = ds_list_find_value(currentMphList, j);
		var currentMgl = "";
		var currentLg = "";
		var currentId = "";
		var currentPs = "";
		if (ds_list_size(currentMglList) == ds_list_size(currentMphList)) {
			currentMgl = ds_list_find_value(currentMglList, j);
		}
		if (ds_list_size(currentLgList) == ds_list_size(currentMphList)) {
			currentLg = ds_list_find_value(currentLgList, j);
		}
		if (ds_list_size(currentIdList) == ds_list_size(currentMphList)) {
			currentId = ds_list_find_value(currentIdList, j);
		}
		if (ds_list_size(currentPsList) == ds_list_size(currentMphList)) {
			currentPs = ds_list_find_value(currentPsList, j);
		}
		
		ds_grid_resize(obj_control.morphemeGrid, obj_control.morphemeGridWidth, ds_grid_height(obj_control.morphemeGrid) + 1);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitID, ds_grid_height(obj_control.morphemeGrid) - 1, i);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colWordID, ds_grid_height(obj_control.morphemeGrid) - 1, 0);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colMorphemeID, ds_grid_height(obj_control.morphemeGrid) - 1, ds_grid_height(obj_control.morphemeGrid));
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colMorphemeStr, ds_grid_height(obj_control.morphemeGrid) - 1, currentMph);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colMgl, ds_grid_height(obj_control.morphemeGrid) - 1, currentMgl);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colLg, ds_grid_height(obj_control.morphemeGrid) - 1, currentLg);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colId, ds_grid_height(obj_control.morphemeGrid) - 1, currentId);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colPs, ds_grid_height(obj_control.morphemeGrid) - 1, currentPs);
	}
	
	ds_list_destroy(currentMphList);
}
*/