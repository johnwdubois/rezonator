///@description Remove Link or Chunk

obj_control.linkDeleted = true;
// Set variables to be used by Chunk/newWord deletion
obj_control.currentChainGridRowInDelete = undefined;
obj_control.gridInDelete = undefined;
var oldHeight = -1;

// Expirementing with deleting Chunks
if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush || obj_toolPane.currentTool == obj_toolPane.toolNewWord || obj_control.newWordDeleted || obj_control.deleteNewWord || obj_control.deleteChunkWord) {
	//show_message("scr del");
	scr_deleteChunk();
	
}

// Make sure there is a focused link to be deleted
if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true)) {	

	scr_deleteLink();

}

// If this Chunk has already been deleted, refresh the chain grids
if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush || obj_toolPane.currentTool == obj_toolPane.toolNewWord || obj_control.deleteNewWord || obj_control.deleteChunkWord) {
	//show_message(obj_control.gridInDelete);	
	if(obj_control.gridInDelete != undefined) {
		ds_grid_set(obj_control.gridInDelete, obj_chain.chainGrid_colChainState, obj_control.currentChainGridRowInDelete, obj_chain.chainStateFocus);
		scr_refreshChainGrid(obj_control.gridInDelete);
		scr_killEmptyChains(obj_control.gridInDelete);
		scr_refreshVizLinkGrid();
		ds_grid_set(obj_control.gridInDelete, obj_chain.chainGrid_colChainState, obj_control.currentChainGridRowInDelete, obj_chain.chainStateNormal);
		//show_message(obj_control.gridInDelete);	
	}
	obj_chain.mouseLineWordID = -1;
	ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
	ds_grid_set_region(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid), obj_chain.chainStateNormal);
	obj_control.linkDeleted = false;
	obj_control.deleteNewWord = false;
	obj_control.deleteChunkWord = false;
	exit;	
}
// Most cases uses this boy
else {
	// Refresh and clean
	scr_refreshChainGrid();
	oldHeight = ds_grid_height(obj_chain.currentChainGrid);
	scr_killEmptyChains(obj_chain.currentChainGrid);
	obj_chain.mouseLineWordID = -1;

	scr_refreshVizLinkGrid();
	obj_control.linkDeleted = false;
}

// If we're deleting within the search screen, make sure we don't focus on words outside of the hitGrid
if(obj_control.currentActiveLineGrid == obj_control.searchGrid) {
	var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, false);
	//show_message(string(rowInLinkGridSource));
	if(rowInLinkGridSource > -1) {
		var currentSourceID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridSource);
		if(ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid), currentSourceID) < 0)	{
			//show_message(string(currentSourceID));
			ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGridSource, false);
		}
	}
}

// Check if the newly dead link is focused
if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true)) {
	
	scr_deadLinkFocusCheck();
	
}
//var newHeight = ds_grid_height(obj_chain.currentChainGrid);
// Out of comission until Jack says otherwise
/*if(oldHeight != newHeight and newHeight > 0 and not obj_toolPane.tracksOnlyStackShow) {
	if(obj_control.currentChainGridRowInDelete != 0) {
		ds_grid_set(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, obj_control.currentChainGridRowInDelete - 1, obj_chain.chainStateFocus);	
	}
	else {
		ds_grid_set(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, obj_control.currentChainGridRowInDelete, obj_chain.chainStateFocus);	
	}
}*/
obj_control.deleteNewWord = false;
obj_control.deleteChunkWord = false;