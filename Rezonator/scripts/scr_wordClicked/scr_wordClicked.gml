/*	
	Purpose: handle reaction to user clicking on a word
*/

function scr_wordClicked(wordID, unitID) {
	
	if (global.delayInput > 0) {
		exit;
	}
	
	show_debug_message("scr_wordClicked()... wordID: " + string(wordID) + "unitID: " + string(unitID));

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
	if (obj_toolPane.currentTool != obj_toolPane.toolPlaceChains and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChainID = ds_list_find_value(inChainsList, i);
			
			var currentChainSubMap = global.nodeMap[?currentChainID];
			var currentChainType = currentChainSubMap[?"type"];
			
			var refocusEntry = (currentChainType == "rezChain" && obj_toolPane.currentTool == obj_toolPane.toolRezBrush)
			or(currentChainType == "trackChain" && obj_toolPane.currentTool == obj_toolPane.toolTrackBrush)
			or(currentChainType == "stackChain" && obj_toolPane.currentTool == obj_toolPane.toolStackBrush);
	
			if(refocusEntry){
				obj_chain.currentFocusedChainID = currentChainID;
				var focusedChainIDSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
				
				if (is_numeric(focusedChainIDSubMap)) {
					if (ds_exists(focusedChainIDSubMap, ds_type_map)) {
						var prevChainType = ds_map_find_value(focusedChainIDSubMap, "type");
						if (prevChainType == "stackChain") {
							wordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, wordID -1);
						}
					}
				}
			
				scr_refocusChainEntry(wordID);
			exit;
			}
		}
	}
	
	if(obj_toolPane.currentMode == obj_toolPane.modeRead){
		exit;
	}
	


	// if there is not a focused chain, we create a new chain
	if (!ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		scr_newChain( unitID);
	}

	// add new link and refresh chain grid
	scr_newLink(wordID);

		

	ds_list_destroy(fakeInChainsList);
	obj_control.allSaved = false;
	
	
	scr_refocusChainEntry(wordID);
	




}
