/*
	obj_chain: Step
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Consistently update attributes of chain objects
	
	Mechanism: Hide/reveal the mouseLine depending on mouse position, use on the grid connected to the tool in use, and keep focused chains visible in the focus view. 
	
	Author: Terry DuBois
*/

if(keyboard_check_pressed(ord("A")) and keyboard_check(vk_control) and not (!obj_control.shortcutsEnabled || obj_control.dialogueBoxActive || obj_panelPane.discoSelectionActive)) {
	//kinda broken rn
	//showPlaceChains = !showPlaceChains;	
}

if (mouseLineHide) {
	var focusedRezChain = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus);
	var focusedTrackChain = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus);
	var focusedStackChain = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
	var tempMouseLineWordID = obj_chain.mouseLineWordID;
	scr_chainDeselect();
	if (focusedRezChain > -1) {
		ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, focusedRezChain, obj_chain.chainStateFocus);
	}
	if (focusedTrackChain > -1) {
		ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, focusedTrackChain, obj_chain.chainStateFocus);
	}
	if (focusedStackChain > -1) {
		ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, focusedStackChain, obj_chain.chainStateFocus);
	}
	obj_chain.mouseLineWordID = tempMouseLineWordID;
}

ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, 0, obj_control.wordDrawGrid_colFocused, ds_grid_height(obj_control.wordDrawGrid), false);

if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus)) {
	currentFocusedChainIndex = ds_grid_value_y(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus);
	currentFocusedChainID = ds_grid_get(currentChainGrid, chainGrid_colChainID, currentFocusedChainIndex);
	
	if (currentChainGrid == rezChainGrid or currentChainGrid == trackChainGrid) {
		var idList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, currentFocusedChainIndex);
		var idListSize = ds_list_size(idList);
		for (var i = 0; i < idListSize; i++) {
			var currentID = ds_list_find_value(idList, i);
			var isVisible = ds_grid_get(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colVisible, currentID -1);
			var isChunk = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentID -1);
			
			if (isVisible || isChunk) {
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentID - 1, true);
			}
		}
	}
	// Focus specifically for Chunks
	else if(currentChainGrid == chunkGrid) {
		/*var idList = ds_grid_get(currentChainGrid, chunkGrid_colBoxWordIDList, index);
	
		for (var i = 0; i < ds_list_size(idList); i++) {
			var currentID = ds_list_find_value(idList, i);
			var isVisible = ds_grid_get(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colVisible, currentID -1);
			var isChunk = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentID -1);
			
			if (isVisible || isChunk) {
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentID - 1, true);
			}
		}*/
		var chunkWordID = ds_grid_get(currentChainGrid, chainGrid_colName, currentFocusedChainIndex);
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, chunkWordID - 1, true);
	}
	
}
else {
	currentFocusedChainID = -1;
	currentFocusedChainIndex = -1;
}

switch (obj_toolPane.currentTool) {
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
	case obj_toolPane.toolPlaceChains:
		currentChainGrid = placeChainGrid;
		currentChainName = "Place";
		break;
	case obj_toolPane.toolBoxBrush:
		currentChainGrid = chunkGrid;
		currentChainName = "Box";
		break;
	default:
		break;
}

mouseLineHide = false;
for (var i = 0; i < instance_number(obj_panelPane); i++) {
	var currentPanelPaneInst = instance_find(obj_panelPane, i);
	
	if (point_in_rectangle(mouse_x, mouse_y, currentPanelPaneInst.x, currentPanelPaneInst.y, currentPanelPaneInst.x + currentPanelPaneInst.windowWidth, currentPanelPaneInst.y + currentPanelPaneInst.windowHeight)) {
		mouseLineHide = true;
	}
}



if (not obj_control.gridView and ds_grid_height(cliqueGrid) > 0) {
	cliqueGridRowToRefreshFlanks = min(cliqueGridRowToRefreshFlanks + 1, ds_grid_height(cliqueGrid) - 1);
	scr_cliqueGridRefreshFlanks(cliqueGridRowToRefreshFlanks);
	
	if (cliqueGridRowToRefreshFlanks = ds_grid_height(cliqueGrid) - 1) {
		cliqueGridRowToRefresh = 0;
	}
}


if (ds_grid_height(rezChainGrid) > 0) {
	rezChainGridRowToRefreshTilt = min(rezChainGridRowToRefreshTilt + 1, ds_grid_height(rezChainGrid) - 1);
	scr_refreshTilt(rezChainGridRowToRefreshTilt);
	
	if (rezChainGridRowToRefreshTilt = ds_grid_height(rezChainGrid) - 1) {
		rezChainGridRowToRefreshTilt = 0;
	}
}

