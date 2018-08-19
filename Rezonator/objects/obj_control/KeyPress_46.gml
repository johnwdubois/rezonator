if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true))
{
	//var rowInLinkGridSource = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true);
	var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, false);
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
	
	if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, 0, obj_chain.linkGrid_colGoal, ds_grid_height(obj_chain.linkGrid), source))
	{
		//rowInLinkGridGoal = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, 0, obj_chain.linkGrid_colGoal, ds_grid_height(obj_chain.linkGrid), source);
		rowInLinkGridGoal = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, source, obj_chain.linkGrid_colDead, false);
		newSource = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridGoal);
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridGoal, true);
	}
	
	/*
	var previousLinkSource = source;
	var goal = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, rowInLinkGrid);
	if (rowInLinkGrid > 0)
	{
		previousLinkSource = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGrid - 1);
	}
	*/
	
	//show_message(string(source) + "," + string(goal));
	
	if not (newSource == -1 or newSource == undefined or newGoal == undefined)
	{
		with (obj_chain)
		{
			scr_newLink(newSource, newGoal);
		}
	}
}

scr_refreshChainGrid();