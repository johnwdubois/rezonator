var currentHitIDList = argument0;
var previousWordDisplayCol = argument1;
var currentLineY = argument2;
var drawLineLoop = argument3;

draw_set_alpha(1);

for (var drawWordLoop = 0; drawWordLoop < ds_list_size(currentHitIDList); drawWordLoop++)
{
	var currentHitID = ds_list_find_value(currentHitIDList, drawWordLoop);
	
	var currentWordID = ds_grid_get(hitGrid, hitGrid_colWordID, currentHitID - 1);
	var currentWordDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentHitID - 1);
		
	var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
	var currentWordX = ds_grid_get(hitGrid, hitGrid_colPixelX, currentHitID - 1);
	obj_control.leftScreenBound = min(currentWordX, obj_control.leftScreenBound);
		
	if (currentWordX < currentWordDestX)
	{
		currentWordX += abs(currentWordX - currentWordDestX) / 6;
	}
	else if (currentWordX > currentWordDestX)
	{
		currentWordX -= abs(currentWordX - currentWordDestX) / 6;
	}
		
	ds_grid_set(hitGrid, hitGrid_colPixelX, currentHitID - 1, currentWordX);
		
	var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID - 1);
		
	var wordRectX1 = currentWordX;
	var wordRectY1 = currentLineY - (string_height(currentWordString) / 2);
	var wordRectX2 = wordRectX1 + string_width(currentWordString);
	var wordRectY2 = wordRectY1 + string_height(currentWordString);
	
	
		
	if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2)) {
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
		if (mouse_check_button_pressed(mb_left)) {
			var newSwitch = ds_grid_get(hitGrid, hitGrid_colUnitID, currentHitID)
			with (obj_control) {
				preSwitchDisplayRow = newSwitch;
				highlightedSearchRow = newSwitch;
				
			}
		}
	}
	
	/*var speakerRectX1 = 0;
	var speakerRectY1 = highlightedSearchRow - (gridSpaceVertical / 2);
	var speakerRectX2 = speakerLabelMargin - speakerLabelMarginBuffer;
	var speakerRectY2 = speakerRectY1 + gridSpaceVertical;
	
	
	if (highlightedSearchRow == currentHitID) {
		//show_message(string(speakerRectX1) + ", " + string(speakerRectY1)+ ", " + string(speakerRectX2)+ ", " + string(speakerRectY2));
		draw_set_color(c_yellow);
			draw_set_alpha(0.5);
			
			var stackRectWidth = (room_width - speakerRectX2) / ds_list_size(currentHitIDList);
			var stackRectX1 = speakerRectX2;
			var stackRectY1 = speakerRectY1;
			var stackRectX2 = stackRectX1 + stackRectWidth;
			var stackRectY2 = speakerRectY2;
			//show_message(string(stackRectX1) + ", " + string(stackRectY1)+ ", " + string(stackRectX2)+ ", " + string(stackRectY2));
			
			draw_rectangle(0, wordRectY1 - 5, wordRectX2 + 500, wordRectY2 + 5, false);
	}*/
	
	ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordID - 1, true);
		
	draw_set_alpha(1);
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(currentWordX, currentLineY, currentWordString);
		
	previousWordDisplayCol = currentWordDisplayCol;
}