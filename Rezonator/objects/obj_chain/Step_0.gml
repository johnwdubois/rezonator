if (mouseLineHide)
{
	var focusedRezChain = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus);
	var focusedTrackChain = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus);
	var focusedStackChain = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
	scr_chainDeselect();
	if (focusedRezChain > -1)
	{
		ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, focusedRezChain, obj_chain.chainStateFocus);
	}
	if (focusedTrackChain > -1)
	{
		ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, focusedTrackChain, obj_chain.chainStateFocus);
	}
	if (focusedStackChain > -1)
	{
		ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, focusedStackChain, obj_chain.chainStateFocus);
	}
}

ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, 0, obj_control.wordDrawGrid_colFocused, ds_grid_height(obj_control.wordDrawGrid), false);

if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus))
{
	var index = ds_grid_value_y(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus);
	currentFocusedChainID = ds_grid_get(currentChainGrid, chainGrid_colChainID, index);
	
	if (currentChainGrid == rezChainGrid or currentChainGrid == trackChainGrid)
	{
		var idList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, index);
	
		for (var i = 0; i < ds_list_size(idList); i++)
		{
			var currentID = ds_list_find_value(idList, i);
			var isVisible = ds_grid_get(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colVisible, currentID -1);
			
			if (isVisible)
			{
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentID - 1, true);
			}
		}
	}
	
}
else
{
	currentFocusedChainID = -1;
}

switch (obj_toolPane.currentTool)
{
	case obj_toolPane.toolRezBrush:
		currentChainGrid = rezChainGrid;
		currentChainName = "Rez";
		break;
	case obj_toolPane.toolTrackBrush:
		currentChainGrid = trackChainGrid;
		currentChainName = "Track";
		break;
	case obj_toolPane.toolStackBrush:
		currentChainGrid = stackChainGrid;
		currentChainName = "Stack";
		break;
	default:
		break;
}

mouseLineHide = false;
for (var i = 0; i < instance_number(obj_panelPane); i++)
{
	var currentPanelPaneInst = instance_find(obj_panelPane, i);
	
	if (point_in_rectangle(mouse_x, mouse_y, currentPanelPaneInst.x, currentPanelPaneInst.y, currentPanelPaneInst.x + currentPanelPaneInst.windowWidth, currentPanelPaneInst.y + currentPanelPaneInst.windowHeight))
	{
		mouseLineHide = true;
	}
}



if (not obj_control.gridView and ds_grid_height(cliqueGrid) > 0)
{
	cliqueGridRowToRefreshFlanks = min(cliqueGridRowToRefreshFlanks + 1, ds_grid_height(cliqueGrid) - 1);
	scr_cliqueGridRefreshFlanks(cliqueGridRowToRefreshFlanks);
	
	if (cliqueGridRowToRefreshFlanks = ds_grid_height(cliqueGrid) - 1)
	{
		cliqueGridRowToRefresh = 0;
	}
}


if (ds_grid_height(rezChainGrid) > 0)
{
	rezChainGridRowToRefreshTilt = min(rezChainGridRowToRefreshTilt + 1, ds_grid_height(rezChainGrid) - 1);
	scr_refreshTilt(rezChainGridRowToRefreshTilt);
	
	if (rezChainGridRowToRefreshTilt = ds_grid_height(rezChainGrid) - 1)
	{
		rezChainGridRowToRefreshTilt = 0;
	}
}