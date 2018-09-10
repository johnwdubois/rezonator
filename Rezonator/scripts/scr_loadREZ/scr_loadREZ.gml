var fileName = "savefile.rez";

var newInstList = ds_list_create();

if (file_exists(fileName))
{
	var wrapper = scr_loadJSONBuffer(fileName);
	var list = ds_map_find_value(wrapper, "ROOT");
	
	for (var i = 0; i < ds_list_size(list); i++)
	{
		var map = ds_list_find_value(list, i);
		
		var objectIndex = ds_map_find_value(map, "objectIndex");
		
		//show_message("objindex: " + string(objectIndex));
		
		//var instCreate = instance_create_layer(0, 0, layer, asset_get_index(objectIndex));
		
		//ds_list_add(newInstList, instCreate);
		
		with (objectIndex)
		{
			if (objectIndex == "obj_control")
			{
				currentCenterDisplayRow = 0;
				
				scr_loadREZGridReset(global.fileLineRipGrid, map, "fileLineRipGrid");
				scr_loadREZGridReset(wordGrid, map, "wordGrid");
				scr_loadREZGridReset(dynamicWordGrid, map, "dynaWordGrid");
				scr_loadREZGridReset(wordDrawGrid, map, "wordDrawGrid");
				scr_loadREZGridReset(unitGrid, map, "unitGrid");
				scr_loadREZGridReset(lineGrid, map, "lineGrid");
				
				global.totalUnitAmount = scr_getTotalUnitAmount();
			}
			else if (objectIndex == "obj_chain")
			{
				
				scr_loadREZGridReset(obj_chain.linkGrid, map, "linkGrid");
				scr_loadREZGridReset(obj_chain.rezChainGrid, map, "rezChainGrid");
				scr_loadREZGridReset(obj_chain.trackChainGrid, map, "trackChainGrid");
				scr_loadREZGridReset(obj_chain.stackChainGrid, map, "stackChainGrid");
				scr_loadREZGridReset(obj_chain.unitInStackGrid, map, "unitInStackGrid");
				
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
				scr_refreshChainGrid();
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
				scr_refreshChainGrid();
				obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
				scr_refreshChainGrid();
				
			}
		}
		
	}
}

ds_list_destroy(newInstList);