var optionSelected = argument0;

//optionListType == 0 --> switch sorting columns for sort pane






if (optionListType == 0)
{
	with (obj_panelPane)
	{
		if (currentFunction == functionSort)
		{
			var rowInSortGrid = ds_grid_value_y(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, 0, functionSort_gridSortColGrid_colMouseover, ds_grid_height(functionSort_sortGrid), true);
			
			if (rowInSortGrid > -1)
			{
				var newSortCol = ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, rowInSortGrid);
				//"discoID", "unitStart", "unitEnd", "uID", "unitID"
				switch (optionSelected)
				{
					case "discoID":
						newSortCol = obj_control.lineGrid_colDiscoID;
						break;
					case "unitStart":
						newSortCol = obj_control.lineGrid_colUnitStart;
						break;
					case "unitEnd":
						newSortCol = obj_control.lineGrid_colUnitEnd;
						break;
					case "uID":
						newSortCol = obj_control.lineGrid_colLineNumberLabel;
						break;
					case "unitID":
						newSortCol = obj_control.lineGrid_colUnitID;
						break;
					default:
						break;
				}
				
				ds_grid_set(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, rowInSortGrid, newSortCol);
			}
		}
	}
}
else if (optionListType == 1)
{
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
		
		//show_message(ds_grid_height(grid));
		//show_message(obj_control.selectedChainID);
		if(ds_grid_height(grid) > 0){
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

						break;
					case "Recolor":
						//show_message("Recolor chosen");
						
											
						obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
	
	
	
	
						var dropDownOptionList = ds_list_create();
						ds_list_add(dropDownOptionList, "Red", "Blue", "Green", "Gold", "Custom");
						
						if (ds_list_size(dropDownOptionList) > 0) {
							var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = 2;
					
							obj_control.ableToCreateDropDown = false;
							obj_control.alarm[0] = 2;
						}
	
						/*
						
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.recolor = true;
						}


						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						
						
						*/
						break;
					case "Delete":
						//show_message("Delete chosen");

							var focusedRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
							obj_control.selectedChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, focusedRow);
							
							//show_message("focused Row: " + string(focusedRow));
							//show_message("chainId: " + string(obj_control.selectedChainID));
						/*
						var focusedRow = -1;
						if(focusedRow == -1){
							var focusedRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid), obj_chain.chainStateFocus);

							//var chosenGrid = ds_grid_copy(chosenGrid, obj_chain.rezChainGrid);
						
						
						if(focusedRow == -1){
							var focusedRow = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
							//var chosenGrid = ds_grid_copy(chosenGrid, obj_chain.trackChainGrid);
						}
						if(focusedRow == -1){
							var focusedRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
							//var chosenGrid = ds_grid_copy(chosenGrid, obj_chain.stackChainGrid);
						}
						*/
						scr_deleteEntireChain(obj_control.selectedChainID);
							
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
						break;
					default:
						break;
				}
					
		}
	}
}
else if (optionListType == 2)
{
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
		
		//show_message(ds_grid_height(grid));
		if(ds_grid_height(grid) > 0){
			var listOfWordID = ds_list_create();
			ds_list_copy(listOfWordID, ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, obj_control.selectedChainID));
		}

				switch (optionSelected)
				{
					//"Red", "Blue", "Green", "Gold", "Custom"
					case "Red":
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(255)));
							}
						}
						ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(255)));
						break;
						
					case "Blue":	
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(16711680)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(16711680)));
						break;
						
					case "Green":
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(65280)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(65280)));
						break;
						
					case "Gold":
					
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(4235000)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(4235000)));
						break;
						
					case "Custom":
					
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.recolor = true;
						}


						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						
						break;
					default:
						break;
				}
		}
	}
}

instance_destroy();