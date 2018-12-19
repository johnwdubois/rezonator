var jumpToStart = argument0;
var currentActiveLineGrid = obj_control.currentActiveLineGrid;
var currentActiveWordGrid = obj_control.dynamicWordGrid;
var currentActiveWordGridDisplayCol = obj_control.dynamicWordGrid_colDisplayCol;

if (obj_control.searchGridActive)
{
	currentActiveWordGrid = obj_control.hitGrid;
	//currentActiveWordGridDisplayCol = obj_control.
}

var rowInLineGrid = ds_grid_value_y(currentActiveLineGrid, obj_control.lineGrid_colDisplayRow, 0, obj_control.lineGrid_colDisplayRow, ds_grid_height(currentActiveLineGrid), obj_control.currentCenterDisplayRow);

if (rowInLineGrid < 0 or rowInLineGrid >= ds_grid_height(currentActiveLineGrid))
{
	show_debug_message("rowInLineGrid out of bounds");
	exit;
}

var furthestDisplayCol = 0;
var currentRow = rowInLineGrid;
var add = false;

for (var i = 0; i < 2; i++)
{
	if (i == 1)
	{
		add = true;
	}
	
	currentRow = rowInLineGrid;
	
	var moves = 0;
	while (ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentRow) > 0
	and ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentRow) < room_height
	and currentRow >= 0 and currentRow < ds_grid_height(currentActiveLineGrid) and moves < 30)
	{
		var wordIDList = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colWordIDList, currentRow);
		
		if (jumpToStart)
		{
			var firstWordInList = ds_list_find_value(wordIDList, 0);
			
			if (firstWordInList >= 0 and firstWordInList < ds_grid_height(obj_control.dynamicWordGrid))
			{
				var firstWordDisplayCol = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colDisplayCol, firstWordInList - 1);
			
				if (firstWordDisplayCol < furthestDisplayCol)
				{
					furthestDisplayCol = firstWordDisplayCol;
				}
			}
		}
		else
		{
			var lastWordInList = ds_list_find_value(wordIDList, ds_list_size(wordIDList) - 1);
			if (lastWordInList >= 0 and lastWordInList < ds_grid_height(obj_control.dynamicWordGrid))
			{
				var lastWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, lastWordInList - 1);
			
				if (lastWordDisplayCol > furthestDisplayCol)
				{
					furthestDisplayCol = lastWordDisplayCol;
				}
			}
		}
		
		if (add)
		{
			currentRow++
		}
		else
		{
			currentRow--;
		}
		moves++;
	}
}

if (jumpToStart)
{
	obj_control.wordLeftMarginDest = -(furthestDisplayCol * obj_control.gridSpaceHorizontal) + (obj_control.gridSpaceHorizontal * 2);
}
else
{
	obj_control.wordLeftMarginDest = -(furthestDisplayCol * obj_control.gridSpaceHorizontal) + (obj_control.gridSpaceHorizontal * 10);
}