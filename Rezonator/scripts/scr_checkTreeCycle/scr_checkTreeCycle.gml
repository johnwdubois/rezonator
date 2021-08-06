// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_checkTreeCycle(clickedEntry){
	var isCycle = false;
	
	var focusedEntrySubMap = global.treeMap[? obj_chain.currentFocusedEntryID];
	if(!scr_isNumericAndExists(focusedEntrySubMap, ds_type_map)){exit;}
	
	var sourceEntry = "";
	
	var sourceLink = focusedEntrySubMap[? "sourceLink"];
	
	//if root not found keep looking
	while(sourceLink != ""){
		
	
		var sourceLinkSubMap = global.treeMap[? sourceLink];
	
		sourceEntry = sourceLinkSubMap[?"source"];
	
		var sourceEntrySubMap = global.treeMap[? sourceEntry];
	
		sourceLink = sourceEntrySubMap[? "sourceLink"];
	
	}
	
	//check if first entry (found root) is the entry we clicked on cycle detected
	if(clickedEntry == sourceEntry){
		isCycle = true;
	}

	
	return isCycle;
}