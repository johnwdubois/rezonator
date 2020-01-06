if (ds_grid_height(global.importToolboxGrid) < 1) {
	exit;
}


// get importGrid columns
//var participantCol = ds_grid_get(global.importMapGrid, global.importMapGrid_colImportGridCol, 0);
//var morphCol = ds_grid_get(global.importMapGrid, global.importMapGrid_colImportGridCol, 1);
//var unitStartCol = ds_grid_get(global.importMapGrid, global.importMapGrid_colImportGridCol, 2);
//var unitEndCol = ds_grid_get(global.importMapGrid, global.importMapGrid_colImportGridCol, 3);
//var glossCol = ds_grid_get(global.importMapGrid, global.importMapGrid_colImportGridCol, 4);


var unitCounter = 0;
var participantCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 3);
var morphCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 4);
var unitStartCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 1);
var unitEndCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 2);
var glossCol = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, 7);


// build morphGrid!
for (var i = 0; i < ds_grid_height(global.importToolboxGrid); i++) {
	
	var currentParticipant = string(ds_grid_get(global.importToolboxGrid, participantCol, i));
	var currentMorphFullStr = string(ds_grid_get(global.importToolboxGrid, morphCol, i));
	var currentMorphList = scr_splitStringToolbox(currentMorphFullStr);
	if (typeof(glossCol) == ty_real) {
		var currentGlossFullStr = string(ds_grid_get(global.importToolboxGrid, glossCol, i));
	}
	else {
		var currentGlossFullStr = "";
	}
	var currentGlossList = scr_splitStringToolbox(currentGlossFullStr);
	
	if (currentParticipant == 0) {
		continue;
	}
	
	var currentUnitStart = 0;
	var currentUnitEnd = 0;
	if (unitStartCol >= 0) {
		currentUnitStart = ds_grid_get(global.importToolboxGrid, unitStartCol, i);
	}
	if (unitEndCol >= 0) {
		currentUnitEnd = ds_grid_get(global.importToolboxGrid, unitEndCol, i);
	}
	
	unitCounter++;
	
	for (var j = 0; j < ds_list_size(currentMorphList); j++) {
		
		ds_grid_resize(obj_control.morphGrid, obj_control.morphGridWidth, ds_grid_height(obj_control.morphGrid) + 1);
		
		var currentMorph = ds_list_find_value(currentMorphList, j);
		var currentGloss = 0;
		if (glossCol >= 0) {
			currentGloss = ds_list_find_value(currentGlossList, j);
		}
		
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitID, ds_grid_height(obj_control.morphGrid) - 1, unitCounter);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colWordID, ds_grid_height(obj_control.morphGrid) - 1, ds_grid_height(obj_control.morphGrid));
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMorph, ds_grid_height(obj_control.morphGrid) - 1, currentMorph);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, ds_grid_height(obj_control.morphGrid) - 1, currentParticipant);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitStart, ds_grid_height(obj_control.morphGrid) - 1, currentUnitStart);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitEnd, ds_grid_height(obj_control.morphGrid) - 1, currentUnitEnd);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colGloss, ds_grid_height(obj_control.morphGrid) - 1, currentGloss);
	}
}


scr_morphToUnitGrid();



/*

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
		
		ds_grid_resize(obj_control.morphGrid, obj_control.morphGridWidth, ds_grid_height(obj_control.morphGrid) + 1);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitID, ds_grid_height(obj_control.morphGrid) - 1, i + 1);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colWordID, ds_grid_height(obj_control.morphGrid) - 1, ds_grid_height(obj_control.morphGrid));
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMph, ds_grid_height(obj_control.morphGrid) - 1, currentMph);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colAffix, ds_grid_height(obj_control.morphGrid) - 1, affix);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colParticipant, ds_grid_height(obj_control.morphGrid) - 1, participantName);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitStart, ds_grid_height(obj_control.morphGrid) - 1, currentUnitStart);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colUnitEnd, ds_grid_height(obj_control.morphGrid) - 1, currentUnitEnd);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colMgl, ds_grid_height(obj_control.morphGrid) - 1, currentMgl);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colLg, ds_grid_height(obj_control.morphGrid) - 1, currentLg);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colId, ds_grid_height(obj_control.morphGrid) - 1, currentId);
		ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colPs, ds_grid_height(obj_control.morphGrid) - 1, currentPs);
	}
	
	var currentGwIndex = 0;
	for (var j = 0; j < ds_list_size(currentMphList); j++) {
		
		var currentRow = ds_grid_height(obj_control.morphGrid) - ds_list_size(currentMphList) + j;
		var currentGw = ds_list_find_value(currentGwList, currentGwIndex);
		
		var currentAffix = ds_grid_get(obj_control.morphGrid, obj_control.morphGrid, currentRow);
		if (currentAffix < 0) {
			ds_grid_set(obj_control.morphGrid, obj_control.morphGrid_colGw, currentRow, currentGw);
			currentGw++;
		}
		
	}
}

scr_morphToUnitGrid();