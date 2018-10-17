var rowInCliqueGrid = argument0;

show_message("break check in clique grid row " + string(rowInCliqueGrid));

if (rowInCliqueGrid < 0 or rowInCliqueGrid >= ds_grid_height(obj_chain.cliqueGrid))
{
	exit;
}

var rangeStart = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeStart, rowInCliqueGrid);
var rangeEnd = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeEnd, rowInCliqueGrid);






// Get flanks
scr_cliqueGridRefreshFlanks(rowInCliqueGrid);

var flankLeft = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colFlankLeft, rowInCliqueGrid);
var flankRight = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colFlankRight, rowInCliqueGrid);


if (obj_control.showDevMessages)
{
	show_message("break check from Unit" + string(rangeStart) + " to Unit" + string(rangeEnd)
	+ "and flank " + string(flankLeft) + " to flank " + string(flankRight));
}




//var wordToZigzag = -1;

for (var displayColCheck = flankLeft; displayColCheck <= flankRight; displayColCheck++)
{	
	var wordInDisplayCol = false;
	
	for (var i = rangeStart; i < rangeEnd; i++)
	{
		if (wordInDisplayCol)
		{
			continue;
		}
		
		var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, i - 1);
	
		for (var j = 0; j < ds_list_size(currentWordIDList); j++)
		{
			if (wordInDisplayCol)
			{
				continue;
			}
			
			var currentWordID = ds_list_find_value(currentWordIDList, j);
		
			if (currentWordID >= 0 and currentWordID <= ds_grid_height(obj_control.wordGrid))
			{
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				
				if (displayColCheck == currentDisplayCol)
				{
					
					wordInDisplayCol = true;
					//wordToZigzag = currentWordID;
					
					if (obj_control.showDevMessages)
					{
						var wordFoundString = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1));
						show_message("word found in col " + string(displayColCheck) + ": " + wordFoundString);
					}
				}
			}
		}
	}
	
	if not (wordInDisplayCol)
	{
		if (obj_control.showDevMessages)
		{
			show_message("Break detected in display column " + string(displayColCheck));
		}
		
		/*
		if (cliqueGridChainIndexToTakeOut >= 0 and cliqueGridChainIDTakenOut >= 0
		and ds_list_find_index(chainIDList, cliqueGridChainIDTakenOut) == -1)
		{
			ds_list_add(chainIDList, cliqueGridChainIDTakenOut);
			ds_list_sort(chainIDList, true);
			
			scr_setChainAlign(cliqueGridChainIDTakenOut, true);
			
			if (obj_control.showDevMessages)
			{
				show_message("Re-inserting chain " + string(cliqueGridChainIDTakenOut));
			}
		}
		
		if (cliqueGridChainIndexToTakeOut < ds_list_size(chainIDList))
		{
			cliqueGridChainIndexToTakeOut++;
		}
		else
		{
			cliqueGridChainIndexToTakeOut = -1;
		}
		
		if (cliqueGridChainIndexToTakeOut > -1 and cliqueGridChainIndexToTakeOut < ds_list_size(chainIDList))
		{
			var chainToTakeOut = -1;
			var chainIndexToTakeOut = cliqueGridChainIndexToTakeOut;
			while (chainToTakeOut < 0)
			{
				var currentChainTestToTakeOut = ds_list_find_value(chainIDList, chainIndexToTakeOut);
				if (scr_getChainAlign(currentChainTestToTakeOut))
				{
					chainToTakeOut = currentChainTestToTakeOut;
					break;
				}
				
				chainIndexToTakeOut++;
				if (chainIndexToTakeOut >= ds_list_size(chainIDList))
				{
					exit;
				}
			}
			
			cliqueGridChainIDTakenOut = chainToTakeOut;
			scr_setChainAlign(chainToTakeOut, false);
			
			ds_list_delete(chainIDList, cliqueGridChainIndexToTakeOut);
			
			if (obj_control.showDevMessages)
			{
				show_message("Taking out chain " + string(cliqueGridChainIDTakenOut));
			}
		}
		
		//var wordToZigzagString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordToZigzag - 1);
		//show_message("Break detected in display column " + string(displayColCheck));
		//var wordToZigzagString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordToZigzag - 1);
		//show_message("Adding -1 to wordID " + string(wordToZigzag) + ", " + wordToZigzagString);
		//var wordToZigzagCurrentZigzag = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colZigzag, wordToZigzag - 1);
		//ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colZigzag, wordToZigzag -1, wordToZigzagCurrentZigzag - 1);
		
		cliqueGridRowToCheckBreak = rowInCliqueGrid;
		alarm[2] = 3;
		exit;
	}
	else
	{
		cliqueGridRowToCheckBreak = -1;
	}
	*/
	}
}