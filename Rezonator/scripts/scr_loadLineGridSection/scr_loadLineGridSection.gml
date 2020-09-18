function scr_loadLineGridSection() {
	var lineGridHeight = 0;
	while (ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitID, lineGridHeight) >= 0) {
		lineGridHeight++;
	}

	var wordGridHeight = 0;
	while (ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, wordGridHeight) >= 0) {
		wordGridHeight++;
	}

	ds_grid_resize(obj_control.lineGrid, obj_control.lineGridWidth, lineGridHeight);
	//ds_grid_resize(obj_control.unitGrid, global.unitGridWidth, lineGridHeight);
	//ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, wordGridHeight);
	//ds_grid_resize(obj_control.dynamicWordGrid, obj_control.dynamicWordGridWidth, wordGridHeight);
	ds_grid_resize(obj_control.wordDrawGrid, obj_control.wordDrawGridWidth, wordGridHeight);
	//ds_grid_clear(obj_control.wordDrawGrid, 0);


	var lineGridHeight = ds_grid_height(obj_control.lineGrid);
	for (var i = 0; i < lineGridHeight; i++) {
	
		var currentRowLineGrid = i;
		var currentUnitID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitID, i);
		var currentUnitWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, i);
		var currentDiscoID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, i);
		var currentUtteranceID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, i);
		var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, i);
		var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, i);
	
		var currentLineY = (currentUnitID - 1) * obj_control.gridSpaceVertical;
	
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, currentRowLineGrid, currentRowLineGrid);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, currentRowLineGrid, currentUnitWordIDList);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, currentRowLineGrid, 0);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitID, currentRowLineGrid, currentUnitID);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, currentRowLineGrid, currentLineY);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, currentRowLineGrid, currentLineY);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDiscoID, currentRowLineGrid, currentDiscoID);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, currentRowLineGrid, currentUtteranceID);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colAlignedWordID, currentRowLineGrid, ds_list_find_value(currentUnitWordIDList, 0));
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, currentRowLineGrid, currentUnitStart);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitEnd, currentRowLineGrid, currentUnitEnd);
	}


}
