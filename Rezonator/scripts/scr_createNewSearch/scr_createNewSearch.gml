// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createNewSearch(searchTermList){
	
	var searchTermListCopy = ds_list_create();
	ds_list_copy(searchTermListCopy, searchTermList);
	// type variable should be a string that declares what "type" of Node this is
	// for example, "Chain", "Link", "Unit", etc.
	
	// generate a random number and turn it into a hex string
	var nodeKeyMin = 1000;
	var nodeKeyMax = 1000000000000000;
	var nodeKey = irandom_range(nodeKeyMin, nodeKeyMax);
	nodeKey = scr_baseConvert(nodeKey, 10, 16);
	
	// continue generating random hex strings until we find one that is not
	// already a key in the NodeMap
	while (ds_map_exists(global.nodeMap, nodeKey)) {
		nodeKey = irandom_range(nodeKeyMin, nodeKeyMax);
		nodeKey = scr_baseConvert(nodeKey, 10, 16);
	}
	
	// now that we have the key for the Node, we need its value which
	// is another sub-map. this map will contain any attributes we want
	// to attach, for example the type
	var searchNodeList = global.nodeMap[?"searchNodeList"];
	
	var sizeOfSearchList = ds_list_size(searchNodeList) + 1;
	
	var searchName = "Search " + string(sizeOfSearchList);

	// to attach, for example the type
	var subMap = ds_map_create();
	
	// add type to subMap
	ds_map_add(subMap, "type", "search");
	
	// add name to subMap
	ds_map_add(subMap, "name", searchName);
	
	// add searchTermListCopy to subMap

	ds_map_add_list(subMap, "searchTermList", searchTermListCopy);
	

	var displayUnitList = scr_getSearchUnitList(searchTermListCopy);

	// add displayUnitList to subMap
	ds_map_add_list(subMap, "displayUnitList", displayUnitList);
	
	// add Node to NodeMap
	ds_map_add_map(global.searchMap, nodeKey, subMap);
	
	//add to searchNodeList 
	ds_list_add(searchNodeList, nodeKey);
		show_debug_message("searchTermList  " + scr_getStringOfList(subMap[?"searchTermList"]));
	
}