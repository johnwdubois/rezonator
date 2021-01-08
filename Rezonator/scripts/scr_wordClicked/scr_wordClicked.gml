/*
	scr_wordClicked(wordID, unitID);
	
	Last Updated: 2019-02-05
	
	Called from: obj_control
	
	Purpose: handle reaction to user clicking on a word
	
	Mechanism: check obj_toolPane to see if a chainBrush is selected, if so either spawn a new chain or add
				to an existing 
				
	Author: Terry DuBois
*/

function scr_wordClicked(wordID, unitID) {

	if (obj_control.gridView or (obj_control.mouseoverPanelPane and not obj_stacker.splitSave) or obj_control.dialogueBoxActive or instance_exists(obj_dialogueBox) or instance_exists(obj_dropDown)) {
		var shouldExit = true;
		if (obj_control.dialogueBoxActive or instance_exists(obj_dialogueBox)) {
			if (obj_dialogueBox.combineChains) {
				shouldExit = false;	
			}
		}
		if(shouldExit){
			exit;
		}
	}


	if(obj_control.currentActiveLineGrid == obj_control.searchGrid and obj_toolPane.currentTool == obj_toolPane.toolStackBrush) { 
		wordID = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colWordID, wordID - 1);
		//show_message(wordID);
	}

	// jump audio position to unitStart time (if audioUI is visible)
	if (instance_exists(obj_audioUI)) {
		if (obj_audioUI.visible and file_exists(obj_audioUI.audioFile) and obj_audioUI.audioSound != -1) {
			scr_audioJumpToUnit(unitID);
		}
	}

	// Safety check, but allows for Chunks/newWords
	if (wordID < 0 or wordID > ds_grid_height(obj_control.dynamicWordGrid)) {
		exit;
	}

	// if we are not on rez-tool, track-tool, or stack-tool, leave this script
	if not (obj_toolPane.currentTool == obj_toolPane.toolRezBrush
	or obj_toolPane.currentTool == obj_toolPane.toolTrackBrush
	or obj_toolPane.currentTool == obj_toolPane.toolStackBrush
	or obj_toolPane.currentTool == obj_toolPane.toolPlaceChains
	or obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
		exit;
	}
	//show_message(obj_toolPane.currentTool == obj_toolPane.toolStackBrush);

	if (ds_list_size(obj_control.inRectWordIDList) <= 1 && obj_toolPane.currentTool != obj_toolPane.toolStackBrush&& obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		obj_control.moveCounter++;
	}

	var fakeInChainsList = ds_list_create();

	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
		ds_list_add(fakeInChainsList, ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1));
		var inChainsList = fakeInChainsList;
	}
	else {
		var inChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, wordID - 1);
	}
	if (obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
		var inChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, wordID - 1);
	}
	
	
	// loop through the chains that this word is already in (if any) to refocus that chain
	if (obj_toolPane.currentTool != obj_toolPane.toolPlaceChains and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChainID = ds_list_find_value(inChainsList, i);
			currentFocusedChainID = currentChainID;
			
			var rowInChainGrid = ds_grid_value_y(currentChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(currentChainGrid), currentChainID);
			ds_grid_set(currentChainGrid, chainGrid_colChainState, rowInChainGrid, chainStateFocus);
			
			scr_refocusChainEntry(wordID);
			exit;
			
			/*
			if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(currentChainGrid), currentChainID)) {
				scr_setAllValuesInCol(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, obj_chain.chainStateNormal);
				scr_setAllValuesInCol(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, obj_chain.chainStateNormal);
				scr_setAllValuesInCol(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, obj_chain.chainStateNormal);
		
				var rowInChainGrid = ds_grid_value_y(currentChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(currentChainGrid), currentChainID);
				ds_grid_set(currentChainGrid, chainGrid_colChainState, rowInChainGrid, chainStateFocus);
				currentFocusedChainID = currentChainID;
				var newTop = rowInChainGrid + 1;
				show_debug_message("scr_wordClicked() ... newTop: " + string(newTop));
				with (obj_panelPane) {
					currentTopViewRow = ((newTop - 2) > 2) ? (newTop - 2) : 0;	
				}
				show_debug_message("scr_wordClicked() ... obj_panelPane.currentTopViewRow: " + string(obj_panelPane.currentTopViewRow));
		
				var rowInLinkGrid = -1;
				if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
					rowInLinkGrid = scr_findInGridThreeParameters(linkGrid, linkGrid_colSource, unitID, linkGrid_colChainID, currentChainID, linkGrid_colDead, false);
				}
				else {
					rowInLinkGrid = scr_findInGridThreeParameters(linkGrid, linkGrid_colSource, wordID, linkGrid_colChainID, currentChainID, linkGrid_colDead, false);
				}
		
				if (rowInLinkGrid == -1) {
					scr_setAllValuesInCol(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, obj_chain.chainStateNormal);
					scr_setAllValuesInCol(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, obj_chain.chainStateNormal);
					scr_setAllValuesInCol(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, obj_chain.chainStateNormal);
				}
				else if (rowInLinkGrid >= 0 and rowInLinkGrid < ds_grid_height(linkGrid)) {
			
					ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
					ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGrid, true);
					scr_refreshChainGrid();
			
					if (currentChainGrid == rezChainGrid or currentChainGrid == trackChainGrid) {
						ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, wordID - 1, true);
		
					}
					with (obj_panelPane) {
						switch (obj_chain.currentChainGrid) {
							case obj_chain.rezChainGrid:
								functionChainList_currentTab = functionChainList_tabRezBrush;
								break;
							case obj_chain.trackChainGrid:
								functionChainList_currentTab = functionChainList_tabTrackBrush;
								break;
							case obj_chain.stackChainGrid:
								functionChainList_currentTab = functionChainList_tabStackBrush;
								break;
							default:
								break;
						}
						if (currentFunction == functionChainContents) {
							functionChainContents_hop = wordID;
						}
					}
					
					scr_refocusChainEntry(wordID);
					exit;
				}
			}
			*/
		}
	}
	

	// Will need to get back to this
	// loop through the chunks that this word is already in (if any) to refocus that chunk
	if (obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
		var inChunkListSize = ds_list_size(inChunkList);
		for (var i = 0; i < inChunkListSize; i++) {
			// Find the value of the current Chunk
			var currentChunkID = ds_list_find_value(inChunkList, i);
			var rowInChainGrid = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.chunkGrid), currentChunkID);
			if (rowInChainGrid < 0) {
				scr_refocusChainEntry(wordID);
				exit;
			}
			var currentChunkWordID = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colName, rowInChainGrid);
		
			// Make sure this ChunkID is valid
			//if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(currentChainGrid), currentChunkID)) {
			// Unfocus all Chunks
			//scr_setAllValuesInCol(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, obj_chain.chainStateNormal);
			var chunkGridHeight = ds_grid_height(obj_chain.chunkGrid);
			for(var chunkListLoop = 0; chunkListLoop < chunkGridHeight; chunkListLoop++) {
				if(ds_grid_get(currentChainGrid, chainGrid_colChainState, chunkListLoop) == chainStateFocus) {
					ds_grid_set(currentChainGrid, chainGrid_colChainState, rowInChainGrid, chainStateNormal);
				}
			}
			
			// Access the Chunk's row in the Chunk grid
			//var rowInChainGrid = ds_grid_value_y(currentChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(currentChainGrid), currentChunkID);
			
			// Set the Chunk to be focused
			ds_grid_set(currentChainGrid, chainGrid_colChainState, rowInChainGrid, chainStateFocus);
			//show_message(string(currentChunkWordID));
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentChunkWordID - 1, true);
			currentFocusedChunkID = currentChunkID;
			scr_refocusChainEntry(wordID);
			exit;

			
		}
	}
	else {

		// if there is not a focused chain, we create a new chain
		if (not ds_grid_value_exists(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus)) {
			scr_newChain(wordID, unitID);
		}

		// add new link and refresh chain grid
		scr_newLink(wordID, -1);
		scr_refreshChainGrid(wordID);
		


		// update the list of chains that this word is in
		if (ds_grid_value_exists(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus)) {
			var rowInChainGrid = ds_grid_value_y(currentChainGrid, chainGrid_colChainState, 0, chainGrid_colChainState, ds_grid_height(currentChainGrid), chainStateFocus);
			var chainID = ds_grid_get(currentChainGrid, chainGrid_colChainID, rowInChainGrid);
	
			if (ds_list_find_index(inChainsList, chainID) == -1) {
				ds_list_add(inChainsList, chainID);
			}
		}

		
	}
	ds_list_destroy(fakeInChainsList);
	obj_control.allSaved = false;
	
	
	scr_refocusChainEntry(wordID);
	
	
	



}
