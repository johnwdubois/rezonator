// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_toggleFilter(){
	
	show_debug_message("scr_toggleFilter");
	
	var filterList = scr_getFilterList(true);
	if (!scr_isNumericAndExists(filterList, ds_type_list)) exit;
	var filterListSize = ds_list_size(filterList);
	
	if (filterListSize > 0) {
		if (obj_control.currentView != obj_control.filterView) {
			obj_control.currentView = obj_control.filterView;
			scr_renderFilter2();
		}
		else {
			scr_disableFilter();
		}
	}
	
	if (obj_control.currentView == obj_control.quickFilterView) {
		scr_disableFilter();
	}
}