function scr_rightClickWordOptions(optionSelected) {

	switch (optionSelected)
	{
		/*
		case "Link":
		
			
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Create Rez", "Create track", "Delete link");
			
			if (ds_list_size(dropDownOptionList) > 0) {
				
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 9;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}

			//show_message("BUH 1");
			break;
			*/
		case "Tag":
				
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Create tag", "Edit Tag", "Delete tag");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y+ obj_dropDown.optionSpacing * 4, dropDownOptionList, global.optionListTypeWordTags);
			}
			break;
		case "Replace Word":
		
			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {
				//show_message("buh");
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.replace = true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
		
			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			//show_message("BUH 1");
			break;
		case "Restore Word":
		
			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {
				
				var tokenImportIndex = -1;
				if(obj_control.wordView > 2){
					tokenImportIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView - 3);
				}
				else{
					tokenImportIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView - 2);				
				}
				var tokenImportColName = ds_list_find_value(global.tokenImportColNameList, tokenImportIndex);
				var importColPos = ds_list_find_index(global.importGridColNameList, tokenImportColName);
				
				var originalWord = ds_grid_get(global.importGrid, importColPos, obj_control.rightClickWordID - 1);

				scr_replaceWord( obj_control.rightClickWordID , originalWord);
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord , obj_control.rightClickWordID - 1, "");
			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			//show_message("BUH 1");
			break;
		case "Split Word":
		
			scr_destroyAllDropDownsOtherThanSelf();
			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {
				//show_message("buh");
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.replace = true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;
					obj_control.splitWord = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						
					}
		
			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			//show_message("BUH 2");
			break;
		case "New Word":
		
		
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "<0>", "<ZERO>", "<PRO>", "Custom");
						

			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + obj_dropDown.optionSpacing, dropDownOptionList, global.optionListTypeNewWord);
			}
	
		
		

			//show_message("BUH 3");
			break;
		case "Delete New Word":
			scr_destroyAllDropDownsOtherThanSelf();
			obj_control.newWordHoverWordID = obj_control.rightClickWordID;
			obj_control.deleteNewWord = true;
			//show_message("Coming Soon");
			scr_deleteFromChain();
			
			obj_control.deleteNewWord = false;
			obj_control.rightClickonWord = false;
			instance_destroy();
	
			break;
		case "Delete Link":
			/*
			var currentInChainList = ds_list_create();
			ds_list_copy(currentInChainList, ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList,obj_control.rightClickWordID - 1) );
			if(obj_toolPane.currentMode == obj_toolPane.modeRez){
				var chainGridRowToSet = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID,0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), ds_list_find_value(currentInChainList,0));
				ds_grid_set(obj_chain.rezChainGrid,obj_chain.chainGrid_colChainState, chainGridRowToSet, 2);
			}
			else if(obj_toolPane.currentMode == obj_toolPane.modeTrack){
				var chainGridRowToSet = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID,0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), ds_list_find_value(currentInChainList,0));
				ds_grid_set(obj_chain.trackChainGrid,obj_chain.chainGrid_colChainState, chainGridRowToSet, 2);
			}
			else{
				break;
			}
			*/
			var rowInChainGrid = -1;
			var currentChainID = -1;
			if (obj_toolPane.currentMode == obj_toolPane.modeRez) {
				rowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus);
				currentChainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, rowInChainGrid);
			}
			else if (obj_toolPane.currentMode == obj_toolPane.modeTrack) {
				rowInChainGrid = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus);
				currentChainID = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, rowInChainGrid);
			}
		
			show_debug_message("scr_rightClickWordOptions()... rowInChainGrid: " + string(rowInChainGrid));
			show_debug_message("scr_rightClickWordOptions()... currentChainID: " + string(currentChainID));
		
			var rowToSet = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource, obj_control.rightClickWordID, obj_chain.linkGrid_colChainID, currentChainID, obj_chain.linkGrid_colDead, false);
		
			show_debug_message("scr_rightClickWordOptions()... rowToSet: " + string(rowToSet));
		
		
		
			var grid = obj_chain.rezChainGrid;

			// find which grid we are dealing with (depending on current tool)
			switch (obj_toolPane.currentMode) {
				// Using the rez tool
				case obj_toolPane.modeRez:
					grid = obj_chain.rezChainGrid;
					if(ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowToSet) != obj_chain.rezTier) {
						show_message("Please Click on a word before deleting it's link");
						instance_destroy();
						exit;	
					}
					break;
				case obj_toolPane.modeTrack:
				// Using the track tool
					grid = obj_chain.trackChainGrid;
					if(ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowToSet) != obj_chain.trackTier) {
						show_message("Please Click on a word before deleting it's link");
						instance_destroy();
						exit;
					}
					break;
				default:
					if(ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowToSet) != obj_chain.rezTier) {
						instance_destroy();
						exit;
					}
					break;
			}
			
			ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowToSet, true);
		
		

			obj_chain.currentFocusedChainID = currentChainID;
			
			//var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(grid), currentChainID);
			ds_grid_set(grid, obj_chain.chainGrid_colChainState, rowInChainGrid, obj_chain.chainStateFocus);
				
			scr_deleteFromChain();
			instance_destroy();
			break;
		case "Delete Chunk":

			//obj_control.newWordHoverWordID = obj_control.rightClickWordID;
			obj_control.deleteChunkWord = true;
			//show_message("Coming Soon");
			scr_deleteFromChain();
			
			obj_control.deleteChunkWord = false;
			obj_control.rightClickonWord = false;
			instance_destroy();
			break;
		case "Split Line":
			
			if (instance_exists(obj_control)) {
				scr_splitLine(obj_control.rightClickWordID);
			}
			/*
			// get lineGridRow and wordIDList
			var lineGrid = obj_control.lineGrid;
			var lineGridRow = obj_control.rightClickDisplayRow;
			var wordIDList = ds_grid_get(lineGrid, obj_control.lineGrid_colWordIDList, lineGridRow);
			
			// make sure that wordIDList exists
			if (is_numeric(wordIDList)) {
				if (ds_exists(wordIDList, ds_type_list)) {
				
					// find rightClickWordID in wordIDList
					var wordIDListSize = ds_list_size(wordIDList);
					var rightClickWordIndex = ds_list_find_index(wordIDList, obj_control.rightClickWordID);
					show_debug_message("scr_rightClickWordOptions() ... wordIDList: " + scr_getStringOfList(wordIDList));
					show_debug_message("scr_rightClickWordOptions() ... rightClickWordIndex: " + string(rightClickWordIndex));
			
					// make sure that rightClickWordID is in wordIDList
					if (rightClickWordIndex >= 0) {
						
						// create a new row at the bottom of the lineGrid, then copy everything down a row
						ds_grid_resize(lineGrid, ds_grid_width(lineGrid), ds_grid_height(lineGrid) + 1);
						ds_grid_set_grid_region(lineGrid, lineGrid, 0, lineGridRow + 1, ds_grid_width(lineGrid), ds_grid_height(lineGrid) - 2, 0, lineGridRow + 2);
						ds_grid_set_grid_region(lineGrid, lineGrid, 0, lineGridRow, ds_grid_width(lineGrid), lineGridRow, 0, lineGridRow + 1);

						// split the existing wordIDList into 2 separate lists
						var splitIDList1 = ds_list_create();
						for (var i = 0; i < rightClickWordIndex; i++) {
							var currentWordID = ds_list_find_value(wordIDList, i);
							ds_list_add(splitIDList1, currentWordID);
						}
						var splitIDList2 = ds_list_create();
						for (var i = rightClickWordIndex; i < wordIDListSize; i++) {
							var currentWordID = ds_list_find_value(wordIDList, i);
							ds_list_add(splitIDList2, currentWordID);
						}
						
						show_debug_message("scr_rightClickWordOptions() ... splitIDList1: " + scr_getStringOfList(splitIDList1));
						show_debug_message("scr_rightClickWordOptions() ... splitIDList2: " + scr_getStringOfList(splitIDList2));
						
						// set the new split lists in the lineGrid
						ds_grid_set(lineGrid, obj_control.lineGrid_colWordIDList, lineGridRow, splitIDList1);
						ds_grid_set(lineGrid, obj_control.lineGrid_colWordIDList, lineGridRow + 1, splitIDList2);
						
						
						// add to the displayRow and pixelYOriginal for every following line in the lineGrid
						var prevDisplayRow = ds_grid_get(lineGrid, obj_control.lineGrid_colDisplayRow, lineGridRow);
						ds_grid_add_region(lineGrid, obj_control.lineGrid_colDisplayRow, lineGridRow + 1, obj_control.lineGrid_colDisplayRow, ds_grid_height(lineGrid), 1);
						ds_grid_add_region(lineGrid, obj_control.lineGrid_colPixelYOriginal, lineGridRow + 1, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(lineGrid), obj_control.gridSpaceVertical);
						
						// destroy the original wordIDList
						//ds_list_destroy(wordIDList);
					}
				}
			}
			
			
			*/
			
			
			instance_destroy();
			break;
			
			
			/*
		case "Recolor":
		
	
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Red", "Blue", "Green", "Gold", "Custom");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing * 3 , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 12;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}

			//show_message("BUH 4");
			break;
			*/
			
		default:
			break;
	}


}
