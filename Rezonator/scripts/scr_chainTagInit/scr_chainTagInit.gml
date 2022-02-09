

function scr_chainTagInit(){
	
	// initialize chain/entry field map
	global.chainFieldMap = ds_map_create();
	global.entryFieldMap = ds_map_create();
	
	global.chainFieldMap[?"type"] =  "map";
	global.entryFieldMap[?"type"] =  "map";
	
	ds_map_add_map(global.nodeMap,"chainTagMap",global.chainFieldMap);
	ds_map_add_map(global.nodeMap,"entryTagMap",global.entryFieldMap);
	
	ds_list_add(global.nodeMap[?"nodeList"], "chainTagMap", "entryTagMap");
	
	// list of all of the chain/entry level fields
	global.chainFieldList = ds_list_create();
	global.chainEntryFieldList = ds_list_create();
	

	
	// chainSize (chain-level)
	scr_addToChainFieldMap(global.chainFieldMap, "chainSize", undefined, true, true, true);

	// gapUnits (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "gapUnits", undefined, true, true, true);
	
	// gapWords (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "gapWords", undefined, true, true, false);
	
	// tokenCount (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "tokenCount", undefined, true, true, false);
	
	// charCount (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "charCount", undefined, true, true, false);
	
}