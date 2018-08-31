var wordIDList = argument0;

var furthestDisplayCol = 0;

if (ds_list_size(wordIDList) > 0)
{
	var furthestWordID = ds_list_find_value(wordIDList, 0);
		
	for (var displayColLoop = 0; displayColLoop < ds_list_size(wordIDList); displayColLoop++)
	{
		var currenWordID = ds_list_find_value(wordIDList, displayColLoop);
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currenWordID - 1);
		furthestDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestWordID - 1);
		
		if (currentDisplayCol > furthestDisplayCol)
		{
			furthestWordID = currenWordID;
		}
	}
		
	furthestDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestWordID - 1);
		
	for (var setDisplayColLoop = 0; setDisplayColLoop < ds_list_size(wordIDList); setDisplayColLoop++)
	{
		var currentWordID = ds_list_find_value(wordIDList, setDisplayColLoop);		
		var nextWordID = currentWordID + 1;
		var nextWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, nextWordID - 1);

		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);
	}
}