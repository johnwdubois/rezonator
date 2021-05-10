function scr_chainDeselect() {
	
	show_debug_message("scr_chainDeselect()");
	obj_chain.currentFocusedChainID = "";
	
	// if there is a chain being shown in chainContents, we will make sure it does not have a focused entry
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			if (ds_map_exists(global.nodeMap, functionChainContents_chainID)) {
				var chainContentsChainSubMap = global.nodeMap[? functionChainContents_chainID];
				if (scr_isNumericAndExists(chainContentsChainSubMap, ds_type_map)) {
					chainContentsChainSubMap[? "focused"] = "";
				}
			}
		}
		functionChainContents_showID = "";
	}
	
	

}
