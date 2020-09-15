
// Find the link that is in focus
var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, false);
show_debug_message("scr_deleteLink(), rowInLinkGridSource: " + string(rowInLinkGridSource));

if (rowInLinkGridSource == -1) {
	show_debug_message("scr_deleteLink(), rowInLinkGridSource == -1, exiting... ");
	exit;
}

// Access information on focused link
var chainID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, rowInLinkGridSource);
obj_control.currentChainGridRowInDelete = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.currentChainGrid), chainID);
var tier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowInLinkGridSource);
var dead = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource);
	
if (dead) {
	exit;
}
	
// This kills the link
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource, true);
	
// Aquire info on the link's source
var source = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridSource);
var sourceInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, source - 1);
var indexOfChainIDInChainsList = ds_list_find_index(sourceInChainsList, chainID);
if (indexOfChainIDInChainsList > -1) {
	// Delete this chain from the source's inChainList
	ds_list_delete(sourceInChainsList, indexOfChainIDInChainsList);
		
	obj_control.moveCounter ++;
}
	
// Reset the alignment of the unchained word
if (source >= 0 and source < ds_grid_height(obj_control.dynamicWordGrid) and tier == 1) {
	if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, source - 1)) {
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, source - 1, false);
	}
		
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, source - 1, true);
}
	
var rowInLinkGridGoal = -1;
var newSource = -1;
var newGoal = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, rowInLinkGridSource);
	
// If possible, create a new link between the source's source and goal
if (scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, source, obj_chain.linkGrid_colChainID, chainID) > -1) {
	rowInLinkGridGoal = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, source, obj_chain.linkGrid_colChainID, chainID, obj_chain.linkGrid_colDead, false);
	newSource = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridGoal);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridGoal, true);
		
}
	
//show_message(string(newSource) + "," + string(newGoal))
	
//Repeat the above process, but for Stacks
if (tier == 3) {
	var rowInUnitInStackGrid = ds_grid_value_y(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colUnitID, 0, obj_chain.unitInStackGrid_colUnitID, ds_grid_height(obj_chain.unitInStackGrid), source);
		
	if (rowInUnitInStackGrid < 0 or rowInUnitInStackGrid >= ds_grid_height(obj_chain.unitInStackGrid)) {
		exit;
	}
		
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, rowInUnitInStackGrid, -1);
	ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, rowInUnitInStackGrid, -1);

	// If there is a new source, find its UnitID
	if (newSource > 0) {
		var idListNewSource = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, newSource - 1);
			
		if not (idListNewSource == undefined) {
			if (ds_list_size(idListNewSource) > 0) {
				newSource = ds_list_find_value(idListNewSource, 0);
			}
		}
	}
	// Why was the goal being set to a word ID also???
	// If there is a new goal, find its UnitID
	/*if (newGoal > 0) {
		var idListNewGoal = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, newGoal - 1);
			
		if not (idListNewGoal == undefined) {
			if (ds_list_size(idListNewGoal) > 0) {
				newGoal = ds_list_find_value(idListNewGoal, 0);
			}
		}
	}*/
}
	
	
// If there is a new source and goal, create the new link
if not (newSource == -1 or newSource == undefined or newGoal == undefined) {
	with (obj_chain) {
		scr_newLink(newSource, newGoal);
	}
}
	
// Take away the unchained word's fillRect
if not (source == undefined) {
	ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, source - 1, false);
}