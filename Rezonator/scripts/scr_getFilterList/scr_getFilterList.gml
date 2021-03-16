// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getFilterList(){
	
	// returns the filter list that corresponds to whatever tab you're on (rez, track, or stack)
	// returns filteredRezList by default
	
	var filterList = obj_chain.filteredRezChainList;
	if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush) filterList = obj_chain.filteredRezChainList;
	else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush) filterList = obj_chain.filteredTrackChainList;
	else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) filterList = obj_chain.filteredStackChainList;
	return filterList;
	
}