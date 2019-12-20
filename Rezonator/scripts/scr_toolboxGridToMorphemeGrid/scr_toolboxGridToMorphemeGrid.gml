if (ds_grid_height(global.importToolboxGrid) < 1) {
	exit;
}


// check to make sure we at least have a "gw" column and a "mph" column
var gwCol = -1;
var mphCol = -1;
var participantCol = -1;
var unitStartCol = -1;
var unitEndCol = -1;
var mglCol = -1;
var lgCol = -1;
var idCol = -1;
var psCol = -1;
for (var i = 0; i < global.importToolboxGridWidth; i++) {
	var currentColName = string_lower(global.importToolboxGridColName[i]);
	if (currentColName == "gw") {
		gwCol = i;
	}
	else if (currentColName == "mph") {
		mphCol = i;
	}
	else if (currentColName == "elanparticipant") {
		participantCol = i;
	}
	else if (currentColName == "elanbegin") {
		unitStartCol = i;
	}
	else if (currentColName == "elanend") {
		unitEndCol = i;
	}
	else if (currentColName == "mgl") {
		mglCol = i;
	}
	else if (currentColName == "lg") {
		lgCol = i;
	}
	else if (currentColName == "id") {
		idCol = i;
	}
	else if (currentColName == "ps") {
		psCol = i;
	}
}
if (gwCol < 0 or gwCol >= ds_grid_width(global.importToolboxGrid)
or mphCol < 0 or mphCol >= ds_grid_width(global.importToolboxGrid)) {
	exit;
}


// loop through toolbox grid and create row for every mph, and sort gw info into correct row
for (var i = 0; i < ds_grid_height(global.importToolboxGrid); i++) {
	var currentMphFullStr = string(ds_grid_get(global.importToolboxGrid, mphCol, i));
	var currentGwFullStr = string(ds_grid_get(global.importToolboxGrid, gwCol, i));
	var currentMphList = scr_splitStringToolbox(currentMphFullStr);
	var currentGwList = scr_splitStringToolbox(currentGwFullStr);
	var participantName = "";
	var currentUnitStart = 0;
	var currentUnitEnd = 0;
	var currentMglList = 0;
	var currentLgList = 0;
	var currentIdList = 0;
	var currentPsList = 0;
	
	if (participantCol > -1) {
		participantName = ds_grid_get(global.importToolboxGrid, participantCol, i);
	}
	if (unitStartCol > -1) {
		currentUnitStart = ds_grid_get(global.importToolboxGrid, unitStartCol, i);
	}
	if (unitEndCol > -1) {
		currentUnitEnd = ds_grid_get(global.importToolboxGrid, unitEndCol, i);
	}
	
	
	if (mglCol > -1) {
		var currentMglFullStr = string(ds_grid_get(global.importToolboxGrid, mglCol, i));
		currentMglList = scr_splitStringToolbox(currentMglFullStr);
	}
	if (lgCol > -1) {
		var currentLgFullStr = string(ds_grid_get(global.importToolboxGrid, lgCol, i));
		currentLgList = scr_splitStringToolbox(currentLgFullStr);
	}
	if (idCol > -1) {
		var currentIdFullStr = string(ds_grid_get(global.importToolboxGrid, idCol, i));
		currentIdList = scr_splitStringToolbox(currentIdFullStr);
	}
	if (psCol > -1) {
		var currentPsFullStr = string(ds_grid_get(global.importToolboxGrid, psCol, i));
		currentPsList = scr_splitStringToolbox(currentPsFullStr);
	}
	
	
	for (var j = 0; j < ds_list_size(currentMphList); j++) {
		var currentMph = ds_list_find_value(currentMphList, j);
		
		var currentMgl = (mglCol > -1) ? ds_list_find_value(currentMglList, clamp(j, 0, ds_list_size(currentMglList) - 1)) : 0;
		var currentLg = (lgCol > -1) ? ds_list_find_value(currentLgList, clamp(j, 0, ds_list_size(currentLgList) - 1)) : 0;
		var currentId = (idCol > -1) ? ds_list_find_value(currentIdList, clamp(j, 0, ds_list_size(currentIdList) - 1)) : 0;
		var currentPs = (psCol > -1) ? ds_list_find_value(currentPsList, clamp(j, 0, ds_list_size(currentPsList) - 1)) : 0;
		
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
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colParticipant, ds_grid_height(obj_control.morphemeGrid) - 1, participantName);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitStart, ds_grid_height(obj_control.morphemeGrid) - 1, currentUnitStart);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colUnitEnd, ds_grid_height(obj_control.morphemeGrid) - 1, currentUnitEnd);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colMgl, ds_grid_height(obj_control.morphemeGrid) - 1, currentMgl);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colLg, ds_grid_height(obj_control.morphemeGrid) - 1, currentLg);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colId, ds_grid_height(obj_control.morphemeGrid) - 1, currentId);
		ds_grid_set(obj_control.morphemeGrid, obj_control.morphemeGrid_colPs, ds_grid_height(obj_control.morphemeGrid) - 1, currentPs);
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

scr_morphemeToUnitGrid();