// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_initializeDiscourseTagSet(){

	var tokenTagMap = ds_map_create();
	var unitTagMap  = ds_map_create();

	var tokenListSize = ds_list_size(obj_control.tokenFieldList);

	for(var i = 0 ; i < tokenListSize; i++){
		var currentFieldMap = ds_map_create();
		ds_map_add_map(tokenTagMap, obj_control.tokenFieldList[|i], currentFieldMap);
		ds_map_add_list(currentFieldMap, "tagSet", ds_list_create());
	}


	var unitListSize = ds_list_size(obj_control.unitFieldList);

	for(var i = 0 ; i < unitListSize; i++){
		var currentFieldMap = ds_map_create();
		ds_map_add_map(unitTagMap, obj_control.unitFieldList[|i], currentFieldMap);
		ds_map_add_list(currentFieldMap, "tagSet", ds_list_create());
	}

	ds_map_add_map(global.nodeMap, "tokenTagMap", tokenTagMap);
	ds_map_add_map(global.nodeMap, "unitTagMap", unitTagMap);
	
	ds_list_add(global.nodeMap[? "nodeList"], "tokenTagMap");
	ds_list_add(global.nodeMap[? "nodeList"], "unitTagMap");
	

}