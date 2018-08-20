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