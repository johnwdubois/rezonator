var rowInCliqueGrid = argument0;

var chainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, rowInCliqueGrid);

var vizLinkLookupGrid = ds_grid_create(3, 0);
var vizLinkLookupGrid_colChainID = 0;
var vizLinkLookupGrid_colStart = 1;
var vizLinkLookupGrid_colEnd = 2;

for (var i = 0; i < ds_list_size(chainIDList); i++)
{
	var currentChainID = ds_list_find_value(chainIDList, i);
	var rowInVizLinkGrid = ds_grid_value_y(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, 0, obj_chain.vizLinkGrid_colChainID, ds_grid_height(obj_chain.vizLinkGrid), currentChainID);
	
	if (rowInVizLinkGrid < 0 or rowInVizLinkGrid >= ds_grid_height(obj_chain.vizLinkGrid))
	{
		continue;
	}
	
	//show_message("currentChainID: " + string(currentChainID));
	
	var k = 0;
	while (ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, rowInVizLinkGrid + k) == currentChainID)
	{
		k++;
		if (rowInVizLinkGrid + k >= ds_grid_height(obj_chain.vizLinkGrid))
		{
			break;
		}
	}
	
	ds_grid_resize(vizLinkLookupGrid, ds_grid_width(vizLinkLookupGrid), ds_grid_height(vizLinkLookupGrid) + 1);
	
	ds_grid_set(vizLinkLookupGrid, vizLinkLookupGrid_colChainID, ds_grid_height(vizLinkLookupGrid) - 1, currentChainID);
	ds_grid_set(vizLinkLookupGrid, vizLinkLookupGrid_colStart, ds_grid_height(vizLinkLookupGrid) - 1, rowInVizLinkGrid);
	ds_grid_set(vizLinkLookupGrid, vizLinkLookupGrid_colEnd, ds_grid_height(vizLinkLookupGrid) - 1, rowInVizLinkGrid + k - 1);
}



for (var i = 0; i < ds_list_size(chainIDList); i++)
{
	
	var currentChainID = ds_list_find_value(chainIDList, i);
	var rowInviLinkGrid = ds_grid_value_y(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, 0, obj_chain.vizLinkGrid_colChainID, ds_grid_height(obj_chain.vizLinkGrid), currentChainID);
	
	if (rowInVizLinkGrid < 0 or rowInVizLinkGrid >= ds_grid_height(obj_chain.vizLinkGrid))
	{
		continue;
	}
	
	var plusRow = 0;
	while (ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, rowInVizLinkGrid + plusRow) == currentChainID)
	{
		var currentSource1 = ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colSource, rowInVizLinkGrid + plusRow);
		var currentGoal1 = ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colGoal, rowInVizLinkGrid + plusRow);
		
		if (currentSource1 == -1 or currentGoal1 == -1)
		{
			plusRow++;
			if (rowInVizLinkGrid + plusRow >= ds_grid_height(obj_chain.vizLinkGrid))
			{
				break;
			}
			
			continue;
		}
		
		var currentSource1UnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentSource1 - 1);
		var currentGoal1UnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentGoal1 - 1);
		var rowInLineGridcurrentSource1 = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentSource1UnitID);
		var rowInLineGridcurrentGoal1 = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentGoal1UnitID);
		
		if (rowInLineGridcurrentSource1 < 0 or rowInLineGridcurrentSource1 >= ds_grid_height(obj_control.lineGrid))
		{
			plusRow++;
			if (rowInVizLinkGrid + plusRow >= ds_grid_height(obj_chain.vizLinkGrid))
			{
				break;
			}
			continue;
		}
		if (rowInLineGridcurrentGoal1 < 0 or rowInLineGridcurrentGoal1 >= ds_grid_height(obj_control.lineGrid))
		{
			plusRow++;
			if (rowInVizLinkGrid + plusRow >= ds_grid_height(obj_chain.vizLinkGrid))
			{
				break;
			}
			continue;
		}
		
		var source1PixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentSource1 - 1);
		var source1PixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, rowInLineGridcurrentSource1);
		var goal1PixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentGoal1 - 1);
		var goal1PixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, rowInLineGridcurrentGoal1);
	
		for (var k = 0; k < ds_grid_height(vizLinkLookupGrid); k++)
		{
			var lookupGridChainID = ds_grid_get(vizLinkLookupGrid, vizLinkLookupGrid_colChainID, k);
			if (currentChainID == lookupGridChainID)
			{
				continue;
			}
			var lookupGridStart = ds_grid_get(vizLinkLookupGrid, vizLinkLookupGrid_colStart, k);
			var lookupGridEnd = ds_grid_get(vizLinkLookupGrid, vizLinkLookupGrid_colEnd, k);
			
			for (var l = lookupGridStart; l < lookupGridEnd; l++)
			{
				if (l < 0 or l >= ds_grid_height(obj_chain.vizLinkGrid))
				{
					continue;
				}
				
				var currentSource2 = ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colSource, l);
				var currentGoal2 = ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colGoal, l);
				
				if (currentSource2 == -1 or currentGoal2 == -1)
				{
					continue;
				}
				if (currentSource1 == currentSource2 or currentSource1 == currentGoal2)
				{
					continue;
				}
				if (currentGoal1 == currentGoal2 or currentGoal1 == currentSource2)
				{
					continue;
				}
				
				var currentSource2UnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentSource2 - 1);
				var currentGoal2UnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentGoal2 - 1);
				var rowInLineGridcurrentSource2 = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentSource2UnitID);
				var rowInLineGridcurrentGoal2 = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentGoal2UnitID);
		
				if (rowInLineGridcurrentSource2 < 0 or rowInLineGridcurrentSource2 >= ds_grid_height(obj_control.lineGrid))
				{
					continue;
				}
				if (rowInLineGridcurrentGoal2 < 0 or rowInLineGridcurrentGoal2 >= ds_grid_height(obj_control.lineGrid))
				{
					continue;
				}
				
				var source2PixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentSource2 - 1);
				var source2PixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, rowInLineGridcurrentSource2);
				var goal2PixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentGoal2 - 1);
				var goal2PixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, rowInLineGridcurrentGoal2);
				
				var intersection = scr_lineIntersection(source1PixelX, source1PixelY, goal1PixelX, goal1PixelY, source2PixelX, source2PixelY, goal2PixelX, goal2PixelY, true);
				//if (intersection > 0 and intersection <= 1)
				//{
					ds_grid_set(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colCross, l, intersection);
					//show_message("CROSS");
				//}
			}
		}
		
		plusRow++;
		if (rowInVizLinkGrid + plusRow >= ds_grid_height(obj_chain.vizLinkGrid))
		{
			break;
		}
	}
}




ds_grid_destroy(vizLinkLookupGrid);