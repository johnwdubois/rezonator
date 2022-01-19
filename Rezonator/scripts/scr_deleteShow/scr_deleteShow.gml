

function scr_deleteShow(showID){



	if (!ds_map_exists(global.nodeMap,showID)) {
		show_debug_message("scr_deleteShow()... ShowID does not exists in nodeMap, exiting...");
		exit;
	}
	
	
	
	var currentShowSubMap = ds_map_find_value(global.nodeMap, obj_panelPane.functionChainList_playShowID);


	// get chain's submap
	var chainSubMap = ds_map_find_value(global.nodeMap, showID);
	if (!is_numeric(chainSubMap)) {
		show_debug_message("scr_deleteShow() ... focusedEntrySubMap is non-numeric");
		exit;
	}
	if (!ds_exists(chainSubMap, ds_type_map)) {
		show_debug_message("scr_deleteShow() ... focusedEntrySubMap does not exist");
		exit;
	}

	//delete show from map
	scr_deleteFromNodeMap(showID);
	
	
	//set active show to be nothing
	obj_chain.currentFocusedshowID = "";
	
	scr_deleteFromList(ds_map_find_value(global.nodeMap, "showList"), showID);
	
		//show that is being deleted is also current show playing
	if(chainSubMap == currentShowSubMap){
		
		//get filtered stackID
		var currentFilteredChain = ds_list_find_value(obj_chain.filteredStackChainList, 0);
		
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentFilteredChain);
		
		scr_setValueForAllChains("stack", "filter", false);

		//delete show from filtered list
		scr_deleteFromList(obj_chain.filteredStackChainList, currentFilteredChain);

		scr_disableFilter();
		
	}

}