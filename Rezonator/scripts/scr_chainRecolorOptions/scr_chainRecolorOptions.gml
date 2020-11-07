function scr_chainRecolorOptions(optionSelected) {

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
							var listOfWordIDSize = ds_list_size(listOfWordID);
							for(var i = 0; i < listOfWordIDSize;i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(255)));
							}
						}
						ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(255)));
						break;
						
					case "Blue":	
						if( grid != obj_chain.stackChainGrid){
							var listOfWordIDSize = ds_list_size(listOfWordID);
							for(var i = 0; i < listOfWordIDSize;i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(16711680)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(16711680)));
						break;
						
					case "Green":
						if( grid != obj_chain.stackChainGrid){
							var listOfWordIDSize = ds_list_size(listOfWordID);
							for(var i = 0; i < listOfWordIDSize;i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(65280)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(65280)));
						break;
						
					case "Gold":
					
						if( grid != obj_chain.stackChainGrid){
							var listOfWordIDSize = ds_list_size(listOfWordID);
							for(var i = 0; i < listOfWordIDSize;i++){
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
