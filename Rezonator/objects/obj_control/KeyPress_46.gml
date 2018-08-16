if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true))
{
	var rowInLinkGrid = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true);
	var dead = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGrid);
	
	if (dead)
	{
		exit;
	}
	
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGrid, true);
	
	
	var source = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGrid);
	var previousLinkSource = source;
	var goal = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, rowInLinkGrid);
	if (rowInLinkGrid > 0)
	{
		previousLinkSource = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGrid - 1);
	}
	
	show_message(string(source) + "," + string(goal));
	
	with (obj_chain)
	{
		scr_newLink(previousLinkSource, goal);
	}
}