function scr_deadLinkFocusCheck() {
	// Find the dead, focused link
	var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, true);
	if (rowInLinkGridSource != -1) {

		// Unfocus the dead link
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGridSource, false);
		// Identify the relevant chain
		var currentChainID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, rowInLinkGridSource);
		if(obj_control.gridInDelete == undefined) {
			obj_control.gridInDelete = obj_chain.currentChainGrid;
			//show_message(string(obj_control.gridInDelete));
		}
		var rowInChainGrid = ds_grid_value_y(obj_control.gridInDelete, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_control.gridInDelete)-1, currentChainID);
		if (rowInChainGrid != -1) {
			//show_message(string(currentChainID));
		
			var firstWordID = ds_list_find_value(ds_grid_get(obj_control.gridInDelete, obj_chain.chainGrid_colWordIDList, rowInChainGrid),0);
			if(obj_control.currentActiveLineGrid == obj_control.searchGrid) {
				if(ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid), firstWordID) >= 0)	{
					var rowInLinkGridToFocus = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentChainID, obj_chain.linkGrid_colDead, false, obj_chain.linkGrid_colSource, firstWordID);
					if (rowInLinkGridToFocus != -1) {
						// If the chain contains a living link, focus the one it found
						ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGridToFocus, true);
					}	
				}
			}
			else {
	
				// Check this chain for live links
				var rowInLinkGridToFocus = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentChainID, obj_chain.linkGrid_colDead, false, obj_chain.linkGrid_colSource, firstWordID);
				if (rowInLinkGridToFocus != -1) {
					// If the chain contains a living link, focus the one it found
					ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGridToFocus, true);
				}
			}
		}
	}


}
