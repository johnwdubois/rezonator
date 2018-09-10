switch (currentFunction)
{
	case functionChainList:
		with (obj_panelPane)
		{
			functionChainList_currentTab = other.functionChainList_currentTab;
		}
	case functionSort:
		if not (functionSort_initialSort)
		{
			if (ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount)
			{
				functionSort_initialSort = true;
				functionSort_performSort = true;
			}
		}
	default:
		break;
}