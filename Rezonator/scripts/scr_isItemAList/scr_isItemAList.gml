var grid = argument0;
var col = argument1;
var row = argument2;

var currentCell = ds_grid_get(grid, col, row);
var itemList = -1;

if (grid == obj_control.unitGrid) {
	if (col == obj_control.unitGrid_colWordIDList) {
		itemList = currentCell;
	}
}
else if (grid == obj_control.filterGrid) {
	if (col == obj_control.lineGrid_colWordIDList) {
		itemList = currentCell;
	}
}
else if (grid == obj_control.lineGrid) {
	if (col == obj_control.lineGrid_colWordIDList) {
		itemList = currentCell;
	}
}
else if (grid == obj_control.dynamicWordGrid) {
	if (col == obj_control.dynamicWordGrid_colInChainList) {
		itemList = currentCell;
	}
	else if (col == obj_control.dynamicWordGrid_colInBoxList) {
		itemList = currentCell;
	}
}

else if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid or grid == obj_chain.stackChainGrid or grid == obj_chain.cliqueDisplayGrid or grid == obj_chain.placeChainGrid or grid == obj_chain.chunkGrid) {
	if (col == obj_chain.chainGrid_colWordIDList) {
		itemList = currentCell;
	}
	if (grid == obj_chain.chunkGrid) {
		if (col == obj_chain.chunkGrid_colBoxWordIDList) {
			itemList = currentCell;
		}
	}
}
/*else if (grid == obj_chain.chunkGrid) {
	if (col == obj_chain.chunkGrid_colBoxWordIDList) {
		itemList = currentCell;
	}
}*/
else if (grid == obj_control.searchGrid) {
	if (col == obj_control.searchGrid_colHitIDList) {
		itemList = currentCell;
	}
}
else if (grid == obj_chain.unitInStackGrid) {
	//if (col == obj_chain.unitInStackGrid_colStack) {
	//	itemList = currentCell;
	//}
}
else if (grid == obj_chain.cliqueGrid) {
	if (col == obj_chain.cliqueGrid_colChainIDList or col == obj_chain.cliqueGrid_colUnitIDList) {
		itemList = currentCell;
	}
}
else if (grid == global.fileLineRipGrid) {
	if (col == global.fileLineRipGrid_colFileLineRipList
	or col == global.fileLineRipGrid_colParticipantList
	or col == global.fileLineRipGrid_colColorList) {
		itemList = currentCell;
	}
}



if (itemList == -1) {
	return false;
}
else {
	return true;
}