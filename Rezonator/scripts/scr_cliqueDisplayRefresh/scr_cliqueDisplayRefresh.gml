function scr_cliqueDisplayRefresh() {
	/*

	chainGrid_colChainID = 0;
	chainGrid_colChainState = 1;
	chainGrid_colWordIDList = 2;
	chainGrid_colName = 3;
	chainGrid_colColor = 4;
	chainGrid_colInFilter = 5;
	chainGrid_colAlign = 6;




	cliqueGrid_colCliqueID = 0;
	cliqueGrid_colChainIDList = 1;
	cliqueGrid_colUnitIDList = 2;
	cliqueGrid_colRangeStart = 3;
	cliqueGrid_colRangeEnd = 4;
	cliqueGrid_colFlankLeft = 5;
	cliqueGrid_colFlankRight = 6;
	cliqueGrid_colLength = 7;
	cliqueGrid_colBreak = 8;
	cliqueGrid_colName = 9;
	*/
	var cliqueGridHeight = ds_grid_height(obj_chain.cliqueGrid);
	for (var i = 0; i < cliqueGridHeight; i++) {
		var currentChainID = i;
		var currentChainState = 0;
		var currentWordIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colUnitIDList, i);
		var currentName = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colName, i);
		var currentColor = c_black;
		var currentInFilter = false;
		var currentAlign = false;
	
	
		ds_grid_set(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colChainID, i, currentChainID);
		ds_grid_set(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colChainState, i, currentChainState);
		ds_grid_set(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colWordIDList, i, currentWordIDList);
		ds_grid_set(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colName, i, currentName);
		ds_grid_set(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colColor, i, currentColor);
		ds_grid_set(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colInFilter, i, currentInFilter);
		ds_grid_set(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colAlign, i, currentAlign);
	
	}

	var previousCliqueID = -1;
	var cliqueDisplayGridHeight = ds_grid_height(obj_chain.cliqueDisplayGrid);
	for (var i = 0; i < cliqueDisplayGridHeight; i++) {
		if (i >= ds_grid_height(obj_chain.cliqueDisplayGrid)) {
			continue;
		}
	
		var currentCliqueID = ds_grid_get(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colChainID, i);
		var currentUnitIDList = ds_grid_get(obj_chain.cliqueDisplayGrid, obj_chain.chainGrid_colWordIDList, i);
	
		if (currentUnitIDList == 0 or currentCliqueID == previousCliqueID) {
			scr_gridDeleteRow(obj_chain.cliqueDisplayGrid, i);
			i--;
		}
	}


}
