if (ds_grid_height(global.importToolboxGrid) < 1) {
	exit;
}


// check to make sure we at least have a "gw" column and a "mph" column
var gwCol = false;
var mphCol = false;
for (var i = 0; i < global.importToolboxGridWidth; i++) {
	if (string_lower(global.importToolboxGridColName[i]) == "gw") {
		gwCol = true;
	}
	else if (string_lower(global.importToolboxGridColName[i]) == "mph") {
		gwCol = true;
	}
}
if (!gwCol or !mphCol) {
	exit;
}


for (var i = 0; i < ds_grid_height(global.importToolboxGrid); i++) {
	
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