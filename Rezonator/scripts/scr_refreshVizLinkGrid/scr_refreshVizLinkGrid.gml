ds_grid_resize(obj_chain.vizLinkGrid, obj_chain.vizLinkGridWidth, ds_grid_height(obj_chain.linkGrid));
ds_grid_copy(obj_chain.vizLinkGrid, obj_chain.linkGrid);

for (var i = 0; i < ds_grid_height(obj_chain.rezChainGrid); i++)
{
	var currentChainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, i);
	var currentWordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, i);
	var rowInVizLinkGrid = ds_grid_value_y(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, 0, obj_chain.vizLinkGrid_colChainID, ds_grid_height(obj_chain.vizLinkGrid), currentChainID);
	
	if (rowInVizLinkGrid == -1)
	{
		continue;
	}
	
	//for (var j = 0; j < ds_list_size(currentWordIDList); j++)
	//{
	var sourceCol = true;
		
	var k = 0;
	var l = 0;
	while (ds_grid_get(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colChainID, rowInVizLinkGrid + k) == currentChainID
	and l < ds_list_size(currentWordIDList))
	{
		var currentVal = ds_list_find_value(currentWordIDList, l);
		
		if (sourceCol)
		{
			ds_grid_set(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colSource, rowInVizLinkGrid + k, currentVal);
			
			sourceCol = false;
		}
		else
		{
			ds_grid_set(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colGoal, rowInVizLinkGrid + k, currentVal);
			k++;
			ds_grid_set(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colSource, rowInVizLinkGrid + k, currentVal);
		}
		
		l++;
		
		if (rowInVizLinkGrid + k >= ds_grid_height(obj_chain.vizLinkGrid))
		{
			break;
		}
	}
	//}
}
/*
var col1 = obj_chain.vizLinkGrid_colTier;
var col2 = obj_chain.vizLinkGrid_colChainID;
var col3 = obj_chain.vizLinkGrid_colSource;
var col4 = obj_chain.vizLinkGrid_colGoal;
scr_gridMultiColSort(obj_chain.vizLinkGrid, col1, true, col2, true, col3, true, col4, true);

for ()