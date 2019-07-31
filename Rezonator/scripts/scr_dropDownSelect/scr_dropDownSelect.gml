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
switch (functionChainList_currentTab) {
	case functionChainList_tabRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case functionChainList_tabTrackBrush:
		grid = obj_chain.trackChainGrid;
		break;
	case functionChainList_tabStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	case functionChainList_tabClique:
		grid = obj_chain.cliqueDisplayGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
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
						
											
						obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 )
	
						
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.recolor = true;
						}


						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						
						break;
					case "Delete":
						//show_message("Delete chosen");

							var focusedRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
						
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
						scr_deleteEntireChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, focusedRow));
							//show_message(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, focusedRow));
							//show_message(focusedRow);
							
						break;
					default:
						break;
				}
					
		}
	}
}

instance_destroy();