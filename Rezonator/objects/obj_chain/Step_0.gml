if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus))
{
	var index = ds_grid_value_y(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus);
	currentFocusedChainID = ds_grid_get(currentChainGrid, chainGrid_colChainID, index);
}
else
{
	currentFocusedChainID = -1;
}

switch (obj_toolPane.currentTool)
{
	case obj_toolPane.toolRezBrush:
		currentChainGrid = rezChainGrid;
		currentChainName = "RezChain";
		break;
	case obj_toolPane.toolAnaphBrush:
		currentChainGrid = anaphChainGrid;
		currentChainName = "AnaphChain";
		break;
	case obj_toolPane.toolStackBrush:
		currentChainGrid = stackChainGrid;
		currentChainName = "Stack";
		break;
	default:
		break;
}