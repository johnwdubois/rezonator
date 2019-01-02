if (global.fileSaveName == "undefined" or not file_exists(global.fileSaveName))
{
	global.fileSaveName = get_save_filename("REZ file|*.rez", "");

	if (global.fileSaveName == "" or global.fileSaveName == "undefined")
	{
		global.fileSaveName = "undefined";
		show_message("Error in saving: fileSaveName == " + string(global.fileSaveName));
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
		var mapCliqueGrid = scr_gridToJSONLists(cliqueGrid);
		

		ds_map_add_list(map, "linkGrid", mapLinkGrid);
		ds_map_add_list(map, "rezChainGrid", mapRezChainGrid);
		ds_map_add_list(map, "trackChainGrid", mapTrackChainGrid);
		ds_map_add_list(map, "stackChainGrid", mapStackChainGrid);
		ds_map_add_list(map, "unitInStackGrid", mapUnitInStackGrid);
		ds_map_add_list(map, "cliqueGrid", mapCliqueGrid);
		
		ds_map_add(map, "chainColorID1", chainColorID[1]);
		ds_map_add(map, "chainColorID2", chainColorID[2]);
		ds_map_add(map, "chainColorID3", chainColorID[3]);
	}
	
}

var wrapper = ds_map_create();
ds_map_add_list(wrapper, "ROOT", rootList);

var jsonString = json_encode(wrapper);

scr_saveFileBuffer(working_directory + filename_name(global.fileSaveName), global.fileSaveName, jsonString);

ds_map_destroy(wrapper);

scr_exportGrids();