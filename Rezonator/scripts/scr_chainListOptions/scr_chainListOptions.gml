function scr_chainListOptions(argument0) {
	var optionSelected = argument0;

	with (obj_panelPane)
	{
		if (currentFunction == functionChainList)
		{
			
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
		
			obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
			if(obj_control.selectedChainID == undefined){
				exit;
			}
			//show_message(ds_grid_height(grid));
			//show_message(obj_control.selectedChainID);
			if(ds_grid_height(grid) > 0 && grid != obj_chain.stackChainGrid){
				var listOfWordID = ds_list_create();
				ds_list_copy(listOfWordID, ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, obj_control.selectedChainID));
			}

			//"Rename", "Recolor", "Delete"
			switch (optionSelected)
			{
				case "Rename":
					//show_message("Rename chosen");
						
					obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 )
						
						
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.rename = true;
					}


					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
						instance_destroy(obj_dropDown);
						//return true;	
					break;
				case "Recolor":
					//might be a special case
											
					obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
	
					var dropDownOptionList = ds_list_create();
					ds_list_add(dropDownOptionList, "Red", "Blue", "Green", "Gold", "Custom");
						
					if (ds_list_size(dropDownOptionList) > 0) {
						var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = 2;
					
						obj_control.ableToCreateDropDown = false;
						obj_control.alarm[0] = 2;
					}
	
					break;
				case "Delete":
					//show_message("Delete chosen");

						var focusedRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
						obj_control.selectedChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, focusedRow);
							
						//show_message("focused Row: " + string(focusedRow));
						//show_message("chainId: " + string(obj_control.selectedChainID));
				
						
						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
							obj_dialogueBox.clearChain = true;
							obj_dialogueBox.questionWindowActive = true;
						}
		
							
							instance_destroy(obj_dropDown);
							//return true;
					break;
				case "Caption":
				//show_message("Caption clicked");

					obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
	
		
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.caption = true;
					}


					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
						instance_destroy(obj_dropDown);
						//return true;
					break;
				default:
					break;
			}
					
		}
	}


}
