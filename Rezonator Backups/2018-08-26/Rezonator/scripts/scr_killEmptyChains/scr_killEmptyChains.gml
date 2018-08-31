var grid = argument0;


for (var i = 0; i < ds_grid_height(grid); i++)
{
	if (i >= ds_grid_height(grid))
	{
		continue;
	}
	
	var idList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, i);
	var chainState = ds_grid_get(grid, obj_chain.chainGrid_colChainState, i);
	
	if (ds_list_size(idList) == 0)
	{
		chainState = obj_chain.chainStateDead;
		ds_grid_set(grid, obj_chain.chainGrid_colChainState, i, chainState);
	}
	
	if (ds_list_size(idList) <= 1 and not (chainState == obj_chain.chainStateFocus) and not (chainState == obj_chain.chainStateDead))
	{
		chainState = obj_chain.chainStateDead;
		ds_grid_set(grid, obj_chain.chainGrid_colChainState, i, chainState);
	}
}


while (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateDead))
{
	var deadRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateDead);
	scr_gridDeleteRow(grid, deadRow);
}