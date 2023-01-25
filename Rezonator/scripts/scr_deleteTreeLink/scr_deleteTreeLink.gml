

function scr_deleteTreeLink() {
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	var linkSubMap = global.treeMap[? obj_panelPane.functionTree_treeLinkSelected];

	if (!scr_isNumericAndExists(treeSubMap, ds_type_map)) {exit;}
	if (!scr_isNumericAndExists(linkSubMap, ds_type_map)) {exit;}
	
	var sourceEntry = linkSubMap[? "source"];
	var goalEntry = linkSubMap[? "goal"];

	var sourceEntrySubMap = global.treeMap[? sourceEntry];
	scr_deleteFromList(sourceEntrySubMap[? "goalLinkList"], obj_panelPane.functionTree_treeLinkSelected);

	var goalEntrySubMap = global.treeMap[? goalEntry];
	goalEntrySubMap[? "sourceLink"] = "";
	goalEntrySubMap[? "level"] = 0;


	scr_deleteFromList(treeSubMap[? "linkIDList"],obj_panelPane.functionTree_treeLinkSelected);
	ds_map_delete(global.treeMap, obj_panelPane.functionTree_treeLinkSelected);	
	ds_map_destroy(linkSubMap);

	scr_treeRefresh(treeSubMap);

}