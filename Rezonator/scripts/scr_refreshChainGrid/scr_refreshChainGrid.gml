/*
	scr_refreshChainGrid();
	
	Last Updated: 2018-09-11
	
	Called from: any object
	
	Purpose: update the chainGrid of the current selected tool, so that the chains have all the link
			information they need
	
	Mechanism: search the idLists in the chainGrid and refresh them, adding or removing ID values
				based on the information from the linkGrid
	
	Author: Terry DuBois
*/

var grid = obj_chain.rezChainGrid;

// find which grid we are dealing with (depending on current tool)
switch (obj_toolPane.currentTool) {
	case obj_toolPane.toolRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case obj_toolPane.toolTrackBrush:
		grid = obj_chain.trackChainGrid;
		break;
	case obj_toolPane.toolStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	default:
		break;
}

var idList = ds_list_create();

// find the focused chain in this grid. if there are no focused chains in this grid, exit the script
if (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus)) {
	var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	var chainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, rowInChainGrid);
}
else {
	exit;
}

// stop drawing the rectangle around the words in this chain
var oldIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
for (var i = 0; i < ds_list_size(oldIDList); i++) {
	if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid) {
		var currentID = ds_list_find_value(oldIDList, i);
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentID - 1, false);
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentID - 1, false);
	}
}


var tempGrid = ds_grid_create(ds_grid_width(obj_chain.linkGrid), ds_grid_height(obj_chain.linkGrid));
ds_grid_copy(tempGrid, obj_chain.linkGrid);

// check all links in linkGrid from this chainID, and add the living (non-dead) links to idList
while (ds_grid_value_exists(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID)) {
	var rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
	var source = ds_grid_get(tempGrid, obj_chain.linkGrid_colSource, rowInTempGrid);
	var goal = ds_grid_get(tempGrid, obj_chain.linkGrid_colGoal, rowInTempGrid);
	var dead = ds_grid_get(tempGrid, obj_chain.linkGrid_colDead, rowInTempGrid);
	
	ds_grid_set(tempGrid, obj_chain.linkGrid_colChainID, rowInTempGrid, -1);
	
	if (dead) {
		continue;
	}
	if (source == -1) {
		continue;
	}
	if (ds_list_find_index(idList, source) == -1) {
		ds_list_add(idList, source);
	}
	if (goal == -1) {
		continue;
	}
	
	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
		
		if not (chainID == undefined) {
			
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, source - 1, chainID);
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, goal - 1, chainID);
			
		}
	}
}

// sort proper list of wordIDs/unitIDs and store them back in the chainGrid
ds_list_sort(idList, true); // This causes some problems for new words, hmmm
// It should instead sort by UnitID and word sequence
ds_grid_set(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid, idList);

// draw rectangle borders around these proper wordIDs
for (var i = 0; i < ds_list_size(idList); i++) {
	if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid) {
		var currentID = ds_list_find_value(idList, i);
		var chainColor = ds_grid_get(grid, obj_chain.chainGrid_colColor, rowInChainGrid);
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentID - 1, true);
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentID - 1, chainColor);
		
		if (grid == obj_chain.rezChainGrid) {
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentID - 1, false);
		}
		else if (grid == obj_chain.trackChainGrid) {
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentID - 1, true);
		}
	}
}

ds_grid_destroy(tempGrid);