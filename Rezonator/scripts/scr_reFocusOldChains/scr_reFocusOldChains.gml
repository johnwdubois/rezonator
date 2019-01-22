/*

	scr_reFocusOldChains();
	
	Last Updated: 2018-07-12
	
	Called from: scr_panelPane_drawChainTabs
	
	Purpose: refocus on chains when user switches back to a tab
	
	Mechanism: find the relevent tab and refocus using recorded old chains
*/

var grid = obj_chain.rezChainGrid;

//switch to focused grid
switch (functionChainList_currentTab)
{
	case functionChainList_tabRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case functionChainList_tabTrackBrush:
		grid = obj_chain.trackChainGrid;
		break;
	case functionChainList_tabStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	case functionChainList_tabClique:
		grid = obj_chain.cliqueDisplayGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}

//added functionality of switching to the tool of the focused tab.
switch (functionChainList_currentTab)
{
	case functionChainList_tabRezBrush:
		obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
		break;
	case functionChainList_tabTrackBrush:
		obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
		break;
	case functionChainList_tabStackBrush:
		obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
		break;
	default:
		break;
}
				
//switch to focused chain				
switch (functionChainList_currentTab)
{
	case functionChainList_tabRezBrush:
		ds_grid_set(grid, obj_chain.chainGrid_colChainState, obj_chain.oldRezFocus, obj_chain.chainStateFocus);
		break;
	case functionChainList_tabTrackBrush:
		ds_grid_set(grid, obj_chain.chainGrid_colChainState, obj_chain.oldTrackFocus, obj_chain.chainStateFocus);
		break;
	case functionChainList_tabStackBrush:
		ds_grid_set(grid, obj_chain.chainGrid_colChainState, obj_chain.oldStackFocus, obj_chain.chainStateFocus);
		break;
	default:
		break;
}