var rowInCliqueGrid = argument0;

var rangeStart = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeStart, rowInCliqueGrid);
var rangeEnd = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeEnd, rowInCliqueGrid);

if (showDevMessages)
{
	show_message("break check from " + string(rangeStart) + " to " + string(rangeEnd));
}

var displayColCheckMin = 99999999;
var displayColCheckMax = 0;

for (var i = rangeStart; i < rangeEnd; i++)
{
	var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, i);
	
	for (var j = 0; j < ds_list_size(currentWordIDList); j++)
	{
		var currentWordID = ds_list_find_value(currentWordIDList, j);
		
		if (currentWordID >= 0 and currentWordID <= ds_grid_height(obj_control.wordGrid))
		{
			var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
			if (currentDisplayCol < displayColCheckMin)
			{
				displayColCheckMin = currentDisplayCol;
			}
			if (currentDisplayCol > displayColCheckMax)
			{
				displayColCheckMax = currentDisplayCol;
			}
		}
	}
}


var wordToZigzag = -1;

for (var displayColCheck = displayColCheckMin; displayColCheck < displayColCheckMax; displayColCheck++)
{	
	var wordInDisplayCol = false;
	
	for (var i = rangeStart; i < rangeEnd; i++)
	{
		var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, i);
	
		for (var j = 0; j < ds_list_size(currentWordIDList); j++)
		{
			var currentWordID = ds_list_find_value(currentWordIDList, j);
		
			if (currentWordID >= 0 and currentWordID <= ds_grid_height(obj_control.wordGrid))
			{
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				
				if (displayColCheck == currentDisplayCol)
				{
					wordInDisplayCol = true;
					wordToZigzag = currentWordID;
				}
			}
		}
	}
	
	if not (wordInDisplayCol)
	{
		//show_message("Break detected in display column " + string(displayColCheck));
		//var wordToZigzagString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordToZigzag - 1);
		//show_message("Adding -1 to wordID " + string(wordToZigzag) + ", " + wordToZigzagString);
		//var wordToZigzagCurrentZigzag = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colZigzag, wordToZigzag - 1);
		//ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colZigzag, wordToZigzag -1, wordToZigzagCurrentZigzag - 1);
		
		cliqueGridRowToCheckBreak = rowInCliqueGrid;
		alarm[2] = 1;
		exit;
	}
}