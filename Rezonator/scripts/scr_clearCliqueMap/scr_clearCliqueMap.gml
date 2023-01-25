function scr_clearCliqueMap() {
	if (scr_isNumericAndExists(global.cliqueMap, ds_type_map)) {
		for (var i = 0; i < ds_list_size(obj_chain.cliqueList); i++) {
			var cliqueID = obj_chain.cliqueList[| i];
			ds_map_destroy(global.cliqueMap[? cliqueID]);
		}
		ds_list_clear(obj_chain.cliqueList);
		ds_map_clear(global.cliqueMap);
	}
	else {
		global.cliqueMap = ds_map_create();
	}
	ds_map_add(global.cliqueMap, "type", "map");
}