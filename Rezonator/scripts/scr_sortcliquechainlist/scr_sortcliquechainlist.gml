function scr_sortCliqueChainList(cliqueID) {
	
	// sort the clique's chain list!
	var resonanceList = global.nodeMap[? "resonanceList"];
	var cliqueSubMap = global.cliqueMap[? cliqueID];
	var cliqueChainList = cliqueSubMap[? "chainList"];
	var cliqueChainListSize = ds_list_size(cliqueChainList);
	var cliqueSortGrid_colID = 0;
	var cliqueSortGrid_colSeq = 1;
	var cliqueSortGrid = ds_grid_create(2, cliqueChainListSize);
	for (var i = 0; i < cliqueChainListSize; i++) {
		var currentChain = cliqueChainList[| i];
		cliqueSortGrid[# cliqueSortGrid_colID, i] = currentChain;
		cliqueSortGrid[# cliqueSortGrid_colSeq, i] = ds_list_find_index(resonanceList, currentChain);
	}
	
	// sort grid and refill chainlist
	ds_grid_sort(cliqueSortGrid, cliqueSortGrid_colSeq, true);
	ds_list_clear(cliqueChainList);
	for (var i = 0; i < cliqueChainListSize; i++) {
		ds_list_add(cliqueChainList, cliqueSortGrid[# cliqueSortGrid_colID, i]);
	}
	
	
	// sort the clique's unit list!
	var cliqueUnitList = cliqueSubMap[? "unitList"];
	var cliqueUnitListSize = ds_list_size(cliqueUnitList);
	ds_grid_resize(cliqueSortGrid, 2, cliqueUnitListSize);
	for (var i = 0; i < cliqueUnitListSize; i++) {
		var currentUnit = cliqueUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		var currentUnitSeq = currentUnitSubMap[? "unitSeq"];
		cliqueSortGrid[# cliqueSortGrid_colID, i] = currentUnit;
		cliqueSortGrid[# cliqueSortGrid_colSeq, i] = currentUnitSeq;
	}
	
	// sort grid and refill unitlist
	ds_grid_sort(cliqueSortGrid, cliqueSortGrid_colSeq, true);
	ds_list_clear(cliqueUnitList);
	for (var i = 0; i < cliqueUnitListSize; i++) {
		ds_list_add(cliqueUnitList, cliqueSortGrid[# cliqueSortGrid_colID, i]);
	}
	
	// we don't need the sortgrid anymore
	ds_grid_destroy(cliqueSortGrid);

}