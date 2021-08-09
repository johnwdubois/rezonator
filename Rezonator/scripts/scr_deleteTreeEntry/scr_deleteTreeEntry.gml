// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteTreeEntry(){
	
	
	obj_control.deleteEntryPressed = true;
	show_debug_message(string(obj_chain.currentFocusedEntryID))
	if(obj_chain.currentFocusedEntryID == "") {
		exit;
	}
	
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	
	var treeLinkList = treeSubMap[?"linkIDList"];
	var sourceEntryID = "";
	var indexOfLink = -1;
	var goalLinkList = -1;
	
	var focusedEntrySubMap = global.treeMap[? obj_chain.currentFocusedEntryID];
	if(scr_isNumericAndExists(focusedEntrySubMap,ds_type_map)){
		var linkID = focusedEntrySubMap[? "sourceLink"];
		var focusedGoalLinkList = focusedEntrySubMap[? "goalLinkList"];
		
		var linkSubMap = global.treeMap[? linkID];
		//if a source link exists
		if(scr_isNumericAndExists(linkSubMap,ds_type_map)){
			sourceEntryID = linkSubMap[? "source"];
			var sourceEntrySubMap = global.treeMap[? sourceEntryID];
		
			goalLinkList = sourceEntrySubMap[? "goalLinkList"];
		
			//delete from source node goal list
			scr_deleteFromList(goalLinkList, linkID);
		
			//delete from tree node link list
			scr_deleteFromList(treeLinkList, linkID);
			ds_map_delete(global.treeMap, linkID);	
			ds_map_destroy(linkSubMap);
		}
		
		
		
		var focusedGoalLinkListSize = ds_list_size(focusedGoalLinkList);
		for(var i = 0 ; i < focusedGoalLinkListSize; i++){
			var currentGoalLink = focusedGoalLinkList[| i];
			var currentGoalLinkSubMap = global.treeMap[? currentGoalLink];
			
			if(scr_isNumericAndExists(currentGoalLinkSubMap,ds_type_map)){
				
				/*
				var goalEntry =  currentGoalLinkSubMap[? "goal"];
				var goalEntrySubMap = global.treeMap[? goalEntry];
				goalEntrySubMap[? "level"] = goalEntrySubMap[? "level"] -1;
				*/
				
				if(sourceEntryID != ""){
					/*
					currentGoalLinkSubMap[? "source"] = sourceEntryID;
					scr_addToListOnce(goalLinkList, currentGoalLink);
					*/
					currentGoalLinkSubMap[? "source"] = "";
					var currentGoalEntry = currentGoalLinkSubMap[? "goal"];
					var currentGoalEntrySubMap = global.treeMap[?currentGoalEntry];
					currentGoalEntrySubMap[? "sourceLink"] = "";
					currentGoalEntrySubMap[? "level"] = 0;
					//scr_addToListOnce(goalLinkList, currentGoalLink);
					scr_deleteFromList(treeLinkList, currentGoalLink);
					ds_map_delete(global.treeMap, currentGoalLink);
					ds_map_destroy(currentGoalLinkSubMap);
					
				}
				else{
					//delete all goals node goal list if it had no source
					
					// if we're deleting a root, let's delete all of its goal links
					for (var j = 0; j < focusedGoalLinkListSize; j++) {
						var currentGoalLinkDelete = focusedGoalLinkList[| j];
						var currentGoalLinkDeleteSubMap = global.treeMap[? currentGoalLinkDelete];
						if(!scr_isNumericAndExists(currentGoalLinkDeleteSubMap, ds_type_map)){exit;}
						var currentGoalLinkDeleteEntry = currentGoalLinkDeleteSubMap[? "goal"];
						var currentGoalLinkDeleteEntrySubMap = global.treeMap[? currentGoalLinkDeleteEntry];
						ds_map_delete(global.treeMap, currentGoalLinkDelete);
						ds_map_destroy(currentGoalLinkDeleteSubMap);
						scr_deleteFromList(treeLinkList, currentGoalLink);
						currentGoalLinkDeleteEntrySubMap[? "sourceLink"] = "";
						show_debug_message("currentGoalLinkDeleteEntry: " + string(currentGoalLinkDeleteEntry));
					}
					

					//delete from tree node link list
					scr_deleteFromList(treeLinkList, currentGoalLink);
					ds_map_destroy(currentGoalLinkSubMap);
				}
			}
		}
		
		focusedEntrySubMap[? "level"] = -1;
		focusedEntrySubMap[? "sourceLink"] = "";
		ds_list_clear(focusedGoalLinkList);
	}
	if(sourceEntryID != ""){
		obj_chain.currentFocusedEntryID = sourceEntryID;
	}
	else{
		obj_chain.currentFocusedEntryID = "";
	}
	
	scr_treeRefresh(treeSubMap);
	
	
}