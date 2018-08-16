var grid = obj_chain.rezChainGrid;

switch (obj_toolPane.currentTool)
{
	case obj_toolPane.toolRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case obj_toolPane.toolAnaphBrush:
		grid = obj_chain.anaphChainGrid;
		break;
	case obj_toolPane.toolStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	default:
		break;
}

var idList = ds_list_create();

if (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus))
{
	var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	var chainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, rowInChainGrid);
}
else
{
	exit;
}

var tempGrid = ds_grid_create(ds_grid_width(obj_chain.linkGrid), ds_grid_height(obj_chain.linkGrid));
ds_grid_copy(tempGrid, obj_chain.linkGrid);

while (ds_grid_value_exists(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID))
{
	var rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
	var source = ds_grid_get(tempGrid, obj_chain.linkGrid_colSource, rowInTempGrid);
	var goal = ds_grid_get(tempGrid, obj_chain.linkGrid_colGoal, rowInTempGrid);
	var dead = ds_grid_get(tempGrid, obj_chain.linkGrid_colDead, rowInTempGrid);
	
	ds_grid_set(tempGrid, obj_chain.linkGrid_colChainID, rowInTempGrid, -1);
	
	if (dead)
	{
		continue;
	}
	if (source == -1)
	{
		continue;
	}
	if (ds_list_find_index(idList, source) == -1)
	{
		ds_list_add(idList, source);
	}
	if (goal == -1)
	{
		continue;
	}
	if (ds_list_find_index(idList, goal) == -1)
	{
		ds_list_add(idList, goal);
	}
	
	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)
	{
		var stackListSource = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, source - 1);
		var stackListGoal = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, goal - 1);
		if (ds_list_find_index(stackListSource, chainID) == -1)
		{
			ds_list_add(stackListSource, chainID);
		}
		if (ds_list_find_index(stackListGoal, chainID) == -1)
		{
			ds_list_add(stackListGoal, chainID);
		}
	}
	
}

ds_list_sort(idList, true);
ds_grid_set(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid, idList);

ds_grid_destroy(tempGrid);