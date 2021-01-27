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
		if (shouldExit) {
			show_debug_message("scr_wordClicked() ... exit 1...");
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
		show_debug_message("scr_wordClicked() ... exit 2...");
		exit;
	}


	//show_message(obj_toolPane.currentTool == obj_toolPane.toolStackBrush);
	var makingStacks = false;
	with (obj_panelPane) {
		if(functionChainList_currentTab == functionChainList_tabStackBrush){
			makingStacks = true;
		}
	}



	if (ds_list_size(obj_control.inRectWordIDList) <= 1 && obj_toolPane.currentTool != obj_toolPane.toolStackBrush&& obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		obj_control.moveCounter++;
	}

	var inChainsList = -1;
	var fakeInChainsList = ds_list_create();
	
	// set inChainsList to be this word's inChainsList ... and if this is a stack, we make a "fakeInChainsList" 
	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
		var unitInStackChain = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1);
		if (unitInStackChain != -1 && ds_map_exists(global.nodeMap, unitInStackChain)) {
			ds_list_add(fakeInChainsList, unitInStackChain);
		}
		inChainsList = fakeInChainsList;
	}
	else {
		inChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, wordID - 1);
	}
	if (obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
		inChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, wordID - 1);
	}
	
	
	// loop through the chains that this word is already in (if any) to refocus that chain
	show_debug_message("scr_wordClicked() inChainsList: " + scr_getStringOfList(inChainsList));
	if (obj_toolPane.currentTool != obj_toolPane.toolPlaceChains and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush
	and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChainID = ds_list_find_value(inChainsList, i);
			currentFocusedChainID = currentChainID;
			var focusedchainIDSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
				
			if(is_numeric(focusedchainIDSubMap)){
				if(ds_exists(focusedchainIDSubMap, ds_type_map)){
					var prevChainType = ds_map_find_value(focusedchainIDSubMap, "type");
					if(prevChainType == "stackChain"){
						wordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, wordID -1);
					}
				}
			}
			
			scr_refocusChainEntry(wordID);
			show_debug_message("scr_wordClicked() ... exit 4...");
			exit;
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
				show_debug_message("scr_wordClicked() ... exit 5...");
				exit;
			}
			var currentChunkWordID = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colName, rowInChainGrid);
		
			// Unfocus all Chunks
			var chunkGridHeight = ds_grid_height(obj_chain.chunkGrid);
			for (var chunkListLoop = 0; chunkListLoop < chunkGridHeight; chunkListLoop++) {
				if (ds_grid_get(obj_chain.chunkGrid, chainGrid_colChainState, chunkListLoop) == chainStateFocus) {
					ds_grid_set(obj_chain.chunkGrid, chainGrid_colChainState, rowInChainGrid, chainStateNormal);
				}
			}
			
			// Set the Chunk to be focused
			ds_grid_set(obj_chain.chunkGrid, chainGrid_colChainState, rowInChainGrid, chainStateFocus);
			//show_message(string(currentChunkWordID));
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentChunkWordID - 1, true);
			currentFocusedChunkID = currentChunkID;
			scr_refocusChainEntry(wordID);
			show_debug_message("scr_wordClicked() ... exit 6...");
			exit;

			
		}
	}
	else {

		// if there is not a focused chain, we create a new chain
		if (!ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
			scr_newChain(wordID, unitID);
		}

		// add new link and refresh chain grid
		scr_newLink(wordID);

		
	}
	ds_list_destroy(fakeInChainsList);
	obj_control.allSaved = false;
	
	
	scr_refocusChainEntry(wordID);
	




}
