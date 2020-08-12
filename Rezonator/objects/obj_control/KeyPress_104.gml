show_message("mapSize: " + string(ds_map_size(global.tokenImportTagMap)));
for (var i = 0; i < ds_map_size(global.tokenImportTagMap); i++;){
	var mapKey = ds_list_find_value(global.tokenImportColNameList, i);
	var mapVal = ds_map_find_value(global.tokenImportTagMap, mapKey);
	show_message(string(mapKey) + ": " + string(mapVal) + "..." + scr_getStringOfList(mapVal));
}