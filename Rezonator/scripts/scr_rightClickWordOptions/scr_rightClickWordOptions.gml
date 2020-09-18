function scr_rightClickWordOptions(argument0) {
	var optionSelected = argument0;

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
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y+ obj_dropDown.optionSpacing*4, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 9;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}

			//show_message("BUH 2");
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
				if(!obj_control.wordTokenView){
					var originalWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, obj_control.rightClickWordID - 1);
				}
				else{
					var originalWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, obj_control.rightClickWordID - 1);
				}
		
			scr_replaceWord( obj_control.rightClickWordID , originalWord);
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord , obj_control.rightClickWordID - 1, "");
			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			//show_message("BUH 1");
			break;
		case "Split Word":

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
		
		
		
						var dropDownOptionList = ds_list_create();
						ds_list_add(dropDownOptionList, "<0>", "<ZERO>", "<PRO>", "Custom");
						
						if (ds_list_size(dropDownOptionList) > 0) {
							var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing*3  , -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = 11;
					
							obj_control.ableToCreateDropDown = false;
							obj_control.alarm[0] = 2;
						}
	
		
		

			//show_message("BUH 3");
			break;
		case "Delete New Word":
			obj_control.newWordHoverWordID = obj_control.rightClickWordID;
			obj_control.deleteNewWord =true;
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
					if(ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowToSet) != 1) {
						show_message("Please focus on a link before deleting it");
						instance_destroy();
						exit;	
					}
					break;
				case obj_toolPane.modeTrack:
				// Using the track tool
					grid = obj_chain.trackChainGrid;
					if(ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowToSet) != 2) {
						show_message("Please focus on a link before deleting it");
						instance_destroy();
						exit;
					}
					break;
				default:
					if(ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowToSet) != 1) {
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
