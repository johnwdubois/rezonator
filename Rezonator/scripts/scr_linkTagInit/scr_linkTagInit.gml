// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_linkTagInit(){
	
	// initialize chain/entry field map
	global.linkFieldMap = ds_map_create();

	global.linkFieldMap[?"type"] =  "map";
	
	ds_map_add_map(global.nodeMap,"linkFieldMap",global.linkFieldMap);

	
	ds_list_add(global.nodeMap[?"nodeList"], "linkFieldMap");
	
	// list of all of the chain/entry level fields
	global.linkFieldList = ds_list_create();
	
	// entityType (chain-level)
	var linkTypeTagSet = ds_list_create();
	var linkTypeShortcutSet = ds_list_create();
	ds_list_add(linkTypeTagSet, "person", "location", "organization", "thing", "event", "abstract", "substance", "quantity", "number", "date/time", "animal", "plant");
	ds_list_add(linkTypeShortcutSet, "P", "L", "O", "T", "E", "A", "S", "Q", "N", "D", "M", "");
	scr_addToChainFieldMap(global.linkFieldMap, "linkType", linkTypeTagSet, linkTypeShortcutSet, true, true, true);


}