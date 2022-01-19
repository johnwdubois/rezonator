function scr_removeSearch(searchID){



	if (!ds_map_exists(global.searchMap,searchID)) {
		show_debug_message("scr_deleteSearch()... searchID does not exists in nodeMap, exiting...");
		exit;
	}
	
	
	
	var currentSearchSubMap = global.searchMap[?searchID];




	//delete show from map
	ds_map_delete(global.searchMap,searchID);
	scr_deleteFromList(global.nodeMap[?"searchNodeList"], searchID);
	
	ds_map_destroy(currentSearchSubMap);
	
	//set active show to be nothing
	if(obj_panelPane.functionSearchList_searchSelected == searchID){
		if (obj_control.currentView == obj_control.searchView) {
			obj_control.currentView = obj_control.mainView;
			scr_disableFilter();
		}

		with(obj_panelPane){
			functionSearchList_searchSelected = "";
			functionSearchList_searchMouseover = "";
		}
	}
}