// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_removeSearch(searchID){



	if (!ds_map_exists(global.searchMap,searchID)) {
		show_debug_message("scr_deleteSearch()... searchID does not exists in nodeMap, exiting...");
		exit;
	}
	
	
	
	var currentSearchSubMap = global.searchMap[?obj_dialogueBox.searchToBeRemoved];




	//delete show from map
	ds_map_delete(global.searchMap,searchID);
	scr_deleteFromList(global.nodeMap[?"searchNodeList"], searchID);
	
	ds_map_destroy(currentSearchSubMap);
	
	//set active show to be nothing
	if(obj_panelPane.functionSearchList_searchSelected == searchID){
		if (obj_control.searchGridActive) {
			obj_control.searchGridActive = false;
			scr_disableFilter();
		}

		with(obj_panelPane){
			functionSearchList_searchSelected = "";
			functionSearchList_searchMouseover = "";
		}
	}
}