// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_clearCliqueMap(){
	for(var i = 0; i < ds_list_size(obj_chain.cliqueList); i++){
		ds_map_destroy(global.cliqueMap[? obj_chain.cliqueList[|i]]);
	}
	ds_list_clear(obj_chain.cliqueList);
	ds_map_clear(global.cliqueMap);
	ds_map_add(global.cliqueMap, "type", "map")
}