var rowInCliqueGrid = argument0;

var rangeStart = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeStart, rowInCliqueGrid);
var rangeEnd = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colRangeEnd, rowInCliqueGrid);

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
				}
			}
		}
	}
	
	if not (wordInDisplayCol)
	{
		show_message("Break detected in display column " + string(displayColCheck));
	}
}