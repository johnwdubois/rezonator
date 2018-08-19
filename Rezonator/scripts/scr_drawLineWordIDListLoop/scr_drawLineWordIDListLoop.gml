var currentWordIDList = argument0;
var previousWordDisplayCol = argument1;
var currentLineY = argument2;
var drawLineLoop = argument3;

var shapeTextX = wordLeftMargin;
var shapeTextSpace = 24;

for (var drawWordLoop = 0; drawWordLoop < ds_list_size(currentWordIDList); drawWordLoop++)
{
	var currentWordID = ds_list_find_value(currentWordIDList, drawWordLoop);
	var currentWordGridRow = currentWordID - 1;
	
	var currentWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow);
		
	if (drawWordLoop == 0 and not filterGridActive)
	{
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, 0);
	}
		
	if (drawWordLoop > 0 and not filterGridActive)
	{	
		if (currentWordDisplayCol - previousWordDisplayCol > 1)
		{
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol - 1);
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
		
	var wordRectX1 = currentWordX;
	var wordRectY1 = currentLineY - (string_height(currentWordString) / 2);
	var wordRectX2 = wordRectX1 + string_width(currentWordString);
	var wordRectY2 = wordRectY1 + string_height(currentWordString);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
	
	var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
	
	if (drawBorder)
	{
		var borderColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);
		draw_set_color(borderColor);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
	}
		
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2))
	{
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
		if (mouse_check_button_pressed(mb_left))
		{
			with (obj_chain)
			{
				scr_wordClicked(currentWordID, drawLineLoop);
			}
		}
	}
	
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