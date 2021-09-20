// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_updateChainShowMap(chainID, inEntryList){
	
	var chainShowMapList = obj_chain.chainShowMap[? chainID];
	if (!scr_isNumericAndExists(chainShowMapList, ds_type_list)) {
		chainShowMapList = ds_list_create();
		ds_map_add_list(obj_chain.chainShowMap, chainID, chainShowMapList);
	}
	var entryListSize = ds_list_size(inEntryList);
	for (var i = 0; i < entryListSize; i++) {
		scr_addToListOnce(chainShowMapList, inEntryList[| i]);
	}
	
}