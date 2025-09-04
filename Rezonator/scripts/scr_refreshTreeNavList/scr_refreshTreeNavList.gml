function scr_refreshTreeNavList(){
	
	var _treeList = global.nodeMap[? "treeList"];
	var _treeNavList = global.nodeMap[? "treeNavList"];
	
	// clear treeNavList and find every tree with the active stack layer
	ds_list_clear(_treeNavList);
	var _treeListSize = ds_list_size(_treeList);
	for (var i = 0; i < _treeListSize; i++) {
		var _treeID = _treeList[| i];
		var _treeSubMap = global.treeMap[? _treeID];
		if (!scr_isNumericAndExists(_treeSubMap, ds_type_map)) continue;
		var _treeLayer = _treeSubMap[? "layer"];
		if (_treeLayer == obj_control.activeStacking) scr_addToListOnce(_treeNavList, _treeID);
	}

}