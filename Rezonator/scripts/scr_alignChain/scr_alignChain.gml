var wordIDList = argument0;

var furthestDisplayCol = 0;


if (ds_list_size(wordIDList) > 0)
{
	var furthestWordID = ds_list_find_value(wordIDList, 0);
		
	for (var displayColLoop = 0; displayColLoop < ds_list_size(wordIDList); displayColLoop++)
	{
		var currentWordID = ds_list_find_value(wordIDList, displayColLoop);
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
		//currentDisplayCol += ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colZigzag, currentWordID - 1);
		
		//furthestDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestWordID - 1);
		
		if (currentDisplayCol > furthestDisplayCol)
		{
			furthestWordID = currentWordID;
			furthestDisplayCol = currentDisplayCol;
		}
	}
	
	if (keyboard_check(vk_space) and obj_control.showDevMessages)
	{
		//var dbb = "";
		//for (db = 0; db < ds_list_size(wordIDList); db++)
		show_message("furthest: " + string(furthestDisplayCol));
	}
		
	//furthestDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestWordID - 1);
		
	for (var setDisplayColLoop = 0; setDisplayColLoop < ds_list_size(wordIDList); setDisplayColLoop++)
	{
		var currentWordID = ds_list_find_value(wordIDList, setDisplayColLoop);
		
		if (keyboard_check(vk_space) and obj_control.showDevMessages)
		{
			show_message("currentWordID: " + string(currentWordID));
		}
		//var nextWordID = currentWordID + 1;
		//var nextWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, nextWordID - 1);

		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);
	}
}