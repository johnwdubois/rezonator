// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_toggleFilter(){
	var filterList = scr_getFilterList();
	if (!scr_isNumericAndExists(filterList, ds_type_list)) exit;
	var filterListSize = ds_list_size(filterList);
	
	if (filterListSize > 0) {
	
		// toggle filter depending on tab
		if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush) obj_control.filterActiveRez = !obj_control.filterActiveRez;
		else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush) obj_control.filterActiveTrack = !obj_control.filterActiveTrack;
		else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) obj_control.filterActiveStack = !obj_control.filterActiveStack;
							
		// determine if filter should be activated or disabled
		obj_control.filterGridActive = (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush && obj_control.filterActiveRez)
										|| (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush && obj_control.filterActiveTrack)
										|| (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush && obj_control.filterActiveStack);
							
		if (obj_control.filterGridActive) {
					
			scr_renderFilter2();
		}
		else {
			with(obj_panelPane){
				functionChainList_playShowID = "";
			}
			scr_disableFilter();
		}
	}
	
	if (obj_control.quickFilterGridActive) {
		scr_disableFilter();
	}
}