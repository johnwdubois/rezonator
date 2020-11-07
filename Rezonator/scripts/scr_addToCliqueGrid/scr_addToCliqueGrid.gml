function scr_addToCliqueGrid(newWordID, chainID) {

	var newUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, newWordID - 1);



	var expandingCliqueRow = -1;
	var mergeCliqueRow1 = -1;
	var mergeCliqueRow2 = -1;


	// check to see if the chain is expanding an already existing clique
	var cliqueGridHeight = ds_grid_height(obj_chain.cliqueGrid);
	for (var i = 0; i < cliqueGridHeight; i++)
	{
		var currentChainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, i);
	
		if (ds_list_find_index(currentChainIDList, chainID) > -1)
		{
			expandingCliqueRow = i;
			mergeCliqueRow1 = i;
		}
	}

	if (mergeCliqueRow1 > -1)
	{
		for (var i = 0; i < cliqueGridHeight; i++)
		{
			var currentUnitIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colUnitIDList, i);
		
			if (ds_list_find_index(currentUnitIDList, newUnitID) > -1)
			{
				mergeCliqueRow2 = i;
			}
		}
	}

	if (expandingCliqueRow >= 0 and expandingCliqueRow < ds_grid_height(obj_chain.cliqueGrid) and mergeCliqueRow2 < 0)
	{
		cliqueGridRowToRefresh = expandingCliqueRow;
		alarm[1] = 2;
		exit;
	}
	if (expandingCliqueRow >= 0 and mergeCliqueRow2 >= 0 and mergeCliqueRow2 < ds_grid_height(obj_chain.cliqueGrid) and expandingCliqueRow != mergeCliqueRow2)
	{
	
		var chainIDListMergeCliqueRow1 = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, mergeCliqueRow1);
		var chainIDListMergeCliqueRow2 = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, mergeCliqueRow2);
	
		var chainIDListMergeCliqueRow1Size = ds_list_size(chainIDListMergeCliqueRow1);
		for (var i = 0; i < chainIDListMergeCliqueRow1Size; i++)
		{
			var currentChainID = ds_list_find_value(chainIDListMergeCliqueRow1, i);
			if (ds_list_find_index(chainIDListMergeCliqueRow2, currentChainID) == -1)
			{
				ds_list_add(chainIDListMergeCliqueRow2, currentChainID);
			}
		}
	
		ds_list_sort(chainIDListMergeCliqueRow2, true);
	
		scr_gridDeleteRow(obj_chain.cliqueGrid, mergeCliqueRow1);
		// Added to prevent ghost Cliques
		scr_gridDeleteRow(obj_chain.cliqueDisplayGrid, mergeCliqueRow1);
		cliqueGridRowToRefresh = mergeCliqueRow2;
		alarm[1] = 2;
		exit;
	}
	else if (mergeCliqueRow2 >= 0 and mergeCliqueRow2 < ds_grid_height(obj_chain.cliqueGrid))
	{
		cliqueGridRowToRefresh = mergeCliqueRow2;
		alarm[1] = 2;
		exit;
	}



	// if newUnitID falls into the range of an already existing clique, we add chainID
	// to that clique and refresh
	for (var i = 0; i < cliqueGridHeight; i++)
	{
		var currentRangeStart = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeStart, i);
		var currentRangeEnd = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeEnd, i);
	
		if (newUnitID >= currentRangeStart and newUnitID <= currentRangeEnd)
		{
			var currentChainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, i);
		
			if (ds_list_find_index(currentChainIDList, chainID) == -1)
			{
				ds_list_add(currentChainIDList, chainID);
				ds_list_sort(currentChainIDList, true);
			
				cliqueGridRowToRefresh = i;
				alarm[1] = 2;
			
			}
		
			exit;
		}
	}



	// if newUnitID is not in range of other cliques, we test if it can start a new clique
	var rezChainGridHeight = ds_grid_height(obj_chain.rezChainGrid);
	for (var i = 0; i < rezChainGridHeight; i++)
	{
		var currentChainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, i);
		var currentWordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, i);
	
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize; j++)
		{
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		
			if (newUnitID == currentUnitID and newWordID != currentWordID and chainID != currentChainID)
			{	
				if(obj_chain.cliqueIDCounter == undefined){
					obj_chain.cliqueIDCounter = 0;
				}
				obj_chain.cliqueIDCounter ++;
			
				ds_grid_resize(obj_chain.cliqueGrid, obj_chain.cliqueGridWidth, ds_grid_height(obj_chain.cliqueGrid) + 1);
				ds_grid_resize(obj_chain.cliqueDisplayGrid, obj_chain.chainGridWidth, ds_grid_height(obj_chain.cliqueDisplayGrid) + 1);
				var currentCliqueGridRow = ds_grid_height(obj_chain.cliqueGrid) - 1;
			
				var unitIDList = ds_list_create();
				var chainIDList = ds_list_create();
				ds_list_add(chainIDList, chainID);
				ds_list_add(chainIDList, currentChainID);
				ds_list_sort(chainIDList, true);
			
				var cliqueBreak = false;
				var cliqueName = "Clique " + string(obj_chain.cliqueIDCounter);
			
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colCliqueID, currentCliqueGridRow, obj_chain.cliqueIDCounter);
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, currentCliqueGridRow, chainIDList);
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colUnitIDList, currentCliqueGridRow, unitIDList);
			
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colBreak, currentCliqueGridRow, cliqueBreak);
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colName, currentCliqueGridRow, cliqueName);
			
				scr_cliqueGridRefreshUnitIDList(currentCliqueGridRow);
			
				var cliqueRangeStart = ds_list_find_value(unitIDList, 0);
				var cliqueRangeEnd = ds_list_find_value(unitIDList, ds_list_size(unitIDList) - 1);
				var cliqueLength = ds_list_size(unitIDList);
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeStart, currentCliqueGridRow, cliqueRangeStart);
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeEnd, currentCliqueGridRow, cliqueRangeEnd);
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colFlankLeft, currentCliqueGridRow, -1);
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colFlankRight, currentCliqueGridRow, -1);
			
				ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colLength, currentCliqueGridRow, cliqueLength);
			
			
				exit;
			}
		}
	}

	for (var i = 0; i < cliqueGridHeight; i++)
	{
		var currentChainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, i++);
		if (ds_list_size(currentChainIDList) < 2)
		{
			scr_gridDeleteRow(obj_chain.cliqueGrid, i);
			i--;
		}
	}


}
