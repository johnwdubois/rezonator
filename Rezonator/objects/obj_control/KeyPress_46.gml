if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true))
{	
	var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, false);
	var chainID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, rowInLinkGridSource);
	var tier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowInLinkGridSource);
	var dead = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource);
	
	if (dead)
	{
		exit;
	}
	
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource, true);
	

	var source = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridSource);

	
	var rowInLinkGridGoal = -1;
	var newSource = -1;
	var newGoal = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, rowInLinkGridSource);
	
	if (scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, source, obj_chain.linkGrid_colChainID, chainID) > -1)
	{
		rowInLinkGridGoal = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, source, obj_chain.linkGrid_colChainID, chainID, obj_chain.linkGrid_colDead, false);
		newSource = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridGoal);
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridGoal, true);
	}
	
	//show_message(string(newSource) + "," + string(newGoal))
	
	if (tier == 3)
	{
	
	/*
		if (ds_list_find_index(stackListSource, source) > -1)
		{
			ds_list_delete(stackListSource, ds_list_find_index(stackListSource, source));
		}
	*/	
		
		
		if (newSource > 0)
		{
			var idListNewSource = ds_grid_get(unitGrid, unitGrid_colWordIDList, newSource - 1);
			
			if (ds_list_size(idListNewSource) > 0)
			{
				newSource = ds_list_find_value(idListNewSource, 0);
			}
		}
		if (newGoal > 0)
		{
			var idListNewGoal = ds_grid_get(unitGrid, unitGrid_colWordIDList, newGoal - 1);
			
			if (ds_list_size(idListNewGoal) > 0)
			{
				newGoal = ds_list_find_value(idListNewGoal, 0);
			}
		}
		


	}
	
	if not (newSource == -1 or newSource == undefined or newGoal == undefined)
	{
		with (obj_chain)
		{
			scr_newLink(newSource, newGoal);
		}
	}
	
	ds_grid_set(wordDrawGrid, wordDrawGrid_colFillRect, source - 1, false);
}

scr_refreshChainGrid();