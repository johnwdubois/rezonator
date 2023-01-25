

function scr_getChainEntryFieldList(chainType) {
	
	var list = ds_list_create();
	
	// run through chainEntryFieldList and make a subset of the fields that apply to this chainType
	var chainEntryFieldListSize = ds_list_size(global.chainEntryFieldList);
	for (var i = 0; i < chainEntryFieldListSize; i++) {
		var currentField = ds_list_find_value(global.chainEntryFieldList, i);
		var currentFieldSubMap = ds_map_find_value(global.entryFieldMap, currentField);
		if (is_numeric(currentFieldSubMap)) {
			if (ds_exists(currentFieldSubMap, ds_type_map)) {
				
				var rez = ds_map_find_value(currentFieldSubMap, "rez");
				var track = ds_map_find_value(currentFieldSubMap, "track");
				var stack = ds_map_find_value(currentFieldSubMap, "card");
				
				if ((chainType == "resonance" && rez) || (chainType == "trail" && track) || (chainType == "stack" && stack)) {
					ds_list_add(list, currentField);
				}
			}
		}
	}
	
	return list;
}