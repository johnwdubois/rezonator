var currentChainID = argument[0];

			
var grid = obj_chain.rezChainGrid;

// Based on user selection, get the grid of the current tab
switch (obj_panelPane.functionChainList_currentTab) {
	case obj_panelPane.functionChainList_tabRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case obj_panelPane.functionChainList_tabTrackBrush:
		grid = obj_chain.trackChainGrid;
		break;
	case obj_panelPane.functionChainList_tabStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	case obj_panelPane.functionChainList_tabClique:
		grid = obj_chain.cliqueDisplayGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}


var currentChainGridRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.currentChainGrid)-1, currentChainID);
var currentChainWordIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, currentChainGridRow);
// Focus a link on the relevant chain
var currentLinkGridRow = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(obj_chain.linkGrid), currentChainID);
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, currentLinkGridRow, true);

for(var deleteLoop = 0; deleteLoop < ds_list_size(currentChainWordIDList); deleteLoop++) {
	with(obj_control) {
		scr_deleteFromChain();	
	}
}