if (instance_exists(obj_input_text)) {
	exit;
}

if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true))
{	
	var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, false);
	
	if (rowInLinkGridSource == -1)
	{
		exit;
	}
	
	var chainID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, rowInLinkGridSource);
	var tier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowInLinkGridSource);
	var dead = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource);
	
	if (dead)
	{
		exit;
	}
	
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource, true);
	

	var source = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridSource);
	var sourceInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, source - 1);
	var indexOfChainIDInChainsList = ds_list_find_index(sourceInChainsList, chainID);
	if (indexOfChainIDInChainsList > -1)
	{
		ds_list_delete(sourceInChainsList, indexOfChainIDInChainsList);
	}
	
	if (source >= 0 and source < ds_grid_height(obj_control.dynamicWordGrid) and tier == 1)
	{
		if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, source - 1))
		{
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, source - 1, false);
		}
		
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, source - 1, true);
	}
	
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
		var rowInUnitInStackGrid = ds_grid_value_y(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colUnitID, 0, obj_chain.unitInStackGrid_colUnitID, ds_grid_height(obj_chain.unitInStackGrid), source);
		
		if (rowInUnitInStackGrid < 0 or rowInUnitInStackGrid >= ds_grid_height(obj_chain.unitInStackGrid))
		{
			exit;
		}
		
		var stackListSource = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, rowInUnitInStackGrid);
		
		if not (stackListSource == undefined)
		{
			if (ds_list_find_index(stackListSource, chainID) > -1)
			{
				ds_list_delete(stackListSource, ds_list_find_index(stackListSource, chainID));
			}
		}


		
		if (newSource > 0)
		{
			var idListNewSource = ds_grid_get(unitGrid, unitGrid_colWordIDList, newSource - 1);
			
			if not (idListNewSource == undefined)
			{
				if (ds_list_size(idListNewSource) > 0)
				{
					newSource = ds_list_find_value(idListNewSource, 0);
				}
			}
		}
		if (newGoal > 0)
		{
			var idListNewGoal = ds_grid_get(unitGrid, unitGrid_colWordIDList, newGoal - 1);
			
			if not (idListNewGoal == undefined)
			{
				if (ds_list_size(idListNewGoal) > 0)
				{
					newGoal = ds_list_find_value(idListNewGoal, 0);
				}
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
	
	if not (source == undefined)
	{
		ds_grid_set(wordDrawGrid, wordDrawGrid_colFillRect, source - 1, false);
	}
}

scr_refreshChainGrid();
scr_killEmptyChains(obj_chain.currentChainGrid);
obj_chain.mouseLineWordID = -1;

scr_refreshVizLinkGrid();