var wordIDList = argument0;

var furthestDisplayCol = 0;

var unitIDList = ds_list_create();


if (ds_list_size(wordIDList) > 0)
{
	var furthestWordID = ds_list_find_value(wordIDList, 0);
		
	for (var displayColLoop = 0; displayColLoop < ds_list_size(wordIDList); displayColLoop++)
	{
		var currentWordID = ds_list_find_value(wordIDList, displayColLoop);
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		
		if (ds_list_find_index(unitIDList, currentUnitID) > -1)
		{
			continue;
		}
		ds_list_add(unitIDList, currentUnitID);
		
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
		//currentDisplayCol += ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colZigzag, currentWordID - 1);
		
		//furthestDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestWordID - 1);

		
		if (currentDisplayCol > furthestDisplayCol)
		{
			furthestWordID = currentWordID;
			furthestDisplayCol = currentDisplayCol;
		}
	}
	
	//if (ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, furthestWordID) > 0)
	//var furthestPreviousWordID = furthestWordID - 1;
	
	if (keyboard_check(vk_space) and obj_control.showDevMessages)
	{
		var dbb = "";
		for (db = 0; db < ds_list_size(wordIDList); db++)
		{
			dbb += string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, ds_list_find_value(wordIDList, db) - 1)) + ", ";
		}
		show_message(dbb + "... furthest: " + string(furthestDisplayCol));
	}
		
	//furthestDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestWordID - 1);
		
	for (var setDisplayColLoop = 0; setDisplayColLoop < ds_list_size(wordIDList); setDisplayColLoop++)
	{
		var currentWordID = ds_list_find_value(wordIDList, setDisplayColLoop);
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		var currentRowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
		if (currentRowInLineGrid >= 0 and currentRowInLineGrid < ds_grid_height(obj_control.lineGrid))
		{
			if (ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colVoidMax, currentRowInLineGrid) >= obj_control.voidLimit)
			{
				continue;
			}
		}
		
		//if (obj_control.showDevMessages)
		//{
		//	show_message("currentWordID: " + string(currentWordID));
		//}
		
		
		//var nextWordID = currentWordID + 1;
		//var nextWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, nextWordID - 1);

		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);
	}
}

ds_list_destroy(unitIDList);