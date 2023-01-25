

function scr_deleteTree(treeID) {
	
	var treeSubMap = global.treeMap[? treeID];
	if (!scr_isNumericAndExists(treeSubMap, ds_type_map)) {exit;}
	var linkIDList = treeSubMap[? "linkIDList"];
	var setIDList = treeSubMap[? "setIDList"];
	var linkIDListSize = ds_list_size(linkIDList);
	var setIDListSize = ds_list_size(setIDList);
	for (var i = 0 ; i < linkIDListSize; i++) {
		var currentLink = linkIDList[| i];
		var currentLinkSubMap = global.treeMap[? currentLink];
		ds_map_delete(global.treeMap, currentLink);	
		ds_map_destroy(currentLinkSubMap);
	}

	for (var i = 0 ; i < setIDListSize; i++) {
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.treeMap[? currentEntry];
		ds_map_delete(global.treeMap, currentEntry);
		ds_map_destroy(currentEntrySubMap);
	}

	var treeList = global.nodeMap[? "treeList"];
	scr_deleteFromList(treeList,treeID);
	ds_map_delete(global.treeMap, treeID);
	ds_map_destroy(treeSubMap);
}