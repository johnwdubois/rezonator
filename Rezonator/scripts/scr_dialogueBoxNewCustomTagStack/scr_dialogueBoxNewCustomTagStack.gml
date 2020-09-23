function scr_dialogueBoxNewCustomTagStack() {
	// add new tag to tag list
	var mapKey = obj_panelPane.stackTagMapKey;
	var tempList = ds_map_find_value(global.stackTagMap, mapKey);
	ds_list_add(tempList, obj_control.inputText);
	
	// set tag in stackChainGrid
	ds_grid_set(obj_chain.stackChainGrid, obj_panelPane.selectedColChain, obj_panelPane.chainTagsHighlightRow, obj_control.inputText);
}
