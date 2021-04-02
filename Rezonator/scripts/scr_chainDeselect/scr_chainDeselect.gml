function scr_chainDeselect() {
	
	show_debug_message("scr_chainDeselect()");
	obj_chain.currentFocusedChainID = "";
	
	ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
	
	// if there is a chain being shown in chainContents, we will make sure it does not have a focused entry
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			if (ds_map_exists(global.nodeMap, functionChainContents_chainID)) {
				var chainContentsChainSubMap = ds_map_find_value(global.nodeMap, functionChainContents_chainID);
				if (is_numeric(chainContentsChainSubMap)) {
					if (ds_exists(chainContentsChainSubMap, ds_type_map)) {
						ds_map_replace(chainContentsChainSubMap, "focused", "");
					}
				}
			}
		}
		functionChainContents_showID = "";
	}
	
	

}
