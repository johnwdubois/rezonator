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
	}

	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_up))
	{
		currentCenterDisplayRow = 0;
	}

	if (keyboard_check_pressed(vk_left))
	{
		wordLeftMarginDest -= gridSpaceHorizontal;
	}

	if (keyboard_check_pressed(vk_right))
	{
		wordLeftMarginDest += gridSpaceHorizontal;
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
	scr_refreshLineGridDisplayRow();
}

if (keyboard_check_pressed(ord("E")))
{
	scr_shuffleDisplayRows();
	scr_refreshLineGridDisplayRow();
}

currentCenterDisplayRow = max(currentCenterDisplayRow, 0);
currentCenterDisplayRow = min(currentCenterDisplayRow, ds_grid_height(currentActiveLineGrid) - 1);