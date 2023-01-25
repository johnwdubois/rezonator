

function scr_toggleFilterForAllChains(chainType) {
	
	// get list of chains & list of filtered chains for this specific chain type
	var listOfChains = -1;
	var listOfFilteredChains = -1;
	if (chainType == "resonance") {
		listOfChains = ds_map_find_value(global.nodeMap, "resonanceList");
		listOfFilteredChains = obj_chain.filteredRezChainList;
	}
	else if (chainType == "trail") {
		listOfChains = ds_map_find_value(global.nodeMap, "trailList");
		listOfFilteredChains = obj_chain.filteredTrackChainList;
	}
	else if (chainType == "stack") {
		listOfChains = ds_map_find_value(global.nodeMap, "stackList");
		listOfFilteredChains = obj_chain.filteredStackChainList;
	}
	else {
		show_debug_message("scr_toggleFilterForAllChains() ... invalid chainType: " + string(chainType) + ", exiting...");
		exit;
	}
	var listOfChainsSize = ds_list_size(listOfChains);
	
	// if all chains are filtered, unfilter all of them
	if (ds_list_size(listOfFilteredChains) == listOfChainsSize) {
		show_debug_message("scr_toggleFilterForAllChains() ... unfiltering all chains of type: " + string(chainType));
		scr_setValueForAllChains(chainType, "filter", false);
	}
	// if not all of the chains are filtered, filter all of them
	else if (ds_list_size(listOfFilteredChains) >= 0) {
		show_debug_message("scr_toggleFilterForAllChains() ... filtering all chains of type: " + string(chainType));
		scr_setValueForAllChains(chainType, "filter", true);
	}
					
	// render filter!
	if (obj_control.currentView == obj_control.filterView) {
		with (obj_control) {
			scr_renderFilter2();
		}
						
		// if there is nothing filtered, we turn filter off
		var totalChainsFiltered = ds_list_size(obj_chain.filteredRezChainList) + ds_list_size(obj_chain.filteredTrackChainList) + ds_list_size(obj_chain.filteredStackChainList);
		if (totalChainsFiltered <= 0) {
			with (obj_control) {
				currentView = mainView;
				obj_toolPane.currentMode = obj_toolPane.setModeMain;
				wordLeftMarginDest = 170; // Make sure the margin is placed correctly

			}
		}
	}

}