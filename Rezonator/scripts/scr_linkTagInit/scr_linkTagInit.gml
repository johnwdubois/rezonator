// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_linkTagInit(){
	
	// initialize chain/entry field map
	global.linkFieldMap = ds_map_create();

	global.linkFieldMap[?"type"] =  "map";
	
	ds_map_add_map(global.nodeMap,"linkTagMap",global.linkFieldMap);

	
	ds_list_add(global.nodeMap[?"nodeList"], "linkTagMap");
	
	// list of all of the chain/entry level fields
	global.linkFieldList = ds_list_create();
	
	ds_map_add_list(global.nodeMap,"linkFieldList",global.linkFieldList);
	
	// DepRel
	ds_list_add(global.linkFieldList, "Dep");
	var linkTypeSubMap = ds_map_create();
	ds_map_add_map(global.linkFieldMap, "Dep", linkTypeSubMap);
	var linkTypeTagSet = ds_list_create();
	ds_list_add(linkTypeTagSet, "Pred", "Arg", "Adjunct", "X", "n/a");
	ds_map_add_list(linkTypeSubMap, "tagSet", linkTypeTagSet);
	
	
	
}