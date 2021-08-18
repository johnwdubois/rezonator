// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteTreeBranch(){
	show_debug_message("scr_deleteTreeBranch  called....");
	
	//get tree entry lists
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	var treeSetIDList = treeSubMap[?"setIDList"];

	
	//get token list of selected entry
	var selectedEntry = obj_control.rightClickID;
	var selectedEntrySubMap = global.treeMap[? selectedEntry];
	
	
	//time to delete source link if there is one to detach from tree
	var sourceLink = selectedEntrySubMap[? "sourceLink"];
	var linkSubMap = global.treeMap[? sourceLink];
	if(scr_isNumericAndExists(linkSubMap, ds_type_map)){
	
		var sourceEntry = linkSubMap[? "source"];
		var goalEntry = linkSubMap[? "goal"];

		var sourceEntrySubMap = global.treeMap[? sourceEntry];
		if(scr_isNumericAndExists(sourceEntrySubMap, ds_type_map)){
			scr_deleteFromList(sourceEntrySubMap[? "goalLinkList"], sourceLink);
		}

		scr_deleteFromList(treeSubMap[? "linkIDList"], sourceLink);
		ds_map_delete(global.treeMap, sourceLink);	
		ds_map_destroy(linkSubMap);
	}
	
	scr_resetTreeLevel(selectedEntry)
	
	
	scr_treeRefresh(treeSubMap);
	obj_chain.currentFocusedEntryID = "";
	
}