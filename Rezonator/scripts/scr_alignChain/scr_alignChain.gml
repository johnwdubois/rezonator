var wordIDList = argument0;
var pushOut = argument1;

var furthestDisplayCol = 0;

var unitIDList = ds_list_create();
var nonVoidWordExists = false;

if (ds_list_size(wordIDList) > 0)
{
	var furthestWordID = ds_list_find_value(wordIDList, 0);
		
	for (var displayColLoop = 0; displayColLoop < ds_list_size(wordIDList); displayColLoop++)
	{
		var currentWordID = ds_list_find_value(wordIDList, displayColLoop);
		
		var currentWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1);
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		
		if (ds_list_find_index(unitIDList, currentUnitID) > -1)
		{
			continue;
		}
		ds_list_add(unitIDList, currentUnitID);
		
		var currentVoid = 0;
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
		var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
		var previousDisplayCol = -1;
		if (currentWordSeq == 0 or currentWordID - 2 < 0)
		{
			currentVoid = currentDisplayCol;
		}
		else 
		{
			previousDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 2);
			currentVoid = abs(currentDisplayCol - (previousDisplayCol + 1));
		}
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1, currentVoid);
		
		
		//currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
		
		if (currentDisplayCol > furthestDisplayCol and currentWordAligned)
		{
			furthestWordID = currentWordID;
			furthestDisplayCol = currentDisplayCol;
		}
		
		if ((not pushOut and currentVoid > 0) or (not currentWordAligned and currentVoid > 0))
		{
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol - 1);
			currentVoid = abs(currentDisplayCol - (previousDisplayCol + 1));
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1, currentVoid);
		}
		
		
		if (not currentWordAligned or (not pushOut and currentVoid > 0))
		{
			continue;
		}
		
		if (currentVoid < 1)
		{
			nonVoidWordExists = true;
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
	var unitIDList2 = ds_list_create();
	for (var setDisplayColLoop = 0; setDisplayColLoop < ds_list_size(wordIDList); setDisplayColLoop++)
	{
		var currentWordID = ds_list_find_value(wordIDList, setDisplayColLoop);
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		
		if (not ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1))
		{
			/*
			var nextWordID = currentWordID + 1;
			if (nextWordID >= 0 and nextWordID < ds_grid_height(obj_control.wordGrid))
			{
				var nextUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, nextWordID - 1);
				if (nextUnitID == currentUnitID)
				{
					var nextDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, nextWordID - 1);
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, nextDisplayCol - 1);
				}
			}
			*/
			
			continue;
		}
		
		var currentRowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
		if (currentRowInLineGrid >= 0 and currentRowInLineGrid < ds_grid_height(obj_control.lineGrid))
		{
			if (ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colVoidMax, currentRowInLineGrid) >= obj_control.voidLimit)
			{
				continue;
			}
		}
		
		//if (obj_control.showDevMessages)v
		//{
		//	show_message("currentWordID: " + string(currentWordID));
		//}
		
		
		//var nextWordID = currentWordID + 1;
		//var nextWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, nextWordID - 1);
		
		if (ds_list_find_index(unitIDList2, currentUnitID) == -1)
		{
			ds_list_add(unitIDList2, currentUnitID);
			if (pushOut)
			{
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				if (currentWordID == obj_control.mostRecentlyAddedWord and furthestDisplayCol > currentDisplayCol)
				{
					if (not obj_control.mostRecentlyAddedWordMoved)
					{
						obj_control.mostRecentlyAddedWordMoved = true;
						obj_control.alarm[2] = 5;
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);
					}
					else
					{
						//show_message("BREAK");
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1, false);
					}
				}
				else
				{
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);
				}
			}
		}
	}
	ds_list_destroy(unitIDList2);
}

if (not nonVoidWordExists)
{
	for (var i = 0; i < ds_list_size(wordIDList); i++)
	{
		var currentWordID = ds_list_find_value(wordIDList, i);
		var currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
		if (currentVoid <= 0)
		{
			continue;
		}
		
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
		var currentUnitID = ds_grid_get(obj_control.dynamicWordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);

		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol - 1);
	}
}

ds_list_destroy(unitIDList);