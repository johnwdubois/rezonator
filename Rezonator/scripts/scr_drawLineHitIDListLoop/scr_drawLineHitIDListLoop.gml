var currentHitIDList = argument0;
var previousWordDisplayCol = argument1;
var currentLineY = argument2;
var drawLineLoop = argument3;


for (var drawWordLoop = 0; drawWordLoop < ds_list_size(currentHitIDList); drawWordLoop++)
{
	var currentHitID = ds_list_find_value(currentHitIDList, drawWordLoop);
	
	var currentWordID = ds_grid_get(hitGrid, hitGrid_colWordID, currentHitID);
	var currentWordDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentHitID);
		
	var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
	var currentWordX = ds_grid_get(hitGrid, hitGrid_colPixelX, currentHitID);
		
	if (currentWordX < currentWordDestX)
	{
		currentWordX += abs(currentWordX - currentWordDestX) / 6;
	}
	else if (currentWordX > currentWordDestX)
	{
		currentWordX -= abs(currentWordX - currentWordDestX) / 6;
	}
		
	ds_grid_set(hitGrid, hitGrid_colPixelX, currentHitID, currentWordX);
		
	var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID);
		
	var wordRectX1 = currentWordX;
	var wordRectY1 = currentLineY - (string_height(currentWordString) / 2);
	var wordRectX2 = wordRectX1 + string_width(currentWordString);
	var wordRectY2 = wordRectY1 + string_height(currentWordString);
		
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2))
	{
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
		if (mouse_check_button_pressed(mb_left))
		{
			with (obj_chain)
			{
				scr_wordClicked(currentHitID, drawLineLoop);
			}
		}
	}
		
	draw_set_alpha(1);
	draw_set_font(fnt_main);
	draw_set_color(wordColor);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(currentWordX, currentLineY, currentWordString);
		
	previousWordDisplayCol = currentWordDisplayCol;
}