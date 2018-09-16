if (global.fileSaveName == "undefined" or not file_exists(global.fileSaveName))
{
	global.fileSaveName = get_save_filename("REZ file|*.rez", "");

	if (global.fileSaveName == "" or global.fileSaveName == "undefined")
	{
		global.fileSaveName = "undefined";
		exit;
	}
}

var rootList = ds_list_create();

with (obj_saveParent)
{
	var map = ds_map_create();
	ds_list_add(rootList, map);
	ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);
	
	var mapObjectIndex = object_get_name(object_index);
	ds_map_add(map, "objectIndex", mapObjectIndex);
	
	if (object_index == obj_control)
	{
		var mapFileLineRipGrid = scr_gridToJSONLists(global.fileLineRipGrid);
		var mapWordGrid = scr_gridToJSONLists(wordGrid);
		var mapDynaWordGrid = scr_gridToJSONLists(dynamicWordGrid);
		var mapWordDrawGrid = scr_gridToJSONLists(wordDrawGrid);
		var mapUnitGrid = scr_gridToJSONLists(unitGrid);
		var mapLineGrid = scr_gridToJSONLists(lineGrid);
		
		ds_map_add_list(map, "fileLineRipGrid", mapFileLineRipGrid);
		ds_map_add_list(map, "wordGrid", mapWordGrid);
		ds_map_add_list(map, "dynaWordGrid", mapDynaWordGrid);
		ds_map_add_list(map, "wordDrawGrid", mapWordDrawGrid);
		ds_map_add_list(map, "unitGrid", mapUnitGrid);
		ds_map_add_list(map, "lineGrid", mapLineGrid);
	}
	else if (object_index == obj_chain)
	{
		var mapLinkGrid = scr_gridToJSONLists(linkGrid);
		var mapRezChainGrid = scr_gridToJSONLists(rezChainGrid);
		var mapTrackChainGrid = scr_gridToJSONLists(trackChainGrid);
		var mapStackChainGrid = scr_gridToJSONLists(stackChainGrid);
		var mapUnitInStackGrid = scr_gridToJSONLists(unitInStackGrid);
		
		ds_map_add_list(map, "linkGrid", mapLinkGrid);
		ds_map_add_list(map, "rezChainGrid", mapRezChainGrid);
		ds_map_add_list(map, "trackChainGrid", mapTrackChainGrid);
		ds_map_add_list(map, "stackChainGrid", mapStackChainGrid);
		ds_map_add_list(map, "unitInStackGrid", mapUnitInStackGrid);
	}
	
}

var wrapper = ds_map_create();
ds_map_add_list(wrapper, "ROOT", rootList);

var jsonString = json_encode(wrapper);

scr_saveFileBuffer(global.fileSaveName, jsonString);

ds_map_destroy(wrapper);