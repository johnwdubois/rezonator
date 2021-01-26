function scr_rightClickWordOptions(optionSelected) {

	switch (optionSelected)
	{

		case "Tag":
				
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Create tag", "Edit Tag", "Delete tag");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y+ obj_dropDown.optionSpacing * 4, dropDownOptionList, global.optionListTypeWordTags);
			}
			break;
		case "Replace Word":
		
			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {

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
	
			break;
		case "Split Word":
		
			scr_destroyAllDropDownsOtherThanSelf();
			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {

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

			break;
		case "New Word":
		
		
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "<0>", "<ZERO>", "<PRO>", "Custom");
						

			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + obj_dropDown.optionSpacing, dropDownOptionList, global.optionListTypeNewWord);
			}
	
		
		


			break;
		case "Delete New Word":
			scr_destroyAllDropDownsOtherThanSelf();

			
			
			var inChainsList = ds_grid_get(obj_control.dynamicWordGrid,obj_control.dynamicWordGrid_colInChainList, obj_control.rightClickWordID-1);
		
			// get inChainsListSize and submap of focusedChain
			var inChainsListSize = ds_list_size(inChainsList);

	
			// next, we need to see if the hoverWord has a chain of the same type as the currently focused chain
			var chainToSelect = "";
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChain = ds_list_find_value(inChainsList, i);
				chainToSelect = currentChain;
				break;
			}
	
			if (chainToSelect != "" || ds_map_exists(global.nodeMap, chainToSelect)) {
				show_debug_message("scr_rightclickwordOptions() ... word has no chains no slectioon should happen...");
				obj_chain.currentFocusedChainID = chainToSelect;
			}
			

			if(chainToSelect != ""){
				//scr_deleteFromChain();
			}
			
			obj_control.newWordHoverWordID = obj_control.rightClickWordID;
			obj_control.deleteNewWord = true;
			scr_deleteFromChain();
			
			obj_control.deleteNewWord = false;
			obj_control.rightClickonWord = false;
			instance_destroy();
	
			break;
		case "Delete Link":
			
			var inChainsList = ds_grid_get(obj_control.dynamicWordGrid,obj_control.dynamicWordGrid_colInChainList, obj_control.rightClickWordID-1);
		
			// get inChainsListSize and submap of focusedChain
			var inChainsListSize = ds_list_size(inChainsList);

	
			// next, we need to see if the hoverWord has a chain of the same type as the currently focused chain
			var chainToSelect = "";
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChain = ds_list_find_value(inChainsList, i);
				chainToSelect = currentChain;
				break;
			}
	
			if (chainToSelect != "" || ds_map_exists(global.nodeMap, chainToSelect)) {
				show_debug_message("scr_rightclickwordOptions() ... word has no chains no slectioon should happen...");
				obj_chain.currentFocusedChainID = chainToSelect;
				scr_deleteFromChain();
			}
			
			


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
