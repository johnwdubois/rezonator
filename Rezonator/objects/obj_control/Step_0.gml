if (!gridView)
{
	if (ds_grid_height(currentActiveLineGrid) > 0)
	{
		var firstLinePixelY = (room_height / 2) - (currentCenterDisplayRow * gridSpaceVertical);
		if (firstLinePixelY > 150 + gridSpaceVertical)
		{
			currentCenterDisplayRow++;
		}
		
		
		var lastLinePixelY = (room_height / 2) + ((ds_grid_height(currentActiveLineGrid) - currentCenterDisplayRow) * gridSpaceVertical);
		if (lastLinePixelY < camera_get_view_height(view_camera[0]) - 30
		and currentCenterDisplayRow + drawRange >= ds_grid_height(currentActiveLineGrid))
		{
			currentCenterDisplayRow--;
		}
		currentCenterDisplayRow = min(currentCenterDisplayRow, ds_grid_height(currentActiveLineGrid) - 1);
		currentCenterDisplayRow = max(currentCenterDisplayRow, 0);
	}

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
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_up))
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
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_subtract)
	or (keyboard_check(vk_control) and keyboard_check_direct(189)) and canPressPlus and gridSpaceHorizontal > 40)
	{
		canPressPlus = false;
		alarm[3] = 15;
		gridSpaceHorizontal -= 20;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_add)
	or (keyboard_check(vk_control) and keyboard_check_direct(187)) and canPressMinus and gridSpaceHorizontal < 400)
	{
		canPressMinus = false;
		alarm[4] = 15;
		gridSpaceHorizontal += 20;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_numpad0)
	or keyboard_check(vk_control) and keyboard_check_pressed(ord("0")))
	{
		gridSpaceHorizontal = 100;
	}

	if (keyboard_check_pressed(vk_right) and not keyboard_check(vk_control))
	{
		wordLeftMarginDest -= gridSpaceHorizontal;
	}
	if (keyboard_check_pressed(vk_right) and keyboard_check(vk_control)
	or keyboard_check_pressed(vk_end))
	{
		scr_jumpToEnd(false);
	}

	if (keyboard_check_pressed(vk_left) and not keyboard_check(vk_control))
	{
		wordLeftMarginDest += gridSpaceHorizontal;
	}
	if (keyboard_check_pressed(vk_left) and keyboard_check(vk_control)
	or keyboard_check_pressed(vk_home))
	{
		if (searchGridActive)
		{
			scr_jumpToEnd(true);
		}
		else
		{
			wordLeftMarginDest = speakerLabelMargin;
		}
	}
	
	if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("D")))
	{
		showDevVars = !showDevVars;
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

gridSpaceVertical = min(gridSpaceVertical, 303.40);
gridSpaceVertical = max(gridSpaceVertical, 23.40);

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