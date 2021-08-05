// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_combineLeafs(leafList){
	show_debug_message("combineLeafs CAllED!")
	if(!scr_isNumericAndExists(leafList,ds_type_list)){exit;}
	
	var leafListSize = ds_list_size(leafList);
	show_debug_message("leafListSize: "+ string(leafList));
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	if(leafListSize > 0){
		var firstEntry = leafList[| 0];
		var firstEntrySubMap = global.treeMap[? firstEntry];
		var firstEntryTokenList = firstEntrySubMap[? "tokenList"];
	
		for(var i = 1; i < leafListSize; i++){
			var currentEntry = leafList[|i];
			var currentEntrySubMap = global.treeMap[?currentEntry];
			if(!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)){continue;}
			if(currentEntrySubMap[? "level"] > -1){exit;}
			var currentEntryTokenList = currentEntrySubMap[? "tokenList"];
			var currentEntryTokenListSize = ds_list_size(currentEntryTokenList);
			for(var j = 0; j < currentEntryTokenListSize; j ++){	
				ds_list_add(firstEntryTokenList,currentEntryTokenList[|j]);
			}
			scr_deleteFromList(treeSubMap[? "setIDList"], currentEntry);
			ds_map_delete(global.treeMap, currentEntry);
		}
	}
}