

function scr_setChainAutoTags(chainID, chainSubMap){
	
	var tagMap = ds_map_find_value(chainSubMap, "tagMap");
	if (!is_numeric(tagMap)) exit;
	if (!ds_exists(tagMap, ds_type_map)) exit;
	
	var vizSetIDList = ds_map_find_value(chainSubMap, "vizSetIDList");
	var vizSetIDListSize = ds_list_size(vizSetIDList);
	
	// set chainSize tag
	scr_setMap(tagMap, "chainSize", vizSetIDListSize);

}