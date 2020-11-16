function scr_refreshTilt(rowInRezChainGrid) {

	if (rowInRezChainGrid < 0)
	{
		exit;
	}

	var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, rowInRezChainGrid);
	var rowStart = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid, ds_grid_height(obj_chain.linkGrid), chainID);

	if (rowStart < 0)
	{
		exit;
	}


	//var keepLooping = true;
	var currentRow = rowStart;
	var currentSource = 0;
	var currentSourceDisplayCol = 0;
	var currentGoal = 0;
	var currentGoalDisplayCol = 0;
	var tiltSum = 0;

	while (currentRow >= 0 && currentRow < ds_grid_height(obj_chain.linkGrid) && ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentRow) == chainID)
	{
		//show_debug_message("in loop");
	
		if (ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colDead, currentRow))
		{
			currentRow++;
			continue;
		}
		else
		{
		
			currentSource = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentRow);
			currentGoal = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, currentRow);
		
			if (currentSource < 0 or currentSource >= ds_grid_height(obj_control.dynamicWordGrid))
			{
				currentRow++;
				//show_debug_message("invalid source");
				if (currentRow >= ds_grid_height(obj_chain.linkGrid))
				{
					break;
				}
				continue;
			}
			if (currentGoal < 0 or currentGoal >= ds_grid_height(obj_control.dynamicWordGrid))
			{
				currentRow++;
				//show_debug_message("invalid goal");
				if (currentRow >= ds_grid_height(obj_chain.linkGrid))
				{
					break;
				}
				continue;
			}
		
			currentSourceDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentSource - 1);
			currentGoalDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentGoal - 1);
		
			//show_debug_message("row " + string(currentRow) + ", sourceDisplayCol = " + string(currentSourceDisplayCol) + ", goalDisplayCol = " + string(currentGoalDisplayCol));
		
		
			ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colTilt, currentRow, abs(currentSourceDisplayCol - currentGoalDisplayCol));
			tiltSum += abs(currentSourceDisplayCol - currentGoalDisplayCol);
			currentRow++;
			if (currentRow >= ds_grid_height(obj_chain.linkGrid))
			{
					break;
			}
		}
	}

	ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colTiltSum, rowInRezChainGrid, tiltSum);


}
