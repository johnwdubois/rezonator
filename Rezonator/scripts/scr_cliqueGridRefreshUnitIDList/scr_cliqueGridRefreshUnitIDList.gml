var rowInCliqueGrid = argument0;

var chainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, rowInCliqueGrid);
var unitIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colUnitIDList, rowInCliqueGrid);

var chainIDListSize = ds_list_size(chainIDList);
for (var i = 0; i < chainIDListSize; i++) {
	var currentChainID = ds_list_find_value(chainIDList, i);	
	var rowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), currentChainID);

	
	if (rowInChainGrid < 0 or rowInChainGrid >= ds_grid_height(obj_chain.rezChainGrid)) {
		continue;
	}
	
	var currentWordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);

	var currentWordIDListSize = ds_list_size(currentWordIDList);
	for (var j = 0; j < currentWordIDListSize; j++) {
		var currentWordID = ds_list_find_value(currentWordIDList, j);
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		
		if (ds_list_find_index(unitIDList, currentUnitID) == -1) {
			ds_list_add(unitIDList, currentUnitID);
		}
	}
}

ds_list_sort(unitIDList, true);

var newRangeStart = ds_list_find_value(unitIDList, 0);
var newRangeEnd = ds_list_find_value(unitIDList, ds_list_size(unitIDList) - 1);
var newLength = ds_list_size(unitIDList);
ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeStart, rowInCliqueGrid, newRangeStart);
ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeEnd, rowInCliqueGrid, newRangeEnd);
ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colLength, rowInCliqueGrid, newLength);



cliqueGridRowToCheckBreak = rowInCliqueGrid;
with (obj_chain) {
	alarm[2] = 3;
}



scr_cliqueDisplayRefresh();