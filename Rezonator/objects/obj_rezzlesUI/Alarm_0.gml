with (obj_panelPane) {
	functionChainList_currentTab = functionChainList_tabShow;
	var showList = global.nodeMap[? "showList"];
	if (scr_isNumericAndExists(showList, ds_type_list)) {
		functionChainContents_showID = showList[| 0];
		var showSubMap = global.nodeMap[? functionChainContents_showID];
		var setList = showSubMap[? "setIDList"];
		
		scr_setValueForAllChains("stack","movesMade", 0);
		obj_chain.increaseStack = false;
					
		if (scr_isNumericAndExists(setList, ds_type_list)) {
								
			functionChainList_playShowID = functionChainContents_showID;
									
			scr_setValueForAllChains("stack","filter", false);
			// Filter the first current stack
			var currentStackID = ds_list_find_value(setList, 0);
			if (ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1) {
				ds_list_add(obj_chain.filteredStackChainList,currentStackID);
				var chainSubMap = ds_map_find_value(global.nodeMap,currentStackID);
				if (scr_isNumericAndExists(chainSubMap,ds_type_map)) {
					chainSubMap[? "filter"] = true;
				}
			}
		}
		// Render the filter in the mainscreen
		with (obj_control) {
			scr_renderFilter2();
		}
	}
}