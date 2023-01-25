

function scr_sortFilterList(filterUnitList) {
	// sort filterUnitList based on discourse time
	var filterUnitListSize = ds_list_size(filterUnitList);
	var sortFilterTempGrid = ds_grid_create(2, filterUnitListSize);
	var sortFilterTempGrid_colUnitID = 0;
	var sortFilterTempGrid_colUnitSeq = 1;
	for (var i = 0; i < filterUnitListSize; i++) {
		var currentUnitID = filterUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnitID];
		var currentUnitSeq = currentUnitSubMap[? "unitSeq"];
		ds_grid_set(sortFilterTempGrid, sortFilterTempGrid_colUnitID, i, currentUnitID);
		ds_grid_set(sortFilterTempGrid, sortFilterTempGrid_colUnitSeq, i, currentUnitSeq);
	}
	ds_grid_sort(sortFilterTempGrid, sortFilterTempGrid_colUnitSeq, true);
	ds_list_clear(filterUnitList);
	for (var i = 0; i < filterUnitListSize; i++) {
		var currentUnitID = ds_grid_get(sortFilterTempGrid, sortFilterTempGrid_colUnitID, i);
		ds_list_add(filterUnitList, currentUnitID);
	}
}