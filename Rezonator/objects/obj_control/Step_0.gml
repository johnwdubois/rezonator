if (!gridView)
{

	if (keyboard_check(vk_down))
	{
		if (holdDownArrowKey == 0 or holdDownArrowKey > 30)
		{
			currentCenterDisplayRow++;
		}
	
		holdDownArrowKey++;
	}

	if (keyboard_check_released(vk_down))
	{
		holdDownArrowKey = 0;
	}


	if (keyboard_check(vk_up))
	{
		if (holdUpArrowKey == 0 or holdUpArrowKey > 30)
		{
			currentCenterDisplayRow--;
		}
		holdUpArrowKey++;
	}

	if (keyboard_check_released(vk_up))
	{
		holdUpArrowKey = 0;
	}

	if (keyboard_check_pressed(vk_pagedown))
	{
		currentCenterDisplayRow += drawRange;
	}

	if (keyboard_check_pressed(vk_pageup))
	{
		currentCenterDisplayRow -= drawRange;
	}

	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_down))
	{
		currentCenterDisplayRow = ds_grid_height(currentActiveLineGrid) - 1;
		
		for (var i = (currentCenterDisplayRow - drawRangeEnd); i < currentCenterDisplayRow; i++)
		{
			if (i < 0 or i >= ds_grid_height(lineGrid))
			{
				break;
			}
			
			var currentLineDestY = (ds_grid_get(currentActiveLineGrid, lineGrid_colDisplayRow, i) - currentCenterDisplayRow) * gridSpaceVertical + (room_height / 2);
			ds_grid_set(currentActiveLineGrid, lineGrid_colPixelY, i, currentLineDestY);
		}
	}

	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_up))
	{
		currentCenterDisplayRow = 0;
		
		for (var i = currentCenterDisplayRow; i < drawRange + 10; i++)
		{
			if (i >= ds_grid_height(lineGrid))
			{
				break;
			}
			
			var currentLineDestY = (ds_grid_get(currentActiveLineGrid, lineGrid_colDisplayRow, i) - currentCenterDisplayRow) * gridSpaceVertical + (room_height / 2);
			ds_grid_set(currentActiveLineGrid, lineGrid_colPixelY, i, currentLineDestY);
		}
	}

	if (keyboard_check_pressed(vk_right) and not keyboard_check(vk_control))
	{
		wordLeftMarginDest -= gridSpaceHorizontal;
	}
	else if (keyboard_check_pressed(vk_right) and keyboard_check(vk_control))
	{
		var rowInLineGrid = ds_grid_value_y(lineGrid, lineGrid_colDisplayRow, 0, lineGrid_colDisplayRow, ds_grid_height(lineGrid), currentCenterDisplayRow);
		if (rowInLineGrid >= 0 && rowInLineGrid < ds_grid_height(lineGrid))
		{
			var wordIDList = ds_grid_get(lineGrid, lineGrid_colWordIDList, rowInLineGrid);
			var lastWordInList = ds_list_find_value(wordIDList, ds_list_size(wordIDList) - 1);
			var lastWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, lastWordInList - 1);
			
			wordLeftMarginDest = -(lastWordDisplayCol * gridSpaceHorizontal) + (gridSpaceHorizontal * 5);
		}
	}

	if (keyboard_check_pressed(vk_left) and not keyboard_check(vk_control))
	{
		wordLeftMarginDest += gridSpaceHorizontal;
	}
	else if (keyboard_check_pressed(vk_left) and keyboard_check(vk_control))
	{
		wordLeftMarginDest = speakerLabelMargin;
	}
	
	if (wordDrawGridFocusedAnimationInc)
	{
		if (wordDrawGridFocusedAnimation < wordDrawGridFocusedAnimationMax)
		{
			wordDrawGridFocusedAnimation += 0.1;
		}
		else
		{
			wordDrawGridFocusedAnimationInc = false;
		}
	}
	else
	{	
		if (wordDrawGridFocusedAnimation > 0)
		{
			wordDrawGridFocusedAnimation -= 0.1;
		}
		else
		{
			wordDrawGridFocusedAnimationInc = true;
		}
	}
}

if (wordLeftMargin < wordLeftMarginDest)
{
	wordLeftMargin += abs(wordLeftMargin - wordLeftMarginDest) / 6;
}
else if (wordLeftMargin > wordLeftMarginDest)
{
	wordLeftMargin -= abs(wordLeftMargin - wordLeftMarginDest) / 6;
}







if (keyboard_check_pressed(ord("P")))
{
	gridSpaceVertical += 10;
}

if (keyboard_check_pressed(ord("M")))
{
	gridSpaceVertical -= 10;
}

if (keyboard_check_pressed(ord("Q")))
{
	displayRowAscending = !displayRowAscending;
	ds_grid_sort(currentActiveLineGrid, lineGrid_colDisplayRow, displayRowAscending);
	scr_refreshLineGridDisplayRow(obj_control.lineGrid);
}


if (keyboard_check_pressed(ord("E")))
{
	scr_shuffleDisplayRows();
	scr_refreshLineGridDisplayRow(obj_control.lineGrid);
}





currentCenterDisplayRow = max(currentCenterDisplayRow, 0);
currentCenterDisplayRow = min(currentCenterDisplayRow, ds_grid_height(currentActiveLineGrid) - 1);

mouseoverPanelPane = false;
for (var i = 0; i < instance_number(obj_panelPane); i++)
{
	var panelPaneInst = instance_find(obj_panelPane, i);
	if (point_in_rectangle(mouse_x, mouse_y, panelPaneInst.x, panelPaneInst.y, panelPaneInst.x + panelPaneInst.windowWidth, panelPaneInst.y + panelPaneInst.windowHeight))
	{
		mouseoverPanelPane = true;
	}
}

if (ds_grid_height(unitGrid) == global.totalUnitAmount and ds_grid_height(obj_chain.unitInStackGrid) == 0)
{
	with (obj_chain)
	{
		scr_loadUnitInStackGrid();
	}
}

if not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) or not (currentActiveLineGrid == lineGrid)
{
	newWordHoverUnitID = -1;
	newWordHoverWordSeq = -1;
	newWordHoverWordID = -1;
}


if (instance_exists(obj_dropDown))
{
	ableToCreateDropDown = false;
}
if (not instance_exists(obj_dropDown) and not ableToCreateDropDownAlarmSet)
{
	alarm[0] = 2;
	ableToCreateDropDownAlarmSet = true;
}