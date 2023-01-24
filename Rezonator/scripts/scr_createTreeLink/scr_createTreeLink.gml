

function scr_createTreeLink(clickedEntry){

	
	var clickedEntrySubMap = global.treeMap[? clickedEntry];
	var focusedEntrySubMap = global.treeMap[? obj_chain.currentFocusedEntryID];
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	
	show_debug_message("clickedEntry: " + string(clickedEntry));
	show_debug_message("currentFocusedEntryID: " + string(obj_chain.currentFocusedEntryID));
	
	show_debug_message("clickedEntrySubMap: " + json_encode(clickedEntrySubMap));
	show_debug_message("focusedEntrySubMap: " + json_encode(focusedEntrySubMap));

	//create Link node for Tree
	var linkID = scr_generateRandomID();
	var linkMap = ds_map_create();
	
	//set source and goal
	ds_map_add(linkMap, "type", "treeLink");
	ds_map_add(linkMap, "subtype", "tree");
	ds_map_add(linkMap, "source", obj_chain.currentFocusedEntryID);
	ds_map_add(linkMap, "goal", clickedEntry);
	
	// give the link a tag map
	ds_map_add_map(linkMap, "tagMap", ds_map_create());
	
	//add link node to treeeeee map
	ds_map_add_map(global.treeMap, linkID,linkMap);
	
	//add clicked entry to focused entry goal list
	var goalLinkList = focusedEntrySubMap[? "goalLinkList"];
	ds_list_add(goalLinkList, linkID);
	
	//update clicked entry sub map
	clickedEntrySubMap[? "sourceLink"] = linkID;
	clickedEntrySubMap[? "level"] = focusedEntrySubMap[?"level"]+1;
	
	//update tree subamp
	ds_list_add(treeSubMap[?"linkIDList"], linkID);
	
	// big tree achievement
	if(global.steamAPI){
		var currentMaxTreeHeight = steam_get_stat_int("SA_tree-height");
		var currentTreeHeight = clickedEntrySubMap[? "level"];
		
		show_debug_message("currentTreeHeight: " + string(currentTreeHeight) + ", currentMaxTreeHeight: " + string(currentMaxTreeHeight));
		if (currentTreeHeight > currentMaxTreeHeight) {
			steam_set_stat_int("SA_tree-height", currentTreeHeight);
			if (steam_get_stat_int("SA_tree-height") >= 10) {
				if (!steam_get_achievement("SA_tree-10")) {
					steam_set_achievement("SA_tree-10");
				}
			}
		}
	}
}