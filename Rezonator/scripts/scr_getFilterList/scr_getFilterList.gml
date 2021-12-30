// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getFilterList(concatenate){
	
	// returns the filter list that corresponds to whatever tab you're on (rez, track, or stack)
	// returns filteredRezList by default
	
	var filterList = -1;
	if (concatenate) {
		filterList = ds_list_create();
		var filteredRezChainList = obj_chain.filteredRezChainList;
		var filteredRezChainListSize = ds_list_size(filteredRezChainList);
		for (var i = 0; i < filteredRezChainListSize; i++) ds_list_add(filterList, filteredRezChainList[| i]);
		
		var filteredTrackChainList = obj_chain.filteredTrackChainList;
		var filteredTrackChainListSize = ds_list_size(filteredTrackChainList);
		for (var i = 0; i < filteredTrackChainListSize; i++) ds_list_add(filterList, filteredTrackChainList[| i]);
		
		var filteredStackChainList = obj_chain.filteredStackChainList;
		var filteredStackChainListSize = ds_list_size(filteredStackChainList);
		for (var i = 0; i < filteredStackChainListSize; i++) ds_list_add(filterList, filteredStackChainList[| i]);
	}
	else {
		filterList = obj_chain.filteredRezChainList;
		if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush) filterList = obj_chain.filteredRezChainList;
		else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush) filterList = obj_chain.filteredTrackChainList;
		else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) filterList = obj_chain.filteredStackChainList;
		else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabShow) filterList = obj_chain.filteredStackChainList;
	}
	
	return filterList;
	
}