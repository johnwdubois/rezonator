var currentWordIDList = argument0;
var previousWordDisplayCol = argument1;
var currentLineY = argument2;
var drawLineLoop = argument3;
var unitID = argument4;

var shapeTextX = wordLeftMargin;
var shapeTextSpace = 12;

for (var drawWordLoop = 0; drawWordLoop < ds_list_size(currentWordIDList); drawWordLoop++)
{
	var currentWordID = ds_list_find_value(currentWordIDList, drawWordLoop);
	var currentWordGridRow = currentWordID - 1;
	
	var currentWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow);
		
	if (drawWordLoop == 0 and not filterGridActive)
	{
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, 0);
	}
		
	if (drawWordLoop > 0)// and not filterGridActive)
	{
		
		if (currentWordDisplayCol - previousWordDisplayCol > 1)
		{
			if (not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordDisplayCol - 1)
			and not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordDisplayCol - 1))
			{
				ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol - 1);
			}
			
		}
		
			
		if (previousWordDisplayCol >= currentWordDisplayCol)
		{
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol + 1);
		}
	}
		
	var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
	if (shape == shapeText)
	{
		currentWordDestX = shapeTextX;
	}
	
	var currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow);
		
	if (currentWordX < currentWordDestX)
	{
		currentWordX += abs(currentWordX - currentWordDestX) / 6;
	}
	else if (currentWordX > currentWordDestX)
	{
		currentWordX -= abs(currentWordX - currentWordDestX) / 6;
	}
		
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow, currentWordX);
		
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayWordSeq, currentWordGridRow, drawWordLoop);
		
	var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow);
		
	var wordRectBuffer = 2;
	var wordRectX1 = currentWordX - wordRectBuffer;
	var wordRectY1 = currentLineY - (string_height(currentWordString) / 2) - wordRectBuffer;
	var wordRectX2 = wordRectX1 + string_width(currentWordString) + (wordRectBuffer * 2);
	var wordRectY2 = wordRectY1 + string_height(currentWordString) + (wordRectBuffer * 2);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
	
	var drawFillRect = ds_grid_get(wordDrawGrid, wordDrawGrid_colFillRect, currentWordID - 1);
	var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
	var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
	var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);
	
	
	if (drawFillRect)
	{
		draw_set_color(effectColor);
		draw_set_alpha(0.25);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
		draw_set_alpha(1);
	}
	
	
	if (drawBorder)
	{
		var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1);
		draw_set_color(effectColor);
		
		for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++)
		{
			if (borderRounded)
			{
				draw_roundrect(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
			}
			else
			{
				draw_rectangle(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
			}
		}
	}
	
	if (drawFocused)
	{
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
	}
		
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and not (obj_toolPane.currentTool == obj_toolPane.toolNewWord))
	{
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
		if (mouse_check_button_pressed(mb_left))
		{
			with (obj_chain)
			{
				scr_wordClicked(currentWordID, unitID);//drawLineLoop);
			}
		}
	}
	
	if (obj_toolPane.currentTool == obj_toolPane.toolNewWord)
	{
		if (newWordHoverUnitID == unitID and newWordHoverWordSeq == ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1) and newWordHoverWordID == currentWordID)
		{
			draw_set_color(c_ltblue);
			draw_line_width(wordRectX2, wordRectY1, wordRectX2, wordRectY2, 2);
		}
		
		if (point_in_rectangle(mouse_x, mouse_y, wordRectX2, wordRectY1, wordRectX2 + gridSpaceHorizontal, wordRectY2))
		{
			newWordHoverUnitID = unitID;
			newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
			newWordHoverWordID = currentWordID;
			
			if (mouse_check_button_pressed(mb_left))
			{
				scr_newWord(newWordHoverUnitID, newWordHoverWordSeq);
			}
		}

	}
	
	ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordID - 1, true);
	
	var textColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colTextColor, currentWordID - 1);
		
	draw_set_alpha(1);
	draw_set_font(fnt_main);
	draw_set_color(textColor);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(currentWordX, currentLineY, currentWordString);
		
	previousWordDisplayCol = currentWordDisplayCol;
	
	shapeTextX += string_width(currentWordString) + shapeTextSpace;
}