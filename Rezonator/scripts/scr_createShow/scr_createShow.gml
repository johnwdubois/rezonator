

function scr_createShow(){
	
	// create a submap for the new show, and make sure it exists
	var showKey = scr_addToNodeMap("show");
	var subMap = ds_map_find_value(global.nodeMap, showKey);
	if (!is_numeric(subMap)) exit;
	if (!ds_exists(subMap, ds_type_map)) exit;
	
	// get list of all of the shows
	var showList = ds_map_find_value(global.nodeMap, "showList");
	var showListSize = ds_list_size(showList);
	
	// get & set data for new show
	var newShowName = "Show " + string(showListSize + 1);
	var newShowSetList = ds_list_create();
	ds_map_add(subMap, "name", newShowName);
	ds_map_add_list(subMap, "setIDList", newShowSetList);
	
	
	
	// add new show to the list of all shows
	ds_list_add(showList, showKey);
	
}